class Region < ActiveRecord::Base
  enum type: [:beacon, :geofence]
  enum behavior: [:monitor, :range]

  belongs_to :venue

  # To be able to use type as parameter
  self.inheritance_column = :_type_disabled
end
