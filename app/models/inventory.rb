# -*- encoding : utf-8 -*-
class Inventory < ActiveRecord::Base
  scope :full_load, includes(:act_type)

  belongs_to :act_type
  belongs_to :equipment

  attr_accessible :accept_date, :act_num, :inv_num, :act_type_id, :body

  validates :act_type_id, presence: true
  validates :act_num, presence: true, uniqueness: true
  validates :inv_num, presence: true, uniqueness: true
  validates :accept_date, presence: true
end
