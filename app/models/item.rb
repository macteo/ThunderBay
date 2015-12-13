class Item < ActiveRecord::Base
  belongs_to :venue
  mount_uploader :image, ImageUploader
end
