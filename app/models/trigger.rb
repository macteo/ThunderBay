class Trigger < ActiveRecord::Base
  # To be able to use type as parameter
  self.inheritance_column = :_type_disabled

  enum type: [:URL, :BackgroundUrl, :API, :LocalNotification, :ClearLocalNotifications, :InternalNotification, :RemoteUpdate, :Range, :DeepLink, :QuickAction, :Event]

  after_commit :propagate_changes

  def propagate_changes
    # TODO: filter users
    Device.all.each do |device|
      Message.create(:receiver_id => device.id, :payload => '{"dicon_update_regions":true}', :content_available => 1)
    end
  end
end
