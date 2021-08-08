# frozen_string_literal: true
class Post < ApplicationRecord
  include ImageUploader::Attachment.new(:image)
  belongs_to :user
  has_many :comments
  has_many :likes

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :body, length: { maximum: 150 }
  validates :image_data, presence: true
end
