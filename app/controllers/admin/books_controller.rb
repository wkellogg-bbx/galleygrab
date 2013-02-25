class Admin::BooksController < ApplicationController
 	before_filter :admin_required
 	layout "admin"
	# GET /books
  # GET /books.xml
  def index
    @books = Book.find(:all)
		
    @book_counts = BooksOrders.count(:all, :group=> :book_id)
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @books }
    end
  end

  # GET /books/1
  # GET /books/1.xml
  def show
    
    @book = Book.find(params[:id])
		@book_count = BooksOrders.count(:all,:conditions=>{:book_id => @book.id})
    respond_to do |format|
      
      format.html # show.html.erb
      format.xml  { render :xml => @book }
    end
  end

  # GET /books/new
  # GET /books/new.xml
  def new
    @book = Book.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @book }
    end
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
  end

  # POST /books
  # POST /books.xml
  def create
    @book = Book.new(params[:book])
    @cover = Cover.new(:uploaded_data => params[:cover_file])
    
    @service = BookService.new(@book, @cover)
    sleep 10
    respond_to do |format|
      if @service.save
        flash[:notice] = 'Book was successfully created.'
        format.html { redirect_to([:admin, @book]) }
        format.xml  { render :xml      => @book, 
                             :status   => :created, 
                             :location => @book }
      else
        format.html { render :action => :new }
        format.xml  { render :xml    => @book.errors, 
                             :status => :unprocessable_entity }
      end
    end
  end
  

  
  def update
    @book = Book.find(params[:id])
    @cover = @book.cover
    
    @service = BookService.new(@book, @cover)
    sleep 10
    respond_to do |format|
      if @service.update_attributes(params[:book], params[:cover_file])
        flash[:notice] = 'book was successfully updated.'
        format.html { redirect_to [:admin, @book] }
        format.xml  { head :ok }
      else
        @cover = @service.cover
        format.html { render :action => :edit }
        format.xml  { render :xml    => @book.errors, 
                             :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.xml
  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      format.html { redirect_to(admin_books_url) }
      format.xml  { head :ok }
    end
  end
end
