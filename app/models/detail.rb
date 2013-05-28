# -*- encoding : utf-8 -*-
class Detail < ActiveRecord::Base
  scope :full_load, includes(:vendor, :device, :subsystem)

  belongs_to :vendor
  belongs_to :device
  belongs_to :subsystem
  has_many :equipment

  attr_accessible :vendor_id, :device_id, :subsystem_id, :rev, :serial, :accepted_at, :deleted_at

  validates :vendor_id, presence: true
  validates :device_id, presence: true
  validates :rev, presence: true
  validates :serial, presence: true

  validates_uniqueness_of :serial, :scope => [:vendor_id, :device_id, :subsystem_id, :rev]

  searchable do
    text    :rev, :serial
    integer :vendor_id, :device_id, :subsystem_id
    time    :created_at
  end
end
