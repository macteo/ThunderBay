json.array!(@events) do |event|
  json.extract! event, :id, :type, :subtype, :payload, :fixed_timestamp, :uuid, :user_id, :app_id, :attachment, :region_id, :venue_id
  if event.region_id
    json.region event.region.identifier
  end
  json.url event_url(event, format: :json)
end
