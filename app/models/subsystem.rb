# -*- encoding : utf-8 -*-
class Subsystem < ActiveRecord::Base
  scope :full_load, includes(:device)

  belongs_to :device
  belongs_to :subvendor
  belongs_to :subdevice
  has_many :details

  attr_accessible :name, :device_id, :subvendor_hex, :subdevice_hex

  validates :name, presence: true
  validates :device_id, presence: true
  validates :subvendor_hex, presence: true, format: {with: /^0x(?:[0-9a-fA-F]{4})$/i}
  validates :subdevice_hex, presence: true, format: {with: /^0x(?:[0-9a-fA-F]{4})$/i}

  validates_uniqueness_of :name, :scope => [:device_id, :subvendor_hex, :subdevice_hex]
end
