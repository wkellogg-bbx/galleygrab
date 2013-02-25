class Admin::HomeController < ApplicationController
	
	before_filter :admin_required
	layout "admin"
	require 'fastercsv'
	def index
	
	end
	
	def counts
		@books_ordered = BooksOrders.count(:all)
		@orders = Order.count(:all)
		@opt_ins = Order.count(:all, :conditions=> {:opt_in => true})
		@last_order = Order.find(:first, :order=>"created_at DESC")
		@reviewer_orders = Order.count(:all, :conditions => {:purchaser_type => "Reviewer"})
		@bookseller_orders = Order.count(:all, :conditions => {:purchaser_type => "Bookseller"})
		@librarian_orders = Order.count(:all, :conditions => {:purchaser_type => "Librarian"})
		@trade_orders = Order.count(:all, :conditions => {:purchaser_type => "Trade"})
		@site_reviews = SiteReview.count(:all)
		@site_reviews_good = SiteReview.count(:all, :conditions => {:approve => true})
		@site_reviews_bad = SiteReview.count(:all, :conditions => {:approve => false})
		@newsletter_optins = Order.count(:all, :conditions=> {:newsletter_optin => true})
	end
	
	def data_export_form
		@orders = Order.count(:all)
	end
	
	def data_export
		@lower = params[:lower].to_i
		@upper = params[:upper].to_i
		@limit = @upper - @lower + 1
		@orders = Order.find(:all, :include=>[:books, :site_reviews], :order=>"orders.created_at ASC", :limit=>@limit, :offset=>@lower-1)
		#for testing
		#@orders = Order.find(:all, :limit=>5)
		@count = @orders.size
		@top = @count + @lower - 1
	  csv_string = FasterCSV.generate do |csv|
	    # header row
	    csv << ["id", "First Name", "Last Name","Type", "Store/Company", "Address", "City", "State", "Zip","Email","Opt-In", "Time Order Placed (EST)", "Book 1", "Book 2", "Book 3", "I would use the Galley Grab again in the future.", "Comments about Galley Grab" ]
	
	    # data rows  
	    @orders.each do |order|
	    	
	    #	order.books do |book|
	    #		@books += book.title
	    #	end
	      csv << [order.id, order.first_name, order.last_name, order.purchaser_type, order.store, order.address1, order.city, order.state, order.zip, order.email, order.opt_in, (order.created_at-14400).strftime("%A, %B %d, %Y %I:%M:%S %p"), (order.books[0].nil? ? "" : order.books[0].title),
	      (order.books[1].nil? ? "" : order.books[1].title),
	      (order.books[2].nil? ? "" : order.books[2].title),
	      (order.site_reviews[0].nil? ? "" : order.site_reviews[0].approve),
	      (order.site_reviews[0].nil? ? "" : order.site_reviews[0].comments),
	      order.newsletter_optin
	      
         ]
	    end
	  end
	
	  # send it to the browser
	  send_data csv_string,
	        :type => 'text/csv; charset=iso-8859-1; header=present',
	        :disposition => "attachment; filename=orders_#{@lower}_#{@top}.csv"
	end
	
	

end
