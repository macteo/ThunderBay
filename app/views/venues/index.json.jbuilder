json.array!(@venues) do |venue|
  json.extract! venue, :id, :name, :description
  json.url venue_url(venue, format: :json)
  json.items venue.items
end
