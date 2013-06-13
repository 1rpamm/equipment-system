# -*- encoding : utf-8 -*-
class Equipment < ActiveRecord::Base
  has_paper_trail

  scope :full_load, includes(:inventory, :room, :responsible, :details)

  belongs_to :inventory
  belongs_to :room
  belongs_to :responsible, :class_name => "User"
  has_and_belongs_to_many :details
  has_many :comments, :order => 'comments.created_at', :dependent => :destroy

  accepts_nested_attributes_for :details, :allow_destroy => true

  attr_accessible :inventory_id, :room_id, :responsible_id, :details, :domain_name, :accepted_at, :allow_del_at, :deleted_at, :md5sum, :detail_tokens,:detail_attributes

  validates :room_id, presence: true
  validates :responsible_id, presence: true
  validates :domain_name, presence: true
  validates :inventory_id, presence: true

  attr_reader :detail_tokens

  def detail_tokens=(ids)
    self.detail_ids=ids.split(',')
  end

  searchable do
    #integer :id
    text :comments do
      comments.map { |comment| comment.body }
    end
    text :domain_name
    #integer :inventory_id, :room_id, :responsible_id
    #integer :detail_ids, :multiple => true
    time    :accepted_at, :deleted_at
    #time    :created_at
  end
end
