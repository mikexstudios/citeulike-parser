#!/usr/bin/env ruby

require 'open-uri'

url = gets.strip

puts "begin_tsv"

url.match(/papers\/(\w+)/)
puts "linkout\tNBER\t\t#{$1}\t\t"

doc = open("#{url}.ris")
ris = doc.readlines.join('')
ris.match(/VL\s*-\s*No\.\s*(\d+)/)
puts "start_page\t#{$1}"
puts "volume\t"

ris.match(/Y2\s*-\s*(\w+)\s*(\w+)/)
puts "month\t#{$1}"
puts "year\t#{$2}"

puts "end_tsv"

puts "begin_ris"
puts ris
puts "end_ris"
puts "status\tok"
