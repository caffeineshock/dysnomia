class TenantDecorator < Draper::Decorator
  delegate_all

  def link
    h.link_to object.name, object
  end
end
