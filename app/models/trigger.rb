class Trigger < ActiveRecord::Base
  enum type: [:URL, :BackgroundUrl, :API, :LocalNotification, :ClearLocalNotifications, :InternalNotification, :RemoteUpdate, :Range, :DeepLink, :QuickAction, :Event]

  # To be able to use type as parameter
  self.inheritance_column = :_type_disabled
end
