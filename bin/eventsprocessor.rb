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
    @columns = [:name, :start_time, :finish_time, :duration, :system, :sub_system, :ref_datum_id]
  end

  def delete_unwanted_from_stage
    ##delete failed transactions (we arent bothered about failed transactions at this time
    Stage.where('code LIKE (?) ESCAPE "\" ', '%\_03\_%').each do |failed|
      Stage.where("app_id = ?", failed.app_id).destroy_all
    end
    Stage.where('code LIKE (?) ESCAPE "\" ', '%\_05\_%').each do |failed|
      Stage.where("app_id = ?", failed.app_id).destroy_all
    end
  end

  def process_events
    #delete_unwanted_from_stage

    i=0
    batch_for_delete= []
    values = []

    Stage.find_each(batch_size: @batch_size) do |record_started|

      if record_started.code.include? "_01_"
        ## its the start statement
        search_code = record_started.code.sub '_01_', '_02_'
#        puts record.app_id + record.code + " " + record.conversation_id + " " + search_code
        ## need to search on app_id and search_code
        
        if found_completed = Stage.find_by_app_id_and_code(record_started.app_id, search_code) ##order
          #puts record_started.app_id + " " + record_started.code + " " +( (found_completed.ev_time - record_started.ev_time) * 1000 ).to_s + " milliseconds"
          ## add an event to the database
	  related_RefDatum = RefDatum.find_by_code(record_started.code.sub('_01_','_'))
          values.push [related_RefDatum.description,
		record_started.ev_time,
		found_completed.ev_time,
		(found_completed.ev_time - record_started.ev_time) * 1000,
		record_started.system,
		record_started.sub_system,
		related_RefDatum
	  ]                
          batch_for_delete << found_completed.id
        end

        batch_for_delete << record_started.id
        #record_started.destroy
 
      end
      ##delete the records
      if ( i % @batch_size ) == 0
        Event.import @columns, values
        #puts "deleting batch at: " +i.to_s
        #Stage.delete( batch_for_delete )
        batch_for_delete =[]
        values=[]
      end
      i=i+1
    end
    #extra delete incase there not quite a full batch
    #Stage.delete( batch_for_delete )
    Event.import @columns, values
    


##leave for testing
    conversation = Stage.where( conversation_id: '4c828cac19405f00000000388678e2')
    
    if conversation.count == 2
      code1= conversation[0].code
      code2= conversation[1].code
      event_time1 = conversation[0].ev_time
      event_time2 = conversation[1].ev_time
      duration = ((event_time2 - event_time1) * 1000 ).to_i
#      puts code1 + " " + duration.to_s + " milliseconds"

    end
  end

  puts bench = Benchmark.measure { EventsProcess.new.process_events }



end
