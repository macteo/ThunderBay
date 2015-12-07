json.array!(@profiles) do |profile|
  json.extract! profile, :id, :user_id, :venue_id, :role, :note
  json.url profile_url(profile, format: :json)
end
