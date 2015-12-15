class Venue < ActiveRecord::Base
  has_many :profiles
  has_many :regions
  has_many :items
  has_many :events

  def channel_name
    return CGI.escape("#{id}-#{name}")
  end

  def send_inside_status_change_notification(profile)
    cashiers = self.profiles.where.not(role: 0)
    cashiers.each do |cashier|
      cashier.user.send_inside_status_change_notification(profile)
    end
  end
end
