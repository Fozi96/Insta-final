class Post < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :image,  presence: true

  validates :content,  presence: true

  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :favorite_user, through: :favorites, source: :user
end
