module ApplicationHelper
  def blankslate(text, options={})
    content_tag :p, text, class: "center mt0 mb0 pt2 pb2 slate bold h3 #{options[:class]}"
  end

  def badge_for(count, options={})
    content_tag :span, count, class: "badge #{options[:class]}"
  end

  def status_badge(type = :pending)
    content_tag :span, '', class: "status bg-#{type}"
  end

  def status_if(type, condition)
    status_badge(type) if condition
  end

  def remove_url_head(url)
    url.gsub /^http(s?):\/\/(w+\.)?/, ''
  end

  def clean_autolink(text)
    link_to remove_url_head(text), text, target: '_blank', style: 'color: inherit'
  end

  def inline_svg(filename, options = {})
    file = File.read(Rails.root.join('app', 'assets', 'images', 'icons', filename))
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'
    options[:style] ||= ''
    if options[:size]
      options[:width] = options[:size]
      options[:height] = options[:size]
      options.delete :size
    end
    options.each { |key, value| svg[key.to_s] = value }
    doc.to_html.html_safe
  end
end
