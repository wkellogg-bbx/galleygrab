class Book < ActiveRecord::Base
	has_one :cover, :dependent => :destroy
	has_and_belongs_to_many :orders
	
	validates_presence_of :title, :author, :us_price, :can_price, :isbn_13, :short_descrip, :long_descrip,:position,:galley_url
	validates_numericality_of :position, :integer=>true
	validates_numericality_of :us_price, :can_price
	
	def to_param
    "#{id}-#{title.gsub(/\W/, '-').downcase}"
  end
end
