# -*- encoding : utf-8 -*-
class CreateActTypes < ActiveRecord::Migration
  def change
    create_table :act_types do |t|
      t.string :name
    end
  end
end
