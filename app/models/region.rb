class Region < ActiveRecord::Base
  enum type: [:Beacon, :Geofence]
  enum behavior: [:Monitor, :Range]

  belongs_to :venue
  has_many :events

  # To be able to use type as parameter
  self.inheritance_column = :_type_disabled

  def enter_trigger
    if !self.enter_trigger_id.blank?
      return Trigger.find(self.enter_trigger_id)
    end
  end

  def exit_trigger
    if !self.exit_trigger_id.blank?
      return Trigger.find(self.exit_trigger_id)
    end
  end

  def range_trigger
    if !self.range_trigger_id.blank?
      return Trigger.find(self.range_trigger_id)
    end
  end
end
