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
    @business_systems = BusinessSystem.all
    #@batch_size = 50000

    
  end

  def process_file_import

    @business_systems.each do |bs|


      files = bs.log_file.first
      if !files.nil?
        ## find all the files matching the regex
        Dir[files.file_name].each do |file_name|
          puts "Reading #{file_name}"
          file File.open(file_name,'r')
   
          ## once the file is open continue getting the log file information
          columns = files.fields.split(',')
          regex_dDMS = /#{files.line_format}/
   
          ## get the logging_codes
          logging_codes = bs.ref_datum.pluck('code')
          values = []


          ## loop through each line of the file and try to process to Stage
          file.each_line do |line|

        end 
#puts Dir['/home/player/Desktop/EVL_logs/phl-EVLDMS_a_ms1.log*']

        file = File.open(files.file_name,'r')
       
        file.each_line do |line|
          if line.match(/DVLA_SCHEDULER/)
            #puts "dvla_scheduler" ## going to ignore for the first sprint
          elsif line.include? 'asyncDelivery'
            #puts "asyncDelivery"
          elsif line.include? 'SOMBrowseSiteRequestService'
            #puts "SOMBrowseSiteRequestService"
          elsif line.match(regex_dDMS)
            ary_captures = line.match(regex_dDMS).captures
            if logging_codes.include?( ary_captures[2].delete("\'").gsub(/\_0[1-9]\_/,'_') )
              #values.push [DateTime.strptime( ary_captures[0], "%Y-%m-%d %H:%M:%S,%L"),
              values.push [ary_captures[0],DateTime.strptime( ary_captures[1], "%Y/%m/%d %H:%M:%S.%L"),
                ary_captures[2].delete("\'"),
                ary_captures[3].delete("\'"),
                ary_captures[4].delete("\'"),
                ary_captures[5].delete("\'"),
                ary_captures[6].delete("\'")]
              
            end
          else
            #puts "unexpected line #{line}"
          end 
        end
        # complete inserts
        Stage.import columns, values
      end
    end
  end
#  puts bench = Benchmark.measure { Stats.new.process_file_active_record }
     Stage.delete_all 
puts "Stage table deleted"
puts "running import"
  puts bench = Benchmark.measure { Stats.new.process_file_import }
end
