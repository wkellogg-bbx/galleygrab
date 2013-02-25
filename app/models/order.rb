class Order < ActiveRecord::Base
	has_and_belongs_to_many :books
	has_many :site_reviews
	
	EMAIL_PATTERN = /(\S+)@(\S+)\.(\S+)/
	#PHONE_PATTERN = /^\(?([1-9]\d{2})(\) ?|[.-])?(\d{3})[.-]?(\d{4})([A-Za-z0-9\s]{1,25})?$/i
	US_POSTAL = /(^\d{5}(-\d{4})?$)/
	CANADIAN_POSTAL = /^([ABCEGHJKLMNPRSTVXYabceghjklmnprstvxy]{1}\d{1}[A-Za-z]{1} *\d{1}[A-Za-z]{1}\d{1}$)/
	validates_presence_of :first_name, :last_name, :address1, :city, :state, :email,  :eula, :zip, :store
	
	#validates_presence_of :review_url, :if => :reviewer?
	#validates_presence_of :store, :if => :bookseller?
	#validates_numericality_of :zip, :only_integer => true, :greater_than=>9999, :less_than => 100000
	
	#validates_format_of :phone, :with => PHONE_PATTERN
	validates_length_of :zip, :within => 5..10, :if => :usausa?
	validates_format_of :zip, :with => US_POSTAL , :if => :usausa?
	validates_length_of :zip, :within => 6..7, :if => :canadian?
	validates_format_of :zip, :with => CANADIAN_POSTAL, :if => :canadian?
	
	
	validates_format_of :email, :with => EMAIL_PATTERN
	
	protected
		#def reviewer?
		#	purchaser_type.eql? "Reviewer"
		#end
		
		#def bookseller?
		#	purchaser_type.eql? "Bookseller"
		#end
		
		def canadian?
			province = ["AB","BC","MB","NB","NF","NT","NS","NU","ON","PE","QC","SK","YT"]
			province.include?(state)
		end
		def usausa?
			!canadian?
		end
		
end
