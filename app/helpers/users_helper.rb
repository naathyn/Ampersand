module UsersHelper

  def gravatar_for(user, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, title: user.realname, class: "gravatar")
  end

  def random_captcha
    self.captchas.shuffle!
    self.captchas.last
  end

  def following?(other_user)
    self.relationships.find_by_followed_id(other_user.id)
  end

  def following?(other_user)
    self.relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    self.relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    self.relationships.find_by_followed_id(other_user.id).destroy
  end

  def like!(random_share)
    self.fans.create!(like_id: random_share.id)
  end

  def unlike!(random_share)
    self.fans.find_by_like_id(random_share.id).destroy
  end
end
