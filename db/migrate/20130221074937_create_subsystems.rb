# -*- encoding : utf-8 -*-
class CreateSubsystems < ActiveRecord::Migration
  def change
    create_table :subsystems do |t|
      t.references :device
      t.string :subvendor_hex
      t.string :subdevice_hex
      t.string :name
    end
    add_index :subsystems, :device_id
  end
end
