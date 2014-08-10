json.array!(@stages) do |stage|
  json.extract! stage, :id, :ev_time, :app_id, :code, :description, :conversation_id, :system, :sub_system
  json.url stage_url(stage, format: :json)
end
