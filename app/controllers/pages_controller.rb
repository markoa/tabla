class PagesController < ApplicationController

  before_filter :login_required

  # GET /pages
  # GET /pages.xml
  def index
    @pages = Page.find(:all)
    @pages.sort! { |a, b| b.last_updated_at <=> a.last_updated_at }

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.xml
  def show
    @page = Page.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /pages/new
  # GET /pages/new.xml
  def new
    @page = @user.pages.new
    @revision = @page.revisions.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
    @revision = @page.revisions.new
    @revision.content = @page.revisions.last.content
  end

  # POST /pages
  # POST /pages.xml
  def create
    @page = Page.new(params[:page])
    @revision = Revision.new(params[:revision])
    @page.revisions << @revision

    respond_to do |format|
      if @page.save and @revision.save
        flash[:notice] = 'Page was successfully created.'
        format.html { redirect_to(@page) }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.xml
  def update
    @page = Page.find(params[:id])
    @revision = Revision.new(params[:revision])
    @page.revisions << @revision

    respond_to do |format|
      Page.transaction do
        if @page.update_attributes(params[:page]) and @revision.save
          flash[:notice] = 'Page was successfully updated.'
          format.html { redirect_to(@page) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.xml
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to(pages_url) }
      format.xml  { head :ok }
    end
  end

  def sorted_by_date
    @pages = Page.find(:all)
    @pages.sort { |a, b| b.last_updated_at <=> a.last_updated_at }

    respond_to do |format|
      format.html { redirect_to :action => 'index' } #TODO: actually render smt
      format.xml  { render :xml => @pages }
      format.js do
        render :update do |page|
          page.replace_html 'pageList', :partial => 'date_separated'
        end
      end
    end
  end

  def sorted_by_name
    @pages = Page.find(:all)
    @pages.sort { |a, b| a.name <=> b.name }

    respond_to do |format|
      format.html { redirect_to :action => 'index' } #TODO: actually render smt
      format.xml  { render :xml => @pages }
      format.js do
        render :update do |page|
          page.replace_html 'pageList', :partial => 'list_dump'
        end
      end
    end
  end
end
