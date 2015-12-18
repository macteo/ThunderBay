json.array!(@users) do |user|
  json.extract! user, :id, :email, :birthday, :image, :name
  json.url user_url(user, format: :json)
  json.profiles user.profiles
end
