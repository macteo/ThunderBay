class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :app
  belongs_to :region
  belongs_to :venue

  # To be able to use type as parameter
  self.inheritance_column = :_type_disabled

  enum type: {region: 'region', purchase: 'purchase', other: 'other'}
  enum subtype: {nothing: 'nothing', enter: 'enter', exit: 'exit', range: 'range'}

  include Rails.application.routes.url_helpers
  #mount_uploader :attachment, AttachmentUploader

  after_create :update_inside_status, if: Proc.new { |event| event.region_id && event.user_id && event.type == "region" && event.region.main == true }

  after_create :broadcast_profile_event, if: Proc.new { |event| event.user_id }

  after_create :broadcast_event

  def fixed_timestamp
    return self.timestamp.to_i
  end

  def user=(u)
    user = User.where(:token => u).first

    if user
      self.user_id = user.id
    end
  end

  def app=(a)
    app = App.where(:key => a).first

    if app
      self.app_id = app.id
    end
  end

  def region=(r)
    region = Region.where(:identifier => r).first

    if region
      if region.venue_id
        self.venue_id = region.venue_id
      end
      self.region_id = region.id
    end
  end

  def update_inside_status
    profile = self.user.profiles.where(:venue_id => self.venue_id).first
    if profile
      if self.subtype == "enter"
        profile.inside = true
        profile.save
        self.venue.send_inside_status_change_notification(profile)
        WebsocketRails[self.venue.channel_name].trigger("enter_event", socket_object)
      elsif self.subtype == "exit"
        profile.inside = false
        profile.save

        self.venue.send_inside_status_change_notification(profile)
        WebsocketRails[self.venue.channel_name].trigger("exit_event", socket_object)
        # self.user.send_goodbye_notification
      end
    end
  end

  def channel_name
    return CGI.escape("#{self.app}-#{self.user}")
  end

  def broadcast_event
    WebsocketRails['events_channel'].trigger("new_event", socket_object)
  end

  def broadcast_profile_event
    if self.region
      venue = Venue.find(self.region.venue_id)
      if venue
        profile = self.user.profiles.where(:venue_id => venue.id).first
        if profile
          logger.info "------------- Sending a new event on the websocket"
          WebsocketRails["profile:#{profile.id}"].trigger("new_event", socket_object)
        else
          logger.info "------------- Didn't find a profile to send the notification to"
        end
      else
        logger.info "------------- Didn't find a venue associated to this region"
      end
    else
      logger.info "------------- Didn't find a region associated to this event"
    end
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
    if self.user && !self.user.email.blank?
      hash["user"] = self.user.email
    end
    if self.app && !self.app.key.blank?
      hash["app"] = self.app.key
    end
    if self.region
      hash["region"] = self.region.identifier
    end
    if !payload.blank?
      begin
        hash["payload"] = JSON.parse(payload, :quirks_mode => true)
      rescue Exception => e
      end
    end
    return hash
  end
end
