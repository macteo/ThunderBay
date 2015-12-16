require 'houston'

class Message < ActiveRecord::Base
  belongs_to :device, :foreign_key => "receiver_id"

  after_commit :schedule_push

  def schedule_push
    PushWorker.perform_async(self.id, 1)
  end

  def send_push
    if self.sent == true
      return
    end
    if self.device.app.sandbox
      apn = Houston::Client.development
    else
      apn = Houston::Client.production
    end
    apn.certificate = self.device.app.certificate
    token = self.device.token
    notification = Houston::Notification.new(device: token)

    if !self.title.blank?
      notification.alert = self.title
    end

    #notification.badge = 0
    if self.badge?
      notification.badge = self.badge
    end

    if !self.sound.blank?
      notification.sound = self.sound
    end

    if !self.category.blank?
      notification.category = self.category
    end

    if self.content_available == 1
      notification.content_available = 1
    end

    if !self.url.blank?
       custom_data = {id: "#{self.id.to_s}", url: self.url }
    else
       custom_data = {id: "#{self.id.to_s}" }
    end

    if !self.payload.blank?
      custom_data = custom_data.merge(self.payload)
    end

    notification.custom_data = custom_data

    apn.push(notification)

    self.sent = 1
    self.save
  end
end
