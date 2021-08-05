class Post < ApplicationRecord
  include ImageUploader::Attachment.new(:image)
  validates :title, presence: true, length: { maximum: 50 }
  validates :body, length: { maximum: 150 }
  validates :image_data, presence: true

end
