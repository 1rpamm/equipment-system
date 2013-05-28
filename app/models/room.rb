# -*- encoding : utf-8 -*-
class Room < ActiveRecord::Base
  after_create :reindex!
  after_update :reindex!

  scope :full_load, includes(:equipment)

  has_many :equipment, :order=>'equipment.domain_name'

  attr_accessible :name

  validates :name, presence: true, uniqueness: true

  searchable do
    text :name

    string  :sort_title do
      title.downcase.gsub(/^(an?|the)/, '')
    end
  end

  protected
  def reindex!
    Sunspot.index!(self)
  end
end
