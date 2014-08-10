#!/usr/bin/env ruby
class Stats


  require 'benchmark'
  APP_PATH = File.expand_path('../../config/application',  __FILE__)
  require File.expand_path('../../config/boot',  __FILE__)
  require APP_PATH
  # set Rails.env here if desired
  Rails.application.require_environment!

  def initialize
    #@file = File.open('/home/player/Desktop/test.log','r')
    @file = File.open('/home/player/Desktop/phl-DMSms1.log.2014-04-28','r')
    @batch_size = 50000

    ##get the reference data
    @logging_codes = RefDatum.all.pluck('code')
    
  end

  def process_file_import
     ## check the stage table is empty
    puts "active_record_bulk_import: "+  @number_of_records.to_s() +" records"
    puts "active_record_bulk_import: "+  @batch_size.to_s() +" batch"

    i=0
    columns = [:ev_time, :app_id, :code, :description, :conversation_id, :system, :sub_system]
    #columns = [:ev_time, :app_id, :code]
    values = []
    #@regex_dDMS = /(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2},\d{3}) \[.*\] (.*)- .*?,.*?,(.*?),(.*?),.*?,.*?,.*?,.*?,(.*?),(.*?),(.*?),.*$/
    #@regex_dDMS = /(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2},\d{3}) \[.*\] (172\.25\.64\.\d{2}--\w{8}\.\w{11}\.\w{4}).*?,.*?,(.*?),(.*?),.*?,.*?,.*?,.*?,(.*?),(.*?),(.*?),.*$/
    @regex_dDMS = /(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2},\d{3}) \[.*\] (172\.25\.64\.\d{2}--\w{8}\.\w{11}\.\-*\w{4}).*?,.*?,(.*?),(.*?),.*?,.*?,.*?,.*?,(.*?),(.*?),(.*?),.*$/
    @file.each_line do |line|
      i=i+1
      if line.match(/DVLA_SCHEDULER/)
        #puts "dvla_scheduler" ## going to ignore for the first sprint
      elsif line.include? 'asyncDelivery'
        #puts "asyncDelivery"
      elsif line.include? 'SOMBrowseSiteRequestService'
        #puts "SOMBrowseSiteRequestService"
      elsif line.match(@regex_dDMS)
        #puts line.match(@regex_dDMS).captures
        ary_captures = line.match(@regex_dDMS).captures

        if @logging_codes.include?( ary_captures[2].delete("\'"))        
          values.push [DateTime.strptime( ary_captures[0], "%Y-%m-%d %H:%M:%S,%L"),
		ary_captures[1],
		ary_captures[2].delete("\'").split(' ')[0],
		ary_captures[3].delete("\'"),
		ary_captures[4].delete("\'"),
		ary_captures[5].delete("\'"),
		ary_captures[6].delete("\'")]
        end
        #puts "done"
        if ( i % @batch_size ) == 0
          puts "commiting: " + i.to_s
          puts  Benchmark.measure { Stage.import columns, values }
          values = []
        end
      else
        #puts "error on line: " + line
## there are errors here!!!!! SORT OUT
      end
    end
	## need for left over batch
          Stage.import columns, values if values.size > 0
    puts "Number of Records processed: " + i.to_s
  end

#  puts bench = Benchmark.measure { Stats.new.process_file_active_record }
     Stage.delete_all 
  puts bench = Benchmark.measure { Stats.new.process_file_import }
end
