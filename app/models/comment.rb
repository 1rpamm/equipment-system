# -*- encoding : utf-8 -*-
class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :equipment

  validates :body, :presence => true

  attr_accessible :body, :user_id, :equipment_id
end
