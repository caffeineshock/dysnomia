module CrudListeners
  extend ActiveSupport::Concern

  included do
    around_filter only: %i(create update destroy) do |controller,action_block|
      listeners = [
        PushListener.new(current_user.id, current_tenant.id),
        ActivityListener.new(current_user),
        ReadListener.new(current_user)
      ]

      Wisper.subscribe(*listeners) do
        action_block.call
      end
    end

    around_filter only: %i(show edit) do |controller,action_block|
      Wisper.subscribe(ReadListener.new(current_user)) do
        action_block.call
      end
    end
  end
end
