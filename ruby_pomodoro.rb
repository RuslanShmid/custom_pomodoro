#!/bin/ruby
require 'pry'
require 'colorize'

work_seconds        = ARGV[0] ? ARGV[0].to_i * 60 : 25 * 60

short_brake_seconds = ARGV[1] ? ARGV[1].to_i * 60 : 05 * 60
long_brake_seconds  = ARGV[2] ? ARGV[2].to_i * 60 : 15 * 60

short_brakes_used = 0

def time_count_down(seconds, urgency, message)
  seconds.downto(0) do |seconds|
    `notify-send --expire-time=1010 -u #{urgency} ' #{message} #{Time.at(seconds).utc.strftime("%H:%M:%S")}'`
    sleep 1
  end
end

while(true) do
  # low normal critical
  time_count_down(work_seconds, 'low', 'Work')

  `notify-send --expire-time=#{1000 * 60 * 60 * 60} -u critical 'Break time (short or long)(s or l) any key to skip \n #{Time.now.strftime("%Y/%m/%d %H:%M:%S")}'`

  print 'Break time enter key (short or long break) (s or l): '.blue
  case STDIN.gets.chomp
  when 'l'
    time_count_down(long_brake_seconds, 'normal', 'Long brake')
  when 's'
    time_count_down(short_brake_seconds, 'normal', 'Short brake')
  end

  `notify-send --expire-time=#{1000 * 60 * 60 * 60} -u critical 'Break is over. Press any key to continue. #{Time.now.strftime("%Y/%m/%d %H:%M:%S")}'`
  print 'Break time is over press any key to continue work.'.red
  STDIN.gets.chomp
end

