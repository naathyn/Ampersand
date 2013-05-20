module UsersHelper
  def gravatar_for(user, options = { size: 50, urlonly: false })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    if options[:urlonly]
      url_for gravatar_url
    else
      image_tag(gravatar_url, alt: user.username, class: "gravatar")
    end
  end
end
