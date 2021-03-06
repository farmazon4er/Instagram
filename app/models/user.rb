# frozen_string_literal: true
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include ImageUploader::Attachment.new(:image)

  include PgSearch::Model
  pg_search_scope :search_by_user, against: :name

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :follower_follows, foreign_key: :following_id, class_name: "Follow", dependent: :destroy
  has_many :followers, through: :follower_follows, source: :follower, dependent: :destroy

  has_many :following_follows, foreign_key: :follower_id, class_name: "Follow", dependent: :destroy
  has_many :followings, through: :following_follows, source: :following, dependent: :destroy

  CONST_VALID_EMAIL = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 100},
            format: { with: CONST_VALID_EMAIL, message: 'Invalid email' }
  validates :name, presence: true, length: { maximum: 50 }
  validates :bio, presence: true, length: { maximum: 50 }

end
