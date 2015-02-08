json.array!(@pads) do |pad|
  json.extract! pad, :id, :title, :internal_name, :tenant_id
  json.url pad_url(pad, format: :json)
end
