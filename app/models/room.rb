# -*- encoding : utf-8 -*-
class Room < ActiveRecord::Base
  scope :full_load, includes(:equipment)

  has_many :equipment, :order=>'equipment.domain_name'

  attr_accessible :name

  validates :name, presence: true, uniqueness: true

  searchable do
    #integer :id
    text :name
  end
end
