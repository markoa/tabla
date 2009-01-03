class RegistrationCodesController < ApplicationController

  before_filter :login_required

  def index
    @reg_codes = RegistrationCode.find(:all, :conditions => { :creator_id => @user.id })
  end

  def new
    RegistrationCode.generate(@user)
    redirect_to registration_codes_url
  end

  def destroy
    reg_code = RegistrationCode.find(params[:id])
    reg_code.destroy

    redirect_to registration_codes_url
  end

end
