#!/usr/bin/env ruby

require 'set'

EFL_VERSION = "0.00.01"

base=ARGV[0]
step=ARGV[1]
base="webbu" if ARGV.size()==0
step="bu" if ARGV.size()<=1

bdd = "#{base}/#{step}"

# l'idée c'est que la collection est cohérente avec le répertoire
command_comprehensive = "xmlstarlet sel -t -m //file -n -v @filename /e8/#{bdd}/collection.xml"

# command_comprehensive = "xmlstarlet sel -t -m //file -n -v @filename /u/progs/webbudev/bu/collection.xml"

command_extensive = "ls /e8/#{bdd}"

# command_extensive = "ls /u/progs/webbudev/bu"

setc = Set.new(IO.popen(command_comprehensive).readlines.each)
sete = Set.new(IO.popen(command_extensive).readlines.each)

setoe = Set.new()
set  = Set.new()
setoc = SortedSet.new()

setc.each do |e| 
	if sete.include?(e)
		set << e;
	else
		setoc << e;
	end
end

sete.each do |e| 
	if !setc.include?(e)
		setoe << e;
	end
end

puts "#{set.size()} élements en commun"
puts "#{setoe.size()} élements uniquement dans le répertoire"
puts "#{setoc.size()} élements uniquement dans le fichier collection"

fc = File.open("comprehensif.txt", 'w')
setoc.each { |e| fc.puts e }
fc.close

fe = File.open("extensif.txt", 'w')
setoe.each { |e| fe.puts e }
fe.close