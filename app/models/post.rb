class Post < ApplicationRecord
  include ImageUploader::Attachment.new(:image)
  belongs_to :user
  validates :title, presence: true, length: { maximum: 50 }
  validates :body, length: { maximum: 150 }
  validates :image_data, presence: true

end
