# -*- encoding : utf-8 -*-
class CreateDetails < ActiveRecord::Migration
  def change
    create_table :details do |t|
      t.references :vendor
      t.references :device
      t.references :subsystem
      t.string :rev
      t.string :serial
      t.datetime :accepted_at
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :details, :vendor_id
    add_index :details, :device_id
    add_index :details, :subsystem_id
  end
end
