class RevisionsController < ApplicationController

  before_filter :load_page

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

  protected

  def load_page
    @page = Page.find(params[:page_id])
  end

end
