class Photo < ApplicationRecord
  has_attached_file :image
  belongs_to :user
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end
