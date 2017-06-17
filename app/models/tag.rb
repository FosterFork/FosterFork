class Tag < ActiveRecord::Base
  include Translatable

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_and_belongs_to_many :projects
  has_many :translations, as: :translatable, dependent: :destroy

  validates_presence_of :name
  validates_presence_of :color

  accepts_nested_attributes_for :translations, allow_destroy: true
end
