# -*- encoding : utf-8 -*-
class ActType < ActiveRecord::Base
  after_create :reindex!
  after_update :reindex!

  has_many :inventories

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
