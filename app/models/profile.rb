class Profile < ActiveRecord::Base
  enum role: [:customer, :clerk, :cashier]
  belongs_to :user
  belongs_to :venue
end
