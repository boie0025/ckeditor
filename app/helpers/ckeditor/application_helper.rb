module Ckeditor::ApplicationHelper
  def assets_pipeline_enabled?
    if Gem::Version.new(::Rails.version.to_s) >= Gem::Version.new('4.0.0')
      defined?(Sprockets::Rails)
    elsif Gem::Version.new(::Rails.version.to_s) >= Gem::Version.new('3.0.0')
      Rails.application.config.assets.enabled
    else
      false
    end
  end

  def paginated_numbers(pictures, params)
    classes = ["paginated-number"]
    links = pictures.page_numbers.map do |page_num|
      classes << "active" if pictures.current_page == page_num
      li = content_tag :li, :class => classes.join(" ") do
        link_to page_num, params.merge(:page => page_num)
      end
      classes.delete("active")
      li
    end
    links.prepend(more_pages("First", 1)) if pictures.exceeds_preceding_pages_window?
    links.append(more_pages("Last", pictures.total_pages)) if pictures.exceeds_following_pages_window?
    links.join.html_safe
  end

  def more_pages(link_text, page_num)
    classes = ["paginated-number"]
    pagination_class = classes.join(" ")
    more = content_tag :li, :class => "#{pagination_class} more" do
      "..."
    end
    link = content_tag :li, :class => pagination_class do
      link_to link_text, params.merge(:page => page_num)
    end
    link_text == "First" ? link.concat(more) : more.concat(link)
  end
end