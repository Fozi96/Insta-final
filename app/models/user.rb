class User < ApplicationRecord
  mount_uploader :profile_image, ImageUploader

  validates :name, presence: true, length: { maximum: 30 }

  validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, on: :create
  before_validation { email.downcase! }

  has_secure_password

  validates :password, presence: true, length: { minimum: 6 }, on: :create

  validates :profile_content, length: { maximum: 120 }

  has_many :feeds

  has_many :favorites, dependent: :destroy
end
