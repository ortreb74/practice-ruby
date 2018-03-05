#!/usr/bin/env ruby

# a.rb splited sample 100

require 'set'

command_extensive = "ls #{ARGV[0]}"

output_dir = ARGV[1]

system "rm -r #{output_dir}"
Dir::mkdir(output_dir, 0755)

sete = SortedSet.new(IO.popen(command_extensive).readlines.each)

fc = File.open("ls.txt", 'w')

i = 0
k = sete.size() / Integer(ARGV[2])

puts "modulo : #{k}"

sete.each do |e| 
	i = i + 1
	if (i % k ==0)
		fc.puts e
		command_line = "cp #{ARGV[0]}/#{e.chomp} #{output_dir}"
		system command_line 
	end
end
fc.close

puts "size : #{sete.size()}"
