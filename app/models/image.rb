class Image < ActiveRecord::Base
  belongs_to :project

  has_attached_file :image, styles: { normal: "816x612>" }

  validates_presence_of :project
  validates_presence_of :image
  validates_presence_of :alt

  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

end
