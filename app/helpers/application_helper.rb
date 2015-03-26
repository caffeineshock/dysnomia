module ApplicationHelper
  def icon type
    content_tag :i, nil, class: "fi-#{type.to_s}"
  end

  def clipboard_button target
    content_tag :button, class: "zeroclipboard", data: {:"clipboard-target" => target} do
      icon :"clipboard-pencil"
    end
  end

  def datetime_column date, opts = {}
    opts = {relative: false, time: true}.merge opts
    date = date.to_time if date.is_a? Date
    content_tag(:span, data: {timestamp: date.to_i || 0}) do
      if date.nil?
        icon :minus
      else
        if opts[:relative]
          "Ist #{time_ago_in_words(date)} her"
        else
          format = opts[:time] ? '%d.%m.%Y - %H:%M' : '%d.%m.%Y'
          l date, format: format
        end
      end
    end
  end

  def navbar_link title, options
    icon_opts = {class: "fi-#{options[:icon]} navbar-icon"}
    content = title

    if options[:unread]
      model = options[:unread]
      count = unread_objs[model].length
      span_opts = {id: "#{model}_notifications", class: "notification"}
      icon_opts[:id] = "#{model}_icon"
      (count > 0 ? icon_opts : span_opts)[:style] = "display: none"
      content.prepend content_tag("span", count, span_opts)
    end

    content.prepend content_tag("i", nil, icon_opts)

    link_options = options[:shortcut].nil? ? {} : {data: { keybinding: options[:shortcut] }}
    link_to content.html_safe, options[:path], link_options
  end

  def app_version
    Dysnomia::Application.config.version
  end
end
