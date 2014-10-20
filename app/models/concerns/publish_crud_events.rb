module PublishCrudEvents
  include Wisper::Publisher
  extend ActiveSupport::Concern

  included do
    after_find do
      publish(:read, self)
    end

    after_create do
      publish(:created, self) 
    end

    after_update do
      publish(:updated, self)
    end

    before_destroy do
      publish(:destroyed, self)
    end
  end
end