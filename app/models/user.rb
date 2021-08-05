class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts
  CONST_VALID_EMAIL = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 100},
            format: { with: CONST_VALID_EMAIL, message: 'Invalid email' }
  validates :name, presence: true, length: { maximum: 50 }
  validates :bio, presence: true, length: { maximum: 50 }

end
