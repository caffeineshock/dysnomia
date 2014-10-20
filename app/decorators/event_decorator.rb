class EventDecorator < ApplicationDecorator
  delegate_all
  decorates_association :users
  decorates_association :category
end
