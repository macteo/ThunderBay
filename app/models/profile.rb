class Profile < ActiveRecord::Base
  enum role: [:Customer, :Clerk, :Cashier]
  belongs_to :user
  belongs_to :venue
  has_and_belongs_to_many :items

end
