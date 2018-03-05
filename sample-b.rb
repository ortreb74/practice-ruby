#!/usr/bin/env ruby

# b.rb ~/bas/20171012/papi-ur/ sample 100

require 'set'

command_extensive = "ls #{ARGV[0]}"
output_dir = ARGV[1]

reference_source = "/e8/webbu/uaur/papi-ur"
reference_output_dir = "reference"

system "rm -r #{output_dir} #{reference_output_dir}"
Dir::mkdir(output_dir, 0755)
Dir::mkdir(reference_output_dir, 0755)

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
		command_line = "cp #{reference_source}/#{e.chomp} #{reference_output_dir}"
		system command_line 
	end
end
fc.close

puts "size : #{sete.size()}"

# cp: impossible d'évaluer « /e8/webbu/uaur/papi-ur/guidefr1355i1.xml »: Aucun fichier ou dossier de ce type
# cp: impossible d'évaluer « /e8/webbu/uaur/papi-ur/xf028-src.xml »: Aucun fichier ou dossier de ce type