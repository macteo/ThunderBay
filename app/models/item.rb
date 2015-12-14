class Item < ActiveRecord::Base
  belongs_to :venue
  mount_uploader :image, ImageUploader
  has_and_belongs_to_many :profiles
end
