class CreateSiteReviews < ActiveRecord::Migration
  def self.up
    create_table :site_reviews do |t|
      t.boolean :approve
      t.text :comments

      t.timestamps
    end
  end

  def self.down
    drop_table :site_reviews
  end
end
