class Admin::OrdersController < ApplicationController
	before_filter :admin_required
	layout "admin"
	 
	# GET /orders
  # GET /orders.xml
  def index
    @orders = Order.find(:all)
		 
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.xml
  def show
    @order = Order.find(params[:id])
   

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end
  

  # GET /orders/new
  # GET /orders/new.xml
  def new
    @order = Order.new
    @books = Book.find(:all)
		
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
    @books = Book.find(:all)
  end

  # POST /orders
  # POST /orders.xml
  def create
  	o =  [('a'..'z'),('A'..'Z'),(0..9)].map{|i| i.to_a}.flatten;  
		params[:order][:keycode]  =  (0..40).map{ o[rand(o.length)]}.join;
		@books = Book.find(:all)
  	if params[:order][:review_url]=='http://'
  		 params[:order][:review_url] = ''
  	end
    @order = Order.new(params[:order])
    @cart_items = Book.find(session[:cart_ids])

    respond_to do |format|
      if @order.save
      	session[:cart_ids]=[]
        #flash[:notice] = 'Order was successfully created.'
        format.html { redirect_to [:admin, @order] }
        format.xml  { render :xml => @order, :status => :created, :location => @order }
      else
      	flash[:error] = 'There was an error with your form.<br> Please correct the fields highlighted in red.'
        format.html { render :action => "new" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.xml
  def update
  	params[:order][:book_ids] ||= []
  	if params[:order][:review_url]=='http://'
  		 params[:order][:review_url] = ''
  	end
    @order = Order.find(params[:id])
		@books = Book.find(:all)
    respond_to do |format|
      if @order.update_attributes(params[:order])
        flash[:notice] = 'Order was successfully updated.'
        format.html { redirect_to([:admin, @order]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.xml
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(admin_orders_url) }
      format.xml  { head :ok }
    end
  end
end
