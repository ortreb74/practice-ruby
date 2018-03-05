#!/usr/bin/env ruby

$root="/u/ext-pdonzel/spa"

# obtenir le fichier de données
xml=File.open($root + "/xml", "r").readlines[0].chomp
w=xml.split("/")[xml.split("/").length - 1].split(".")
w.pop
xml_part=w.join(".")

# obtenir le programme
# tester que cela peut être une xsl
xslt=File.open($root + "/xslt", "r").readlines[0].chomp
w=xslt.split("/")[xslt.split("/").length - 1].split(".")
w.pop
xslt_part=w.join(".")

# obtenir les paramètres
w=xslt.split("/")[xslt.split("/").length - 1].split(".")
extension=w.pop
xslt_param_dir=$root + "/" + w.join(".") + "_" + extension 

puts xslt_param_dir
param=[]
if File.exists?(xslt_param_dir)	
	Dir[xslt_param_dir + "/*" ].each do |file|
		file_content=[]
		File.open(file, "r").readlines.each { |line| file_content<<line.chomp }	
		if file_content.length==1
			param_value=file_content.join(" ")
		else
			param_value="\"" + file_content.join(" ") + "\""
		end
		
		param << file.split("/")[file.split("/").length - 1] + "=" + param_value		
	end
end

# nom du résultat
res=xml_part + "-" + xslt_part + ".xml"

puts xml
puts xslt
puts res

command_line="saxon -xsl:" + xslt + " -s:" + xml + " -o:" + res + " " + param.join(" ")
puts command_line
system (command_line)

