class Recipe < ApplicationRecord
    belongs_to :user
    validates :title, presence: true, length: { maximum: 30 }
    validates :material, presence: true
    validates :cooking_time, presence: true, length: { maximum: 30 }
    validates :process, presence: true
    mount_uploader :image, ImageUploader
end
