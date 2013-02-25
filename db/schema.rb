# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 17) do

  create_table "books", :force => true do |t|
    t.string   "title"
    t.string   "subtitle"
    t.string   "author"
    t.date     "pubdate"
    t.float    "us_price"
    t.float    "can_price"
    t.string   "isbn_13"
    t.text     "short_descrip"
    t.text     "long_descrip"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "marketing"
    t.text     "selling_point"
    t.string   "format"
    t.boolean  "book_available_now"
    t.string   "preview_info_overide"
    t.string   "preview_format"
    t.boolean  "preview_available_now"
    t.date     "ship_date"
    t.string   "publisher"
    t.string   "contact_name"
    t.string   "contact_email"
    t.string   "galley_url"
    t.string   "editor_name"
    t.string   "editor_email"
    t.string   "marketing_name"
    t.string   "marketing_email"
  end

  create_table "books_orders", :id => false, :force => true do |t|
    t.integer  "book_id"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "covers", :force => true do |t|
    t.integer  "book_id"
    t.integer  "parent_id"
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.string   "content_type"
    t.string   "filename"
    t.string   "thumbnail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "store"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "email"
    t.boolean  "opt_in"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "keycode"
    t.string   "purchaser_type"
    t.boolean  "eula"
    t.string   "review_url"
    t.string   "phone"
    t.boolean  "newsletter_optin"
  end

  create_table "site_reviews", :force => true do |t|
    t.boolean  "approve"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_id"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
  end

end
