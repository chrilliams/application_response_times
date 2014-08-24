# /usr/bin/env ruby
class Stats


#  require 'benchmark'

  def initialize
   
    #@file = File.open('/home/player/Desktop/test.log','r')
    @business_systems = BusinessSystem.all
    @batch_size = 100000

    
  end

  def process_file_import

    @business_systems.each do |bs|


      files = bs.log_file.first
      if !files.nil?
        ## find all the files matching the regex
        Dir[files.file_name].each do |file_name|
          puts "Processing #{file_name}"
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


          time_to_process_files = Benchmark.realtime{
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
         }
         puts " time to process file: #{time_to_process_files}s"
         bench = Benchmark.realtime {
           values.each_slice(@batch_size){|batch| Stage.import columns, batch }
         }
         puts " time to write to database: #{bench}s"
         values = []
        end 
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
  puts Rails.env
  Stage.delete_all 
  puts bench = Benchmark.realtime { Stats.new.process_file_import }
  puts "total time to process: #{bench}s"


  
end
