#!/usr/bin/env ruby

require 'rubygems'
require 'mechanize'

url = gets.strip
agent =  WWW::Mechanize.new
agent.read_timeout = 3

rcount=0
begin
  page = agent.get url
rescue EOFError
  if rcount<3 then
    rcount+=1
    retry
  else
    raise
  end
end

form=page.form('citationform')

# Switch to citation tab if needed
unless form
  url.match /content=(\w*)\~/
  infoworld_id = $1
  url = "http://www.informaworld.com/smpp/content~db=all~content=#{infoworld_id}~tab=citation"
  rcount = 0
  begin
    page = agent.get url
  rescue EOFError
    if rcount<3 then
      rcount+=1
      retry
    else
      raise
    end
  end
  form = page.form('citationform')
end

unless form
  print "status\terr\tI don't recognise this as single article on the informworld web site.\n"
  exit(0)
end

form.fields.name('citstyle').options.value('plain').first.select
form.radiobuttons.name('format').value='file'
form.radiobuttons.name('showabs').value=true

ris_entry = agent.submit(form).body

if ris_entry.match /TY  - JFULL/
  print "status\terr\tI can only bookmark individual articles. Please view a single article (not the whole issue of the journal) and try again.\n"
  exit(0)
end

if ris_entry.match /TY  - BOOK/
  print "status\terr\tPosting books from informaworld is not currently supported. You could try posting them from Amazon instead.\n"
  exit(0)
end

unless ris_entry.match /UR  - http:\/\/www.informaworld.com\/([^\/]*?\/[^\/]*?)\n/
  print "status\terr\tI can't find a DOI for this article.\n"
  exit(0)
else
  doi = $1
end


# Strip out random HTML junk which makes it to the RIS record
ris_entry = ris_entry.gsub(/<br \/>/, '')

puts "begin_tsv"
puts "linkout\tDOI\t\t#{doi}\t\t"
puts "type\tJOUR"
puts "doi\t#{doi}"
puts "end_tsv"
puts "begin_ris"
puts ris_entry
puts "end_ris"
puts "status\tok"
