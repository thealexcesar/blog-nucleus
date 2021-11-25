json.extract! user, :id, :email, :nome, :senha, :tipo, :created_at, :updated_at
json.url user_url(user, format: :json)
