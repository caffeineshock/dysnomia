json.array!(@events) do |event|
  json.extract! event, :title, :description, :starts_at, :ends_at
  json.url event_url(event, format: :json)
end
