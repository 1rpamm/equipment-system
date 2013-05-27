# -*- encoding : utf-8 -*-
class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :device_hex
      t.references :vendor
      t.string :name
    end
    add_index :devices, :vendor_id
  end
end
