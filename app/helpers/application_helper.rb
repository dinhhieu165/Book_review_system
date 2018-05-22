module ApplicationHelper
  def full_title page_title = ""
    base_title = I18n.t "title"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def increase_one index
    index + Settings.value_one
  end

  def gravatar_for user, options = {size: Settings.avatar.size,
    classes: "gravatar"}
    gravatar_id = Digest::MD5::hexdigest user&.email.downcase
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag gravatar_url, alt: user&.name, class: options[:classes]
  end
end
