# -*- encoding : utf-8 -*-
class SorceryCore < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :login,            :null => false
      t.string :name,             :null => false  # if you use another field as a username, for example email, you can safely remove this field.
      t.string :email,            :default => nil # if you use this field as a username, you might want to make it :null => false.
      t.string :crypted_password, :default => nil
      t.string :salt,             :default => nil
      #role permissions
      t.integer :admin_user,      :default => 0
      t.integer :admin_equip,     :default => 0
      t.integer :admin_inv,       :default => 0
      t.integer :responsible,      :default => 0
      t.integer :assistant,       :default => 0
      #login counters
      t.integer :login_count,     :default => 0
      t.datetime :last_login_at,  :default => nil
      #timestamps
      t.timestamps
      t.datetime :deleted_at,     :default => nil
    end
  end

  def self.down
    drop_table :users
  end
end
