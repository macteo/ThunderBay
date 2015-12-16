class Device < ActiveRecord::Base
  belongs_to :app
  belongs_to :user
  has_many  :messages

  validates :name, presence: true
  validates :identifier, presence: true
  validates :app, presence: true

  self.primary_key = 'identifier'

  def user=(u)
    user = User.where(:token => u).first

    if user
      self.user_id = user.id
    end
  end
end
