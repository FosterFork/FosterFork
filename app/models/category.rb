class Category < ActiveRecord::Base
  include Translatable

  has_many :projects
  has_many :translations, as: :translatable, dependent: :destroy

  validates_presence_of :name

  default_scope { order("priority DESC").includes(:translations) }

  accepts_nested_attributes_for :translations, allow_destroy: true
end
