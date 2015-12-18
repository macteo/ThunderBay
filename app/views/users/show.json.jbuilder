json.extract! @user, :id, :email, :created_at, :updated_at, :token, :birthday, :image
json.profiles @user.profiles
