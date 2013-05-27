# -*- encoding : utf-8 -*-
class CreateEquipment < ActiveRecord::Migration
  def change
    create_table :equipment do |t|
      t.references :inventory
      t.references :room
      t.references :responsible
      t.string :domain_name
      t.string :md5sum
      t.datetime :accepted_at
      t.datetime :deleted_at
      t.datetime :allow_del_at

      t.timestamps
    end
    add_index :equipment, :inventory_id
    add_index :equipment, :room_id
    add_index :equipment, :responsible_id
  end
end
