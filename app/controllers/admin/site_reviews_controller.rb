class Admin::SiteReviewsController < ApplicationController
  
	before_filter :admin_required
	layout "admin"

	# GET /site_reviews
  # GET /site_reviews.xml
  def index
    @site_reviews = SiteReview.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @site_reviews }
    end
  end

  # GET /site_reviews/1
  # GET /site_reviews/1.xml
  def show
    @site_review = SiteReview.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @site_review }
    end
  end

  # GET /site_reviews/new
  # GET /site_reviews/new.xml
  def new
    @site_review = SiteReview.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @site_review }
    end
  end

  # GET /site_reviews/1/edit
  def edit
   @site_review = SiteReview.find(params[:id])
  end

  # POST /site_reviews
  # POST /site_reviews.xml
  def create
    @site_review = SiteReview.new(params[:site_review])

    respond_to do |format|
      if @site_review.save
      	
        #flash[:notice] = 'SiteReview was successfully created.'
        format.html { redirect_to [:admin, @site_review] }
        #format.html { redirect_to(@site_review) }
        format.xml  { render :xml => @site_review, :status => :created, :location => @site_review }
        format.js
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @site_review.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /site_reviews/1
  # PUT /site_reviews/1.xml
  def update
     @site_review = SiteReview.find(params[:id])

    respond_to do |format|
      if @site_review.update_attributes(params[:site_review])
        flash[:notice] = 'SiteReview was successfully updated.'
        format.html { redirect_to([:admin, @site_review]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @site_review.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /site_reviews/1
  # DELETE /site_reviews/1.xml
  def destroy
    @site_review = SiteReview.find(params[:id])
    @site_review.destroy

    respond_to do |format|
      format.html { redirect_to(admin_site_reviews_url) }
      format.xml  { head :ok }
    end
  end
end
