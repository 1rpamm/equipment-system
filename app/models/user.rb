# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  has_many :equipment
  has_many :comments, :order => "comment.created_at"
  
  authenticates_with_sorcery!

  validates :login, presence: true, uniqueness: true, length: {maximum: 20}
  validates :name, presence: true, length: {maximum: 100}
  validates :email, presence: true, uniqueness: true, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}
  validates :admin_user, presence: true,inclusion: {in: 0..1}
  validates :admin_equip, presence: true,inclusion: {in: 0..1}
  validates :admin_inv, presence: true,inclusion: {in: 0..1}
  validates :responsible, presence: true,inclusion: {in: 0..1}
  validates :assistant, presence: true,inclusion: {in: 0..1}
  validates :password, confirmation: true, length: {minimum: 6}, on: :create

  attr_accessible  :name, :login, :email, :password, :password_confirmation, :admin_user, :admin_equip, :admin_inv, :responsible, :assistant

  searchable do
    integer :id
    text :name, :login, :email
    time :created_at
  end

  def admin_user?
    admin_user==1
  end

  def admin_equip?
    admin_equip==1
  end

  def admin_inv?
    admin_inv==1
  end

  def admin_responsible?
    responsible==1
  end
end
