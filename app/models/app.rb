class App < ActiveRecord::Base
  has_many :devices
  has_many :events
  
  self.primary_key = 'identifier'

  def sandbox=
  end

  def sandbox
    if self.environment == "production"
      return false
    else
      return true
    end
  end
end
