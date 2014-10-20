module Tenanted
  def self.included(base)
    base.class_eval do
      default_scope -> { where(tenant_id: Tenant.current_id) }
    end
  end
end