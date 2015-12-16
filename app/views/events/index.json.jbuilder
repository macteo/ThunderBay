json.array!(@events) do |event|
  json.extract! event, :id, :type, :subtype, :payload, :timestamp, :uuid, :user_id, :app_id, :attachment, :region_id, :venue_id
  json.url event_url(event, format: :json)
end
