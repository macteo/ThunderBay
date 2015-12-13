class Venue < ActiveRecord::Base
  has_many :profiles
  has_many :regions
  has_many :items
  has_many :events

  def channel_name
    return CGI.escape("#{id}-#{name}")
  end
end
