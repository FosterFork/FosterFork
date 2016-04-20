class Category < ActiveRecord::Base
  has_many :projects
  validates_presence_of :name

  default_scope { order("priority DESC") }
end
