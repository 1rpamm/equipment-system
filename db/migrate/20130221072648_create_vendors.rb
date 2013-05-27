# -*- encoding : utf-8 -*-
class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
      t.string :vendor_hex
      t.string :name
    end
  end
end
