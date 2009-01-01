#!/usr/bin/env ruby

require 'rubygems'
require 'open-uri'
require 'hpricot'

url = gets.strip



doc = Hpricot(open(url, "User-Agent" => "lwp-request/5.810"))

url.match(/abstract_id=(\d+)/)
id = $1

#<BEGIN_RIS>###########################################################
#
# We get the RIS stuff here becuase we need to know if it's available
# first so we don't duplicate any data, esp. author fields.
#
# The RIS/BibTeX data is actually pretty crap - no abstract and the dates are only
# year.  Since we need to screenscrape that it's arguable whether it's worth doing
# this at all.
#
# bibtex is broken because there's no citation-key and citeulike.bst barfs.
#
# TODO: error handling

format = "ris"
format_id = 3; # 2 for bibtex, 3 for RIS

# A file with a single line like
# SSRN_LOGIN=me%40domain%2Ecom; SSRN_PW=mypassword
file = File.new(ENV['HOME']+"/.ssrncookie", "r")
cookie = file.gets
file.close

meta = Hpricot(open("http://papers.ssrn.com/sol3/RefExport.cfm?abstract_id=#{id}&format=#{format_id}",
	"User-Agent" => "lwp-request/5.810",
	"Cookie" => cookie
))
ris = (meta/"//input[@name='hdnContent']")
#
# The RIS data is actually dumped at the end - I think it could go here
# but all the other plugins seem to put it at the end.
#
##<END_RIS>#########################################################


puts "begin_tsv"

#
# Look PDF "filename" from a 
# <a href="/Delivery.cfm/xxxxxx.pdf......">
#
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
# Why no DOI linkout?
puts "linkout\tSSRN\t#{id}\t#{filename}\t\t"

puts "type\tJOUR"
puts "url\thttp://ssrn.com/abstract=#{id}"

title = (doc/"//div[@id='abstractTitle']").first.inner_text.strip
puts "title\t" + title

# Only bother with authors if the RIS wasn't found (otherwise get duplicates)
if not ris
  for author in (doc/"//div[@id='innerWhite']/center/font/a[@title='View other papers by this author']")
    puts "author\t" + author.inner_text.strip.squeeze(" ")
  end
end

for input in (doc/"//input[@class='simField']")
	doi = input.attributes['value']
	if doi.match(/DOI:(10\..*)/)
		puts "doi\t" + $1
	end
end

puts "journal\tSocial Science Research Network Working Paper Series"

#
# Lots of matches for this, but only 2(?) match a date.   We want the first one ("first published")
#
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

if ris
	puts "begin_#{format}"
	puts ris.first.attributes['value']
	puts "end_#{format}"
end

puts "status\tok"
