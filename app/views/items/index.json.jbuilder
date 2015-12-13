json.array!(@items) do |item|
  json.extract! item, :id, :title, :content, :image, :payload, :venue_id
  json.url item_url(item, format: :json)
end
