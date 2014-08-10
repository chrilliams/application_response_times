json.array!(@business_systems) do |business_system|
  json.extract! business_system, :id, :business_service_name, :metric_id, :current_sla_kpi, :target
  json.url business_system_url(business_system, format: :json)
end
