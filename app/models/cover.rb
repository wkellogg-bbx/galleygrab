class Cover < ActiveRecord::Base
  belongs_to :book
  
  has_attachment :content_type => :image,
  							 :processor    => :rmagick, 
                 :storage      => :file_system, 
                 :max_size     => 500.kilobytes,
                # :size				 => 1.kilobytes..1.kilobytes,
                 :resize_to    => '400x600>',
                 :thumbnails   => { 
                   :large =>  '182x273>',
                   :medium => '117x176>',
                   :small =>  '92x136>' 
                 }

  validates_as_attachment
end
