#json.events(@events.hourlybreakdown)
 
json.key "Events"

json.array!(@graph_data) do |event|
  json.key event.key
  json.values event.values

end

