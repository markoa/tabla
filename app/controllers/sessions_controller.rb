class SessionsController < ApplicationController

  before_filter :login_required, :except => [:new, :create]
  before_filter :check_registration_request, :only => [:new, :create]

  def new
  end

  def create
    session[:remember_me] = "1" if params[:remember_me] == "1"
    session[:registration_code] = params[:registration_code] unless params[:registration_code].blank?
    @open_id_url = params[:openid_identifier]

    if request.post? || using_open_id?
      authenticate_with_open_id(@open_id_url,
          :optional => [:nickname, :email]) do |result, identity_url, registration|
        if !result.successful?
          flash[:error] = result.message
          render :action => 'new'
        else
          identity_url_model = IdentityUrl.find_or_create_by_url(identity_url)
          if identity_url_model.user.nil?
            regcode = RegistrationCode.find_by_code(session[:registration_code])
            if regcode.nil?
              flash[:error] = "Sorry but you need to provide a valid registration code"
              @registration = true
              render :action => 'new' and return
            end

            identity_url_model.create_user && identity_url_model.save

            if identity_url_model.user.valid?
              flash.now[:notice] = "Wow you've signed up!"
            else
              flash[:error] = "Please set a nickname and email on your OpenID provider"
              render :action => 'new' and return
            end
          end

          self.current_user = identity_url_model.user
          assign_registration_attributes!(registration)

          regcode.assign_to self.current_user unless regcode.nil?
          session[:registration_code] = nil

          if session[:remember_me] == "1"
            self.current_user.remember_me
            cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
            session[:remember_me] = nil
          end

          redirect_to root_path
        end
      end
    else
      render :action => 'new'
    end
  end

  def destroy
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    redirect_to root_path
  end

  private

  # registration is a hash containing the valid sreg keys given above
  # use this to map them to fields of your user model
  def assign_registration_attributes!(registration)
    model_to_registration_mapping.each do |model_attribute, registration_attribute|
      unless registration[registration_attribute].blank?
        @current_user.send("#{model_attribute}=", registration[registration_attribute])
      end
    end

    @current_user.save
  end

  def model_to_registration_mapping
    { :nickname => 'nickname', :email => 'email' }
  end

  protected

  def check_registration_request
    @registration = params[:registration_code] || params[:registration]
  end

end
