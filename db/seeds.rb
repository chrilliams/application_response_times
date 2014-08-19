# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or create!d alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create!([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create!(name: 'Emanuel', city: cities.first)

BusinessSystem.delete_all
RefDatum.delete_all
LogFile.delete_all

bs = BusinessSystem.create!(business_service_name: "POVE", metric_id: 99, current_sla_kpi: 1, target: 0.5)
RefDatum.create!(code: "POVE_001", description: "EVL - POVE", business_system: bs)
LogFile.create!(file_name: "/home/player/Desktop/EVL_logs/phl-EVLDMS_*.log.*gz", line_format: "^(.*?) - (\\d{4}\\/\\d{2}\\/\\d{2} \\d{2}:\\d{2}:\\d{2}\\.\\d{3}),(.*?),(.*?),.*?,(.*?),(.*?),.*?,(.*)$", fields: "app_id$string,,ev_time$date|%Y/%m/%d %H:%M:%S.%L|,,code$string,,conversation_id$string,,sub_system$string,,system$string,,description$string", business_system: bs)

bs = BusinessSystem.create!(business_service_name: "EVL_DMS", metric_id: 24, current_sla_kpi: 1, target: 0.5)
RefDatum.create!(code: "CRLT_001", description: "EVL - Complete Relicensing Transaction", business_system: bs)
RefDatum.create!(code: "CNFR_001", description: "EVL - Complete No Fee Relicense", business_system: bs)
RefDatum.create!(code: "CPYC_001", description: "EVL - Check Payment Card", business_system: bs)
RefDatum.create!(code: "GTNS_001", description: "EVL - Get Transaction Summary", business_system: bs)
LogFile.create!(file_name: "/home/player/Desktop/EVL_logs/phl-EVLDMS_*.log.*gz", line_format: "^(.*?) - (\\d{4}\\/\\d{2}\\/\\d{2} \\d{2}:\\d{2}:\\d{2}\\.\\d{3}),(.*?),(.*?),.*?,(.*?),(.*?),.*?,(.*)$", fields: "app_id$string,,ev_time$date|%Y/%m/%d %H:%M:%S.%L|,,code$string,,conversation_id$string,,sub_system$string,,system$string,,description$string", business_system: bs)
