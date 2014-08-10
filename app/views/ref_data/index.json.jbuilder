json.array!(@ref_data) do |ref_datum|
  json.extract! ref_datum, :id, :code, :description
  json.url ref_datum_url(ref_datum, format: :json)
end
