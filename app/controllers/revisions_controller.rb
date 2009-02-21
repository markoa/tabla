class RevisionsController < ApplicationController

  before_filter :load_page

  include HTMLDiff

  # GET /revisions
  # GET /revisions.xml
  def index
    @revisions = @page.revisions.sort { |a, b| b.created_at <=> a.created_at }

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @revisions }
    end
  end

  # GET /revisions/1
  # GET /revisions/1.xml
  def show
    @revision = Revision.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @revision }
    end
  end

  # GET /revisions/compare?compare[]=11&compare[]=10
  def compare
    unless params[:compare] && params[:compare].length == 2
      flash[:error] = "I need to know which two revisions to compare"
      redirect_to page_revisions_path(@page) and return
    end

    revs = params[:compare].collect { |r| r.to_i }.sort { |a, b| a <=> b }
    @rev_from = Revision.find(revs.first)
    @rev_to = Revision.find(revs.last)

    @content = diff(@rev_from.content, @rev_to.content)

  rescue ActiveRecord::RecordNotFound => e
    logger.error e
    flash[:error] = "Could not find those revisions in the database"
    redirect_to page_revisions_path(@page)
  end

  protected

  def load_page
    @page = Page.find(params[:page_id])
  end

end
