json.array! @users do |user|
  json.name user.realname
  json.username user.name
  json.image gravatar_for(user, size: 30, url_only: true)
end
