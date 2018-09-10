#!/bin/ruby
require 'pry'

seconds = ARGV[0] ? ARGV[0].to_i * 60 : 25 * 60

def time_count_down(seconds)
  seconds.downto(0) do |seconds|
    `notify-send --expire-time=1010 -u low '#{Time.at(seconds).utc.strftime("%H:%M:%S")}'`
    sleep 1
  end
end

time_count_down(seconds)

