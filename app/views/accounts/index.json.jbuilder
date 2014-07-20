json.array!(@accounts) do |account|
  json.extract! account, :id, :username, :password, :security_token
  json.url account_url(account, format: :json)
end
