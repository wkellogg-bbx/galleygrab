class OrdersController < ApplicationController
  
	
  def welcome
  	#render :layout => 'welcome'
  	@welcome=true
		@preload = Book.find(:all, :order=>"position ASC")
  end

   
  def confirmation
    @order = Order.find_by_keycode(params[:id])
    @site_review = SiteReview.new
    
    
    
    #@top_books = BooksOrders.find(:all, :group=> "books_orders.book_id", :order=>"count(books_orders.book_id) DESC", :limit=>3)
    
		@top_books = BooksOrders.find_by_sql("SELECT books_orders.book_id, count(books_orders.book_id) FROM books_orders Group By books_orders.book_id ORDER BY count(books_orders.book_id) DESC LIMIT 3")
		
		
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end
  
  def catalog
  	
  	@catalog = true
  	#might be better way to do this
  	if !(session[:cart_ids].class == Array)
  		#if session not an array yet, make it an empty array
  		# to avoid adding elements to an object that is not an array
  		session[:cart_ids]=[]
  	end
  	  	
  	@books = Book.find(:all, :order=>"position ASC")
  	@cart_items = Book.find(session[:cart_ids])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end
  
  def cart_filled
  	#might be better way to do this
  	if !(session[:cart_ids].class == Array)
  		#if session not an array yet, make it an empty array
  		# to avoid adding elements to an object that is not an array
  		session[:cart_ids]=[]
  	end
  	@cart_items = Book.find(session[:cart_ids])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end
  
  
  def remove_item_from_cart
   	@item = params[:book]
  	if session[:cart_ids].include?(@item)
  	 session[:cart_ids]= session[:cart_ids] - [@item]
  	end
  	
  	respond_to do |format|
      format.html { redirect_to :back }
      format.xml  { render :xml => @order }
      format.js
    end
   	#redirect_to :back
  end
  
  def add_item_to_cart
  	@item = params[:book]
  	if (session[:cart_ids].length < 3)
	  	if !session[:cart_ids].include?(@item)
	  	 session[:cart_ids]= session[:cart_ids] << @item
	  	end
	  #else
	  #	flash[:notice]='You have already chosen 5 items, please remove an item from your cart if you would like to add another'
	  end	
	  respond_to do |format|
      format.html { redirect_to :back }
      format.xml  { render :xml => @order }
      format.js
    end	
   	
  end
  

  

  # GET /orders/new
  # GET /orders/new.xml
  def new
    @order = Order.new
    if !(session[:cart_ids].class == Array)
  		#if session not an array yet, make it an empty array
  		# to avoid adding elements to an object that is not an array
  		session[:cart_ids]=[]
  	end
		@cart_items = Book.find(session[:cart_ids])
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @order }
    end
  end

  

  # POST /orders
  # POST /orders.xml
  def create
  	o =  [('a'..'z'),('A'..'Z'),(0..9)].map{|i| i.to_a}.flatten;  
		params[:order][:keycode]  =  (0..40).map{ o[rand(o.length)]}.join;
	#	if params[:order][:review_url]=='http://'
  #		 params[:order][:review_url] = ''
  #	end  	
  	
  	#joseph
  	saveOrder = true
		@orderExist = Order.find_by_email(params[:order][:email])
		if !@orderExist.nil?
			@books = BooksOrders.find_all_by_order_id(@orderExist.id)
			if !@books.nil?
				if @books.length == 3
					#flash[:error] = 'You have exceeded the maximum books allowed to order.  Please email us for more information.  Thank you!'
					saveOrder = false
				end
			end
		end 
		#end joseph
  	
  	
   	@order = Order.new(params[:order])
     @cart_items = Book.find(session[:cart_ids])
	   
     respond_to do |format|
       if saveOrder && @order.save
       	session[:cart_ids]=[]
         #flash[:notice] = 'Order was successfully created.'
         format.html { redirect_to confirmation_path(params[:order][:keycode]) }
         format.xml  { render :xml => @order, :status => :created, :location => @order }
       else
       	 if saveOrder
       	 		flash[:error] = 'There was an error with your form.<br> Please correct the fields highlighted in red.'	
       	 else
       	 		flash[:error] = 'You have already ordered the maximum number of books.'
       	 end
  
         format.html { render :action => "new" }
         format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
       end
     end

  end
end
