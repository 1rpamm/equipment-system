# -*- encoding : utf-8 -*-
class ActType < ActiveRecord::Base
  has_many :inventories

  attr_accessible :name

  validates :name, presence: true, uniqueness: true
end
