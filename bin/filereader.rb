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
          file_gz = File.open(file_name,'r')
          file = gz = Zlib::GzipReader.new(file_gz)
   
          ## once the file is open continue getting the log file information
          #columns_and_type = files.fields.split(',')
	  columns_and_types=Hash.new 
	  files.fields.split(',,').each do |ct|
            column = ct.split('$')[0]
            value = ct.split('$')[1]
            columns_and_types[column] = value
          end
          columns = columns_and_types.keys

          regex_dDMS = /#{files.line_format}/
   
          ## get the logging_codes
          logging_codes = bs.ref_datum.pluck('code')
          values = []


          ## loop through each line of the file and try to process to Stage
          file.each_line do |line|
            ## match the line from the regex in the setup
            if line.match(regex_dDMS)
              ## capture all the ()
              ary_captures = line.match(regex_dDMS).captures
              ## check to see if the line contains one of the logging codes we are interested in
              ## subsitute _ for a _01-09_
              if logging_codes.include?( ary_captures[2].delete("\'").gsub(/\_0[1-9]\_/,'_') ) 
                ## store the values from the () in an array, ready for insert
                #values.push [DateTime.strptime( ary_captures[0], "%Y-%m-%d %H:%M:%S,%L"),



                values.push [ 
		  format_column(ary_captures[0],columns_and_types.values[0]),
		  format_column(ary_captures[1],columns_and_types.values[1]),
		  format_column(ary_captures[2],columns_and_types.values[2]),
		  format_column(ary_captures[3],columns_and_types.values[3]),
		  format_column(ary_captures[4],columns_and_types.values[4]),
		  format_column(ary_captures[5],columns_and_types.values[5]),
		  format_column(ary_captures[6],columns_and_types.values[6])
	        ]
              end
            end
          end
          Stage.import columns, values
          puts "logfile import complete"

        end 
#puts Dir['/home/player/Desktop/EVL_logs/phl-EVLDMS_a_ms1.log*']
       
        #file.each_line do |line|
          #if line.match(/DVLA_SCHEDULER/)
            ##puts "dvla_scheduler" ## going to ignore for the first sprint
          #elsif line.include? 'asyncDelivery'
            ##puts "asyncDelivery"
          #elsif line.include? 'SOMBrowseSiteRequestService'
            ##puts "SOMBrowseSiteRequestService"
          #elsif line.match(regex_dDMS)
            #ary_captures = line.match(regex_dDMS).captures
            #if logging_codes.include?( ary_captures[2].delete("\'").gsub(/\_0[1-9]\_/,'_') )
              ##values.push [DateTime.strptime( ary_captures[0], "%Y-%m-%d %H:%M:%S,%L"),
              #values.push [ary_captures[0],DateTime.strptime( ary_captures[1], "%Y/%m/%d %H:%M:%S.%L"),
                #ary_captures[2].delete("\'"),
                #ary_captures[3].delete("\'"),
                #ary_captures[4].delete("\'"),
                #ary_captures[5].delete("\'"),
                #ary_captures[6].delete("\'")]
              
            #end
          #else
            #puts "unexpected line #{line}"
          #end 
        #end
        # complete inserts
        #Stage.import columns, values
      end
    end
  end
  def format_column(value, type)
    if (type.starts_with? "date")
      date_format = type.split('|')[1]
      DateTime.strptime( value.delete("\'"), date_format)
    else
      value.delete("\'")
    end
  end

#  puts bench = Benchmark.measure { Stats.new.process_file_active_record }
  Stage.delete_all 
  puts "Stage table deleted"
  puts "running import"
  puts bench = Benchmark.measure { Stats.new.process_file_import }


  
end
