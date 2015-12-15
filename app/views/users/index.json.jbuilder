json.array!(@users) do |user|
  json.extract! user, :id, :email, :birthday
  json.url user_url(user, format: :json)
  json.profiles user.profiles
end
