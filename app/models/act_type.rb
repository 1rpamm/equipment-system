# -*- encoding : utf-8 -*-
class ActType < ActiveRecord::Base
  has_many :inventories

  attr_accessible :name

  validates :name, presence: true, uniqueness: true

  searchable do
    text :name
    integer :id
  end
end
