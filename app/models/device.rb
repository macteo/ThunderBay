class Device < ActiveRecord::Base
  belongs_to :app
  has_many  :messages
  self.primary_key = 'identifier'

  def user=(u)
    user = User.where(:token => u).first

    if user
      self.user_id = user.id
    end
  end
end
