#!/usr/bin/env ruby

require 'rubygems'
require 'open-uri'
require 'hpricot'

url = gets.strip

#puts "xxxx #{url}"

doc = Hpricot(open(url, "User-Agent" => "lwp-request/5.810"))

puts "begin_tsv"

url.match(/abstract_id=(\d+)/)
id = $1
filename=""
for a in (doc/"//a")
	href = a.attributes['href']
	if href==nil
		next
	end
	if href.match(/Delivery\.cfm\/(.*?)\.pdf/)
		filename = $1
		break
	end
end
puts "linkout\tSSRN\t#{id}\t#{filename}\t\t"

puts "type\tJOUR"
puts "url\thttp://ssrn.com/abstract=#{id}"

title = (doc/"//div[@id='abstractTitle']").first.inner_text.strip
puts "title\t" + title

for author in (doc/"//a[@title='View other papers by this author']")
  puts "author\t" + author.inner_text.strip
end

for input in (doc/"//input[@class='simField']")
	doi = input.attributes['value']
	if doi.match(/DOI:10\./)
		puts "doi\t" + doi
	end
end

puts "journal\tSocial Science Research Network Working Paper Series"

for date_el in (doc/"//h4/font")
  date = date_el.inner_text
  if date =~ /^(January|February|March|April|May|June|July|August|September|October|November|December) ([0-9]{1,2}), ([0-9]{4}$)/
    puts "month\t" + $1
    puts "day\t" + $2
    puts "year\t" + $3
    break
  elsif date =~/^(January|February|March|April|May|June|July|August|September|October|November|December) ([0-9]{4}$)/
    puts "month\t" + $1
    puts "year\t" + $2
    break
  elsif date =~/^([0-9]{4})$/
    puts "year\t" + $1
    break
  end
end

#
# The abstract seems to be got from
# <font>Abstract: </font>
# <font>[text]</font>
# i.e., we find the <font>Abstract: </font> and the abstract is the contents of the next <font></font>
#
nextone = false
for abs in (doc/"//font[@size='2']")
	if nextone
		text = abs.inner_text.strip
		puts "abstract\t#{text}"
		break
	end
	if abs.inner_text.strip.match(/^Abstract:/)
		nextone = true
	end
end


puts "end_tsv"

puts "status\tok"
