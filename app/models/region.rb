class Region < ActiveRecord::Base
  # To be able to use type as parameter
  self.inheritance_column = :_type_disabled
  
  enum type: [:Beacon, :Geofence]
  enum behavior: [:Monitor, :Range]

  belongs_to :venue
  has_many :events

  def enter
    if !self.enter_trigger_id.blank?
      return Trigger.find(self.enter_trigger_id)
    end
  end

  def exit
    if !self.exit_trigger_id.blank?
      return Trigger.find(self.exit_trigger_id)
    end
  end

  def range
    if !self.range_trigger_id.blank?
      return Trigger.find(self.range_trigger_id)
    end
  end
end
