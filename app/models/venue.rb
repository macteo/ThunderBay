class Venue < ActiveRecord::Base
  has_many :profiles
  has_many :regions
  has_many :items
end
