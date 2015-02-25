class TenantDecorator < Draper::Decorator
  delegate_all

  def title
    object.logo.exists? ? h.image_tag(object.logo.url(:navbar)) : object.name
  end
end
