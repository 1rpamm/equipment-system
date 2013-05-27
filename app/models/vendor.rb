# -*- encoding : utf-8 -*-
class Vendor < ActiveRecord::Base
  has_many :devices
  has_many :subsystems
  has_many :details

  attr_accessible :vendor_hex, :name

  validates :vendor_hex, presence: true, uniqueness: true, format: {with: /^0x(?:[0-9a-fA-F]{4})$/i}
  validates :name, presence: true
  validates_uniqueness_of :vendor_hex, :scope => [:name]
end
