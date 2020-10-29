class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  
  validates :posts, presence: true
  validates :image, presence: true

  belongs_to :user

end
