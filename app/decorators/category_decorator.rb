class CategoryDecorator < Draper::Decorator
  delegate_all

  def indicator
    h.content_tag(:span, nil, class: "category-indicator", style: "background: #{color}; box-shadow: 0 0 5px #{color}")
  end
end
