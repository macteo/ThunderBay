json.extract! @venue, :id, :name, :description, :created_at, :updated_at
json.items @venue.items
