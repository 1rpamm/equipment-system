# -*- encoding : utf-8 -*-
class Device < ActiveRecord::Base
  scope :full_load, includes(:vendor)

  belongs_to :vendor
  has_many :details
  has_many :subsystems

  attr_accessible :device_hex, :name, :vendor_id

  validates :device_hex, presence: true, format: {with: /^0x(?:[0-9a-fA-F]{4})$/i}
  validates :name, presence: true
  validates :vendor_id, presence: true

  validates_uniqueness_of :device_hex, :scope => [:name, :vendor_id]
end
