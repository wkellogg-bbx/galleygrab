class BooksController < ApplicationController
  
  def show
  	
    @book = Book.find(params[:id])

    respond_to do |format|
    	
      format.html # show.html.erb
      format.xml  { render :xml => @book }
    end
  end

  
end
