class SiteReviewsController < ApplicationController

	before_filter :load_order
	
	def load_order
    @order = Order.find(params[:order_id])
  end



  # GET /site_reviews/new
  # GET /site_reviews/new.xml
  def new
    @site_review = @order.site_reviews.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @site_review }
    end
  end


  # POST /site_reviews
  # POST /site_reviews.xml
  def create
    @site_review = @order.site_reviews.build(params[:site_review])

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

  
end
