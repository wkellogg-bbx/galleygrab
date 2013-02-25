class AddNewsletterToForm < ActiveRecord::Migration
  def self.up
    add_column :orders, :newsletter_optin, :boolean
  end
  
  def self.down
    remove_column :orders, :newsletter_optin
  end
end
