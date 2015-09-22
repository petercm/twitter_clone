require 'digest/md5'

module ApplicationHelper
  def user_list(users, first, last)
    subset = users[first...last]
    subset.map { |u|
      gravatar(email: u.email, size: 20) + " " + link_to(u.username, controller: 'users', action: 'show', username:u.username)
    }.join(', ').html_safe unless subset.nil?
  end

  def gravatar(options)
    image_tag("http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(options[:email])}?s=#{options[:size]}", :class => "gravatar #{options[:class]}")
  end
end
