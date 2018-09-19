require 'digest/md5'

module UsersHelper
  def gravatar_url(email, size = 64)
    hex = Digest::MD5.hexdigest(email.downcase.strip)
    "https://gravatar.com/avatar/#{hex}?s=#{size}"
  end

  def gravatar_for(email, size, options = {})
    image_tag gravatar_url(email, size), options
  end
end
