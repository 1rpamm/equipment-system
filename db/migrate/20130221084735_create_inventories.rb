# -*- encoding : utf-8 -*-
class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.string :inv_num
      t.string :act_num
      t.references :act_type
      t.date :accept_date
      t.timestamps
    end
    add_index :inventories, :act_type_id
  end
end
