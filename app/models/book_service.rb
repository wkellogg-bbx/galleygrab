class BookService
  
  attr_reader :book, :cover
  
  def initialize(book, cover)
    @book = book
    @cover = cover
  end
  
  def save
    return false unless valid?
    begin
      Book.transaction do
        if @cover.new_record?
          @book.cover.destroy if @book.cover
          @cover.book = @book
          @cover.save!
        end
        @book.save!
        true
      end
    rescue
      false
    end
  end

  def valid?
    @book.valid? && @cover.valid?
  end
  
  
  
  def update_attributes(book_attributes, cover_file)
    @book.attributes = book_attributes
    unless cover_file.blank?
      @cover = Cover.new(:uploaded_data => cover_file)
    end
    save
  end
  
  

end

