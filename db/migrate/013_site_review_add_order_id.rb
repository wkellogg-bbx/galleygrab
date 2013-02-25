class SiteReviewAddOrderId < ActiveRecord::Migration
  def self.up
    add_column :site_reviews, :order_id, :integer
  end

  def self.down
    remove_column :site_reviews, :order_id
  end
end
