class Category < ActiveRecord::Base
  include Translatable

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :projects
  has_many :translations, as: :translatable, dependent: :destroy

  validates_presence_of :name
  validates_presence_of :color

  default_scope { order("priority DESC").includes(:translations) }

  accepts_nested_attributes_for :translations, allow_destroy: true
end
