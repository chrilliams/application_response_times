json.array!(@hourlies) do |hourly|
  json.extract! hourly, :id, :hour, :maximum, :minimum, :average
  json.url hourly_url(hourly, format: :json)
end
