json.array!(@regions) do |region|
  json.extract! region, :id, :uuid, :major, :minor, :lat, :lon, :radius, :venue_id, :name, :note
  json.url region_url(region, format: :json)
end
