module GalleysHelper
	
	def cover_for(book, size = :medium)
    if book.cover 
      cover_image = book.cover.public_filename(size)
    
      
      link_to_function "#{image_tag(cover_image, :class=>'cover_link', :alt=>"" )}<span>CLICK FOR DETAILS</span>", "this.blur(); Modalbox.show(this.href, {title:'  &nbsp;',width: 540,height:540, transitions:false, closeValue:'CLOSE X'});", :class=>"info", :href=>"#{book_path(book)}"
      #link_to_remote book.title,    							:url => {:action=> book_path(book)},       							:complete => "this.blur(); Modalbox.show(this.href, {title:'  &nbsp;',width: 600, transitions:false, closeValue:'CLOSE X'}); return false;"
      #link_to image_tag(cover_image, :class=>'cover_link'), book_path(book)
    else
      image_tag("blank-cover-#{size}.png")
    end
  end
  
  def cover_for_added(book, size = :medium)
    if book.cover 
      cover_image = book.cover.public_filename(size)
       
      
      link_to_function image_tag('added_ribbon_117x176_test.gif', :class=>'cover_link', :alt=>'',  :style=> "background:url(#{cover_image}); width:116px; height:176px;" ), "this.blur(); Modalbox.show(this.href, {title:'  &nbsp;',width: 540,height:540, transitions:false, closeValue:'CLOSE X'});", :href=>"#{book_path(book)}"
      #link_to_remote book.title,    							:url => {:action=> book_path(book)},       							:complete => "this.blur(); Modalbox.show(this.href, {title:'  &nbsp;',width: 600, transitions:false, closeValue:'CLOSE X'}); return false;"
      #link_to image_tag(cover_image, :class=>'cover_link'), book_path(book)
    else
      image_tag("blank-cover-#{size}.png")
    end
  end
  
  def cover_for_nolink(book, size = :small)
    if book.cover 
      cover_image = book.cover.public_filename(size)
     	image_tag(cover_image, :size=>"92x136")
    else
      image_tag("blank-cover-#{size}.png")
    end
  end
  
  def cover_for_admin(book, size = :small)
    if book.cover 
      cover_image = book.cover.public_filename(size)
      link_to image_tag(cover_image, :class=>'cover_link'), book_path(book)
    else
      image_tag("blank-cover-#{size}.png")
    end
  end
  def cover_for_preload(book, size = :medium)
    if book.cover 
      cover_image = book.cover.public_filename(size)
      image_tag(cover_image, :class=>'hiddenpic')
    else
      image_tag("blank-cover-#{size}.png")
    end
  end
  

end
