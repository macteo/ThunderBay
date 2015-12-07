class Trigger < ActiveRecord::Base
  enum type: [:url, :background_url, :api, :local_notification, :clear_local_notifications, :internal_notification, :remote_update, :range, :deep_link, :quick_action]

  # To be able to use type as parameter
  self.inheritance_column = :_type_disabled
end
