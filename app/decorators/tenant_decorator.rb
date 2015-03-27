class TenantDecorator < Draper::Decorator
  delegate_all

  def link
    h.link_to object.name, object
  end

  def title
    object.logo.exists? ? h.image_tag(object.logo.url(:navbar)) : object.name
  end
end
