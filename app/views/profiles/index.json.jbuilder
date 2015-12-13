json.array!(@profiles) do |profile|
  json.extract! profile, :id, :user_id, :venue_id, :role, :note, :inside
  if profile.user_id
    json.user profile.user
  end
  if profile.venue_id
    json.venue profile.venue
  end
  json.url profile_url(profile, format: :json)
end
