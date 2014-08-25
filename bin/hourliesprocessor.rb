#!/usr/bin/env ruby
class EventsProcess


  require 'benchmark'
  APP_PATH = File.expand_path('../../config/application',  __FILE__)
  require File.expand_path('../../config/boot',  __FILE__)
  require APP_PATH
  # set Rails.env here if desired
  Rails.application.require_environment!

  def initialize
    @batch_size = 10000
    @columns = [:hour, :maximum, :minimum, :average, :ref_datum_id]
  end

  def process_events

    query = "select ref_datum_id,
        to_char(start_time, 'YYYY-MM-DD HH24') as event_hour, 
	avg(duration) as average, 
	min(duration) as minimum,
	max(duration) as maximum 
	from events 
		group by to_char(start_time, 'YYYY-MM-DD HH24'),
		ref_datum_id";



    result=ActiveRecord::Base.connection.execute(query)

    result.each do |resultrow|
      hour_in_database_format = DateTime.strptime( resultrow['event_hour'], '%Y-%m-%d %H')
      Hourly.create!( hour: hour_in_database_format , maximum: resultrow['maximum'] , minimum: resultrow['minimum'] , average: resultrow['average'] , ref_datum_id: resultrow['ref_datum_id'] )
    end

  end

  puts bench = Benchmark.measure { EventsProcess.new.process_events }


end
