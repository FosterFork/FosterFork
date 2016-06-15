class LayoutImage < ActiveRecord::Base
  validates_presence_of :page
  validates_presence_of :image
  has_attached_file :image, styles: { normal: "816x612>" }
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end
