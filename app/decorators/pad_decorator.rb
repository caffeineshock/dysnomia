class PadDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  def embed_url
    params = {
      showChat: false,
      userName: Rack::Utils.escape(h.current_user.username)
    }

    "#{url}?#{params.to_query}"
  end

  def url
    "#{Settings.etherpad_address}/p/#{object.internal_name}"
  end
end
