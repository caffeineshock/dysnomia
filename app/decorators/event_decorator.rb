class EventDecorator < ApplicationDecorator
  delegate_all
  decorates_association :users
  decorates_association :category

  def category_indicator
    category.indicator unless category.nil?
  end
end
