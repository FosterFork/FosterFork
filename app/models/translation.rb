class Translation < ActiveRecord::Base
  belongs_to :translatable, polymorphic: true

  validates_presence_of :translatable
  validates_presence_of :title
  validates :locale, presence: true, length: { maximum: 10 }
end
