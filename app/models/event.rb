class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :app

  enum type: {region: 'region', purchase: 'purchase', other: 'other'}
  enum subtype: {nothing: 'nothing', enter: 'enter', exit: 'exit', range: 'range'}

  # To be able to use type as parameter
  self.inheritance_column = :_type_disabled

  include Rails.application.routes.url_helpers
    #mount_uploader :attachment, AttachmentUploader

    after_create :broadcast_event

    # To be able to use type as parameter
    self.inheritance_column = :_type_disabled

    def channel_name
      return CGI.escape("#{self.app}-#{self.user}")
    end

    def broadcast_event
      # Fiber.new{  }.resume
      WebsocketRails[channel_name].trigger("new_event", socket_object)
    end

    def prettyPayload
      if !payload.blank?
        begin
          jsonPayload = JSON.parse(payload, :quirks_mode => true)
          return JSON.pretty_generate(jsonPayload)
        rescue Exception => e
          return payload
        end
      end
      return ""
    end

    def socket_object
      hash = self.attributes
      hash["timestamp"] = self.timestamp.to_i
      if !payload.blank?
        begin
          hash["payload"] = JSON.parse(payload, :quirks_mode => true)
        rescue Exception => e
        end
      end
      return hash
    end
end
