#!/usr/bin/env ruby

require 'rubygems'
require 'open-uri'
require 'hpricot'

url = gets.strip

doc = Hpricot(open(url))

puts "begin_tsv"

url.match(/abstract_id=(\d+)/)
id = $1
filename = (doc/"//tr/td/table/tr/td/td/p/font").first.inner_text
filename.gsub!(/\.pdf/, '')
puts "linkout\tSSRN\t#{id}\t#{filename}\t\t"

puts "type\tJOUR"
puts "url\thttp://ssrn.com/abstract=#{id}"

title = (doc/"//td[@width='80%', @align='center']/font/strong").first.inner_text.strip
puts "title\t" + title

for author in (doc/"//td[@width='80%']/center//a.textlink")
  puts "author\t" + author.inner_text.strip
end

doi = (doc/"//tr/td/font/blockquote/font/a").first.inner_text
puts "doi\t#{doi}"

puts "journal\tSocial Science Research Network Working Paper Series"

date = (doc/"//tr/td[@width='80%']/center/font[@size='2']")[1].inner_text
if date =~ /^(January|February|March|April|May|June|July|August|September|October|November|December) ([0-9]{1,2}), ([0-9]{4}$)/
	puts "month\t" + $1
	puts "day\t" + $2
	puts "year\t" + $3
elsif date =~/^(January|February|March|April|May|June|July|August|September|October|November|December) ([0-9]{4}$)/
	puts "month\t" + $1
	puts "year\t" + $2
elsif date =~/^([0-9]{4})$/
	puts "year\t" + $1
end

abs = (doc/"//tr/td/font")[5].inner_text.strip
puts "abstract\t#{abs}"

puts "end_tsv"

puts "status\tok"
