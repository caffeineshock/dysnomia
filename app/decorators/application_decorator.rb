class ApplicationDecorator < Draper::Decorator
  delegate_all

  def unread_icon
  	unread? ? unread_icon!  : ""
  end

  protected

  def unread_icon!
  	h.content_tag(:i, nil, class: "fi-asterisk unread")
  end

  private

  def unread?
  	h.unread_objs[h.model_short_name object.class.name].include? object.id
  end
end