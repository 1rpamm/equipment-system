# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130408103847) do

  create_table "act_types", :force => true do |t|
    t.string "name"
  end

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "equipment_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "comments", ["equipment_id"], :name => "index_comments_on_equipment_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "details", :force => true do |t|
    t.integer  "vendor_id"
    t.integer  "device_id"
    t.integer  "subsystem_id"
    t.string   "rev"
    t.string   "serial"
    t.datetime "accepted_at"
    t.datetime "deleted_at"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "details", ["device_id"], :name => "index_details_on_device_id"
  add_index "details", ["subsystem_id"], :name => "index_details_on_subsystem_id"
  add_index "details", ["vendor_id"], :name => "index_details_on_vendor_id"

  create_table "details_equipment", :id => false, :force => true do |t|
    t.integer "detail_id"
    t.integer "equipment_id"
  end

  add_index "details_equipment", ["detail_id", "equipment_id"], :name => "index_details_equipment_on_detail_id_and_equipment_id"
  add_index "details_equipment", ["equipment_id", "detail_id"], :name => "index_details_equipment_on_equipment_id_and_detail_id"

  create_table "devices", :force => true do |t|
    t.string  "device_hex"
    t.integer "vendor_id"
    t.string  "name"
  end

  add_index "devices", ["vendor_id"], :name => "index_devices_on_vendor_id"

  create_table "equipment", :force => true do |t|
    t.integer  "inventory_id"
    t.integer  "room_id"
    t.integer  "responsible_id"
    t.string   "domain_name"
    t.string   "md5sum"
    t.datetime "accepted_at"
    t.datetime "deleted_at"
    t.datetime "allow_del_at"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "equipment", ["inventory_id"], :name => "index_equipment_on_inventory_id"
  add_index "equipment", ["responsible_id"], :name => "index_equipment_on_responsible_id"
  add_index "equipment", ["room_id"], :name => "index_equipment_on_room_id"

  create_table "inventories", :force => true do |t|
    t.string   "inv_num"
    t.string   "act_num"
    t.integer  "act_type_id"
    t.date     "accept_date"
    t.text     "body"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "inventories", ["act_type_id"], :name => "index_inventories_on_act_type_id"

  create_table "rooms", :force => true do |t|
    t.string "name"
  end

  create_table "subsystems", :force => true do |t|
    t.integer "device_id"
    t.string  "subvendor_hex"
    t.string  "subdevice_hex"
    t.string  "name"
  end

  add_index "subsystems", ["device_id"], :name => "index_subsystems_on_device_id"

  create_table "users", :force => true do |t|
    t.string   "login",                                       :null => false
    t.string   "name",                                        :null => false
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.integer  "admin_user",                   :default => 0
    t.integer  "admin_equip",                  :default => 0
    t.integer  "admin_inv",                    :default => 0
    t.integer  "responsible",                  :default => 0
    t.integer  "assistant",                    :default => 0
    t.integer  "login_count",                  :default => 0
    t.datetime "last_login_at"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.datetime "deleted_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
  end

  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"

  create_table "vendors", :force => true do |t|
    t.string "vendor_hex"
    t.string "name"
  end

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
