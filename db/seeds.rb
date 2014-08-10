# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or create!d alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create!([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create!(name: 'Emanuel', city: cities.first)



# List of PHL technical transaction descriptions
# Only _01_01_ start codes are now required.

# NSL2 Codes
RefDatum.destroy_all

RefDatum.create!(code: 'MABD_01_000026', description: 'GET_DRIVER_AND_PARTY_DETAILS')
RefDatum.create!(code: 'MABD_02_000026', description: 'GET_DRIVER_AND_PARTY_DETAILS')

RefDatum.create!(code: 'MABD_01_000005', description: 'GET_BUSINESS_DATA_SUMMARY')
RefDatum.create!(code: 'MABD_02_000005', description: 'GET_BUSINESS_DATA_SUMMARY')

RefDatum.create!(code: 'FAPP_01_000019', description: 'FAP_PROCESS_TRANSACTION')
RefDatum.create!(code: 'FAPP_02_000019', description: 'FAP_PROCESS_TRANSACTION')

RefDatum.create!(code: 'CHGC_01_000006', description: 'DLO_PROCESS_TRANSACTION')
RefDatum.create!(code: 'CHGC_02_000006', description: 'DLO_PROCESS_TRANSACTION')
