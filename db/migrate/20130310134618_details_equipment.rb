# -*- encoding : utf-8 -*-
class DetailsEquipment < ActiveRecord::Migration
  def up
    create_table :details_equipment, :id => false do |t|
      t.references :detail
      t.references :equipment
    end
    add_index :details_equipment, [:detail_id, :equipment_id]
    add_index :details_equipment, [:equipment_id, :detail_id]
  end

  def down
    drop_table :details_equipment
  end
end
