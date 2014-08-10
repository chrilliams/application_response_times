#!/usr/bin/env ruby
class Stats


  require 'benchmark'
  APP_PATH = File.expand_path('../../config/application',  __FILE__)
  require File.expand_path('../../config/boot',  __FILE__)
  require APP_PATH
  # set Rails.env here if desired
  Rails.application.require_environment!

  def initialize
    @file = File.open('/home/player/Desktop/phl-EVLDMS_a_ms1.log.2014-07-06','r')
    #@batch_size = 50000

    
  end

  def process_file_import

        regex_dDMS = /^(.*?) - (\d{4}\/\d{2}\/\d{2} \d{2}:\d{2}:\d{2}\.\d{3}),(.*?),(.*?),.*?,(.*?),(.*?),.*?,(.*)$/
        values = []
       
        @file.each_line do |line|
          if line.match(regex_dDMS)
            ary_captures = line.match(regex_dDMS).captures
            puts ary_captures

          end 
        end
  end
#  puts bench = Benchmark.measure { Stats.new.process_file_active_record }
puts "running import"
  puts bench = Benchmark.measure { Stats.new.process_file_import }
end
