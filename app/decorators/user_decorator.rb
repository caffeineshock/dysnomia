class UserDecorator < Draper::Decorator
  delegate_all
  decorates_association :tenants
  decorates_association :invited_by

  def username
    object.username.blank? ? object.email : object.username
  end

  def link
    h.content_tag("span", nil, data: {uid: object.id}, class: "onlinestatus") + h.link_to(username, object)
  end

  def role_icon
    if object.user?
      return
    end

    icon_with_tooltip(*(object.moderator? ? ['sheriff-badge', 'Moderator'] : ['crown', 'Administrator']))
  end

  private

  def icon_with_tooltip icon, title
    icon_with_tooltip_and_classes(["fi-#{icon}", 'has-tip'], title)
  end

  def icon_with_tooltip_and_classes classes, title
    h.content_tag("i", nil, data: {tooltip: ""}, class: classes.join(' '), title: title)
  end
end
