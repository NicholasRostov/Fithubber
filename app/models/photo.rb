class Photo < ApplicationRecord
  has_attached_file :image, :styles => { original: {:geometry => '300x300>', :source_file_options => '-auto-orient' } }
  belongs_to :user
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end
