#!/usr/bin/env ruby
require 'open-uri'
require 'rubygems'
require 'hpricot'

url = gets.strip
if url.match(/http:\/\/ci.nii.ac.jp\/naid\/(\d+)/)
	naid = $1

	doc = Hpricot(open(url, "User-Agent" => "lwp-request/5.810"))

	bibtex = open("http://ci.nii.ac.jp/export?fileType=2&lang=en&docSelect=#{naid}", "rb").read
	#  bibtex = open("http://ci.nii.ac.jp/export?fileType=2&docSelect=#{naid}", "rb").read

	puts "begin_tsv"
	puts "linkout\tNAID\t#{naid}\t\t\t"
	if bibtex.match(/year="(\d{4})-?(\d{2})(?:-?(\d{2}))?"/)
		puts "year\t#{$1}"
		puts "month\t#{$2.to_i}"
		puts "day\t#{$3.to_i}" if $3
	end

	if bibtex.match(/DOI="info:doi\/([^"]+)"/)
		puts "doi\t#{$1}"
	end

	abstract = doc.search("p.abstracttexten | p.abstracttextjpn")
	# TODO: get rid of need for entry-content
	# abstract = (doc/"//p[@class='abstracttexten entry-content']")
	if abstract == nil
		abstract = (doc/"//p[@class='abstracttextjpn entry-content']")
	end

	if abstract != nil and abstract.first != nil

		abstract = abstract.first.inner_text.strip
		puts "abstract\t#{abstract}"
	end


	puts "end_tsv"

	puts "begin_bibtex"
	puts bibtex
	puts "end_bibtex"

	puts "status\tok"
else
	puts "status\tnot_interested"
end
