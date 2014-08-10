json.array!(@log_files) do |log_file|
  json.extract! log_file, :id, :file_name, :line_format, :fields
  json.url log_file_url(log_file, format: :json)
end
