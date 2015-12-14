class Trigger < ActiveRecord::Base
  # To be able to use type as parameter
  self.inheritance_column = :_type_disabled

  enum type: [:URL, :BackgroundUrl, :API, :LocalNotification, :ClearLocalNotifications, :InternalNotification, :RemoteUpdate, :Range, :DeepLink, :QuickAction, :Event]
end
