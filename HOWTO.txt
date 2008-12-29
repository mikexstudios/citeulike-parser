
--------------------------------
CiteULike Plugin Developer's Kit
--------------------------------

CiteULike <http://www.citeulike.org> is a free website to help
academics keep track of the stuff they're reading in a pain-free
way. Users are encouraged to make their libraries publicly available
on the web so others can get the benefit of discovering useful
articles they might not otherwise have found.

One of the key features is that it's clever enough to automatically
extract the citation details (title, author, journal name, page
number, etc) from an article on the web without you having to copy and
paste them in yourself. To do this, it uses an extensible architecture
of "plugins" which are responsible for taking a URL, fetching whatever
details might be required, and then returning them in a consistent
format which can be used by the system.

You're looking at the source code for the "plugins". They are released
under an open source license, and it's hoped that they may be of some
use to the community (especially those who work in text mining). Of
course, the real reason they're available as I'd like as many people
as possible to be involved with writing plugins for CiteULike. Got a
journal that you'd like to post from, but CiteULike doesn't currently
support it? You should be able to write a plugin for the system in
relatively short order. The instructions here are designed to be as
simple as possible, especially if you don't have a great deal of
programming experience.

==Prerequisites==

=Operating System=

It would help a lot if you have a Unix style development environment
to work on. The following systems are ideal:

* Mac OS X
* Linux
* Solaris/Irix/HPUX/other commercial Unix system

If you're a Windows user, then that's not so ideal (in general too),
but you can work round its shortcomings by installing Cygwin - a
compatibility layer which lets your computer operate in a more Unix
like way <http://www.cygwin.com/>. You'll probably want to take a look
at the Cygwin user's guide if this is all new to you
<http://sources.redhat.com/cygwin/cygwin-ug-net/>.

==Installing==

You can download the source using subversion:

  svn co http://svn.citeulike.org/svn/plugins

==Running==

You can run the CiteULike plugin test harness from the command line
to help you develop your plugin. In the plugins directory, here are
some examples of some valid commands:

---
wilt:~/citeulike/opensource/plugins rcameron$ ./driver.tcl parse 'http://www.nature.com/nature/journal/v435/n7043/full/435718a.html'
parsing http://www.nature.com/nature/journal/v435/n7043/full/435718a.html

serial -> 0028-0836
volume -> 435
linkouts -> {NATUR 435 435718a 7043 nature} {DOI {} 10.1038/435718a {} {}}
year -> 2005
type -> JOUR
start_page -> 718
url -> http://dx.doi.org/10.1038/435718a
end_page -> 719
plugin_version -> 1
doi -> 10.1038/435718a
issue -> 7043
title -> Chemistry society goes head to head with NIH in fight over public database
journal -> Nature
status -> ok
month -> 6
authors -> {Marris Emma E {Marris, Emma}}
plugin -> nature
--


---
wilt:~/citeulike/opensource/plugins rcameron$ ./driver.tcl parse 'http://www.apple.com'
parsing http://www.apple.com

No plugin was interested in this url.
---


---
wilt:~/citeulike/opensource/plugins rcameron$ ./driver.tcl test nature
Testing nature 1/2
Testing nature 2/2
---



---
wilt:~/citeulike/opensource/plugins rcameron$ ./driver.tcl test all
Testing all plugins

Please note that some tests may fail if you are running them from a
machine which does not have access rights to the content, or if the
scraper is written in an obscure language which you don't have installed
on your machine.

Testing citeseer 1/2
Testing citeseer 2/2
Testing jstor 1/5
Testing jstor 2/5
Testing jstor 3/5
Testing jstor 4/5
Testing jstor 5/5
Testing nature 1/2
...
---

=Language=

You can write CiteULike plugins in any language you like, but you'll
probably get on much easier if you use a "scripting" language like
Perl, Python, Tcl or Ruby with strong support for "regular
expressions". If you're going to use a particularly obscure language,
it's wise to check with me first <plugins@citeulike.org> to check I
can support it on the server.

If you've not got much experience with programming, you'll need to
learn enough of your language to be able to handle "regular
expressions" effectively. See the language's documentation for
details.

If you're using a language like Perl, it would be helpful if you
could keep the number of obscure CPAN modules required to a minimum.

==Architecture==

The requirements for a plugin are that it must be capable of accepting
a URL as input, it must fetch that URL (or a related URL(s) - such as
an article summary page - if it thinks that would be a better
approach), and produce the relevant citation information as a bunch of
key-value pairs. In addition, the CiteULike driver provides certain
utility functions which will help you parse authors names and decide
which part is the surname, etc. There is also basic support for
parsing RIS and BibTeX records within the driver, so if your plugin
can find one of those for your article, you're laughing.

As well as the code to do this, each plugin must provide a
"description" file which explains to CiteULike what the plugin does,
who the author is, and - most critically - provides test cases which
make sure that the plugin is still working. The business of writing
code which scrapes data from the web is generally quite a tricky
one. Scrapers tend to be incredibly fragile and are likely to break
whenever the host site decides to do a redesign. With test cases,
CiteULike can periodically check that your code still works.

So, putting everything together, there are several components to the
plugin system.

1) The "driver" code is the part which glues the plugins into the core
   of CiteULike. It's responsible for routing a URL to the appropriate
   plugin, taking the result from that plugin and applying any
   post-processing steps which need doing (such as parsing author
   names into surname/first_name, and parsing any RIS/BibTeX records
   the plugin might have found).
   
   The driver also knows how to run the tests, so you'll be
   interacting with it to test your plugin knows what it's doing.

   It's also responsible for reading the "description files" - those
   are the things which store details of who the author is, what site
   it actually parses, etc.

2) The "scraper" code is a stand-alone program (written in whatever
   language you like) which is responsible for making the HTTP
   request, and using regular expressions (or however you want to do
   it) to spit out the pertinent details in a simple intermediate
   format. Currently, the driver will just exec() your script, and
   send it the URL on stdin. While this probably isn't an ideal
   performance design, it's simple enough to allow rapid development,
   and it's probably not too bad compared with the time it takes to
   make the HTTP request anyway.

==Example==

I'll now take you through a simple example of how to write a plugin.

a) The Description file

The first thing to write is the CiteULike description file. This needs
to go in the "descr" directory, with the extension CUL. You'll see
some examples in that directory which you can use as a template for
your own work.

The description file must do two things:

	1) The "plugin" directive. This must be in the fairly intuitive syntax below. It's actually
	   a Tcl expression, but you don't need to know that in order to make it work. Comments are
	   permitted, and any line starting with "#" will be ignored.

		Here's an example:
		
		----
		plugin {
			version {1}
			name {JSTOR}
			url {http://www.jstor.org}
			blurb {}
			author {Richard Cameron}
			email {camster@citeulike.org}
			language {tcl}
			regexp {jstor.org[^/]*/(browse|view|cgi-bin/jstor/viewitem)/([a-zA-Z0-9]+)/([a-zA-Z0-9]+)/([a-zA-Z0-9]+)}
		}
		----


	The following fields are required to be defined in the directive:

		author:

			Your name, as you'd like to see it displayed.

		email

			Your email address for general correspondence about the
			plugin.  I won't publish this address on the CiteULike
			site, but you should be aware that the plugin system is an
			open source project, so your file will be available for
			others to see on SourceForge. It's unlikely that the
			spammers will have developed spiders which browse through
			the CVS repository to harvest this email, but you should
			be aware this is possible.  Use a throw-away email address
			if you must, but it would be nice to be able to contact
			you if anyone has any questions about your code.

		language

			You must tell CiteULike what language you've decided to
			write your plugin in.  Values which will "just work" are
			"tcl" "perl" "python" and "ruby". You may write your
			plugin in another language, but you'll need to modify the
			driver.tcl file (and this documentation) to explain to it
			how to run your program.
		
		regexp

			The driver needs to know which plugin to route a URL
			to. To a first approximation, it uses a regular expression
			to do this. You plugin should provide a regular expression
			(in Tcl regexp syntax
			<http://www.hmug.org/man/n/re_syntax.php>) which expresses
			an interest in any URL it thinks it might be able to
			parse.  Such a match is not a binding contract that the
			plugin must be able to parse the URL.  Sometimes it's just
			not possible to tell from a URL alone whether you can deal
			with it.  In that case, it's possible to speculatively say
			"yes", and then defer the decision to your code. However,
			you should try to avoid doing this wherever possible, as
			the overhead of making the extra HTTP requests puts load
			both on CiteULike and the external site.

		version

			A simple integer version number for the code in your
			module. Whenever you change anything which potentially
			could fix errors in previous parses, you should increment
			your version by one. CiteULike may then go back and
			re-parse everything you've done to date. CiteULike is
			responsible for maintaining a cache of old HTTP request,
			so we don't launch a DoS attack on our host sites when we
			do this re-parsing.

			Obviously, this sort of re-parsing is expensive, so don't
			update the version number unless you mean it.


	The following fields are optional:

		name
			
			This is the name of the site you intend to scrape. It will be
			published on the CiteULike site under the list of supported
			plugins. The reason this is optional is that there are some strange
			plugins which don't scrape, but are only responsible for formatting
			linkouts. DOIs are an example of this.

		url
		
			This is the link to the front page of the site you're scraping. I'll
			use this to provide a link on the "supported plugins" page on CiteULike.

		blurb

			If there's any extra information you need to display on the CiteULike website
			then this is the place to do it. It's rare that you'll need this, but I sometimes
			display something like "Experimental support" which is the sort of indemnifier that
			Google produce with the word "beta" = "It probably works, but it's a bit new and
			we're quite scared that it won't."

		
2) The linkout formatter

		It was a slightly lie to say that you could write your plugin in any
		language. There's one function you'll need to write in Tcl. However,
		it's so trivial that you won't need to learn anything about the
		language, you can just look at some examples and copy those.
		
		Remember that CiteULike doesn't store actual URLs to articles - it
		tries to store the raw information required to manufacture a link. The
		reason behind this is that publishers can be quite brutal and insane
		sometimes about changing the URL structure on their sites. Sometimes
		(as in the case of Nature), they'll just break existing links to
		articles without telling anyone. In these situations, it's vital that
		CiteULike can dynamically produce the new style of URL so that the
		existing articles from that publisher in the system can still be
		accessed.
		
		Thus, each article has associated with it a number of "linkouts". Each
		linkout is a five-element list: (type, ikey_1, ckey_1, ikey_2,
		ckey_2). Here "i" stands for "integer" and "c" stands for
		character. The idea is that we try to capture the internal identifier
		used by the system you're scraping to represent the article. For
		example, this paper on PubMed
		<http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=pubmed&dopt=Abstract&list_uids=10972276&query_hl=2>
		seems to have an internal ID of 10972276. How we represent this
		information in the five element field is up to the plugin, but we need
		to specify a unique type for this "pubmed linkout". In this case,
		we'll use "PMID" (the maximum length for the type is six characters),
		and choose to encode the integer 1972276 in the "integer key 1" field:
		ikey_1. Thus we have:
		
		(PMID,1972276,,,)
		
		This is how the linkout gets stored in the database (and your plugin
		is responsible for producing this data when it scrapes). What we're
		talking about here is the process where the linkout is converted back
		into an ordinary URL for the user to click on. This is done using a
		trial Tcl procedure defined in the description file. Here's the
		example for PubMed:
		
		format_linkout PMID {
			return [list "PubMed" \
						"http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=pubmed&dopt=Abstract&list_uids=${ikey_1}"\
						"HubMed" \
						"http://www.hubmed.org/display.cgi?uids=${ikey_1}"
				   ]
		}
		
		You must specify the type of the linkout you intend to
		format. CiteULike will only call your format_linkout procedure for
		that type. It also does some checking to make sure that two plugins
		don't inadvertently share the same type code.
		
		In the body of the procedure, you can write standard Tcl code to
		return a list with an even number of elements. What you're seeing here
		is another advantage of not storing URLs directly. From a PubMed ID,
		it's possible to create a link to Alf Eaton's excellent HubMed site
		too. To do this, the elements in odd positions store the text which
		will be displayed to the user to explain which site he's about to be
		taken to; the elements in even positions hold the actual
		URLs.


3) Tests.

	It's really vital that your plugin defines some test cases so we can
	tell when it suddenly breaks (such is the nature of scraping
	code). Here's an example of a test case:
	
	
	test {http://www.jstor.org/view/00376752/ap010113/01a00130/0} {
		formatted_url {JSTOR http://links.jstor.org/sici?sici=0037-6752%28198424%291%3A28%3A4%3C533%3AANOMEG%3E2.0.CO%3B2-3}
		linkout {JSTOR {} 0037-6752%28198424%291%3A28%3A4%3C533%3AANOMEG%3E2.0.CO%3B2-3 {} {}}
		volume 28
		year 1984
		issue 4
		author {Fiene Donald DM {Donald M. Fiene}}
		title {A Note on May Eve, Good Friday, and the Full Moon in Bulgakov's The Master and Margarita}
		start_page 533
		end_page 537
		journal {The Slavic and East European Journal}
		status ok
	}
	
	The syntax is relatively straightforward. The parameter after the word
	"test" is the URL that the plugin is expected to deal with. Following
	that, comes key-value pairs of everything the plugin should be
	expected to produce. See the "standard fields" section for details on
	what's permitted here. You should note that the data's not stored in
	tab separated format (is the plugin is expected to emit), but it a
	more human readable notation (actually Tcl's internal format). The two
	specific differences here are:
	
	formatted_url:
	
			This must be a two element list storing, respectively, the
			textual description of the link as produced by the
			format_linkout procedure, and the actual url as produced by
			the format_linkout procedure.
	
			Multiple instances of this fields are permitted - one for
			each URL produced by format_linkout.
	
	author:
	
			Rather than just storing the raw text name of the author,
			the test case assumes that it's getting the parsed version
			of the author. It's a four-element list, the elements being:
	
			last_name, first_name, initials, raw_name.
			
			The raw_name is just the unparsed version of the name returned
			by your parsing code, first_name and last_name are obvious,
			and the initials field stores all initials *including* the first name.
			So, "Richard D Cameron" has initials "RD" and not just "D".
	
	Multiple test cases are permitted and, indeed, encouraged.
	



b) The parsing code

   Once you've described to CiteULike what your plugin actually does,
   you need to write the code to do it. CiteULike is flexible about
   how you do this. All you need to produce is an executable file
   which reads one line from standard input and then outputs the
   details of the article to standard output in a particular
   format. This format is designed to be as simple as possible to make
   it reasonably quick and easy to develop plugins.

   Simply write your scraper, and put it in the appropriate language
   directory.  Your file must have the same name as your description
   file, but with the appropriate language extension. So the
   description file "jstor.cul" should have a scraper executable
   called "jstor.tcl" (assuming it is defined to be written in Tcl).

   Here's an example some output from a plugin for JSTOR:

---
$ echo 'http://www.jstor.org/view/00376752/ap010113/01a00130/0' | ./jstor.tcl
begin_tsv
linkout	JSTOR		0037-6752%28198424%291%3A28%3A4%3C533%3AANOMEG%3E2.0.CO%3B2-3		
title	A Note on May Eve, Good Friday, and the Full Moon in Bulgakov's The Master and Margarita
author	Donald M. Fiene
journal	The Slavic and East European Journal
volume	28
issue	4
year	1984
start_page	533
end_page	537
type	JOUR
end_tsv
status	ok
---

	The status line must be the *last* line of the output (the reason
	it's that way round is it's a lot easier to know what the status
	is after you've done all the work). Its a tab separate line with
	either two or three fields. These fields are:

	1) The word "status"

	2) Either "ok" "err" "not_interested" or "redirect".

	   "ok" indicates that all has gone well, and the scraper has
	   successfully extracted all that it can.

	   "err" indicates that something out of the ordinary went
	   wrong. In this case the third field must be populated with an
	   error message. This error will be displayed to the CiteULike
	   user, so it should not be overly technical, but just explain why
	   it's not possible to parse the document.

	   "redirect" indicates that although this plugin might not know
	   what to do with the URL, it knows that another plugin might be
	   able to handle it. In this case, the third field must be
	   populated with an equivalent URL which someone else can deal
	   with. A good example of when this is useful would be the
	   "hubmed" site <http://www.hubmed.org>. As it's just an
	   alternative view of the PubMed site, it makes sense just to
	   defer the request to that plugin.

	   "not_interested" is for the case when the regular expression in
	   the description file matched the url but, after actually
	   fetching it and having a look, you've decided that you can't
	   parse the request after all. This should be used sparingly.


	The actual data extracted should belong in one of three sections:
	tsv, ris, or bibtex.

	TSV:

		The data must start with the line "begin_tsv" and end with a
		line "end_tsv". Sandwiched in between should be a sequence of
		key-value pairs. The keys should be from the list in the
		"standard fields" section of this document. The only slightly
		oddity is the "linkout" field which is the five element list
		defined in the "linkout formatter" section. The five elements
		are tab separated.

		This is probably the preferred method where you're scraping
		the details from the HTML with regular expressions. See the
		example above, and the tcl/jstor.tcl file for an example of
		code which produces this output.

	RIS:
	BibTeX:
		
		Some publishers have an "export citation" link on their site
		which lets you pull down the data in either RIS or BibTeX
		format. To save having to parse this format yourself, you may
		simply send the contents of the RIS file back to the driver
		and have it do the processing. To do this, simply sandwich the
		data between either begin_ris/end_ris lines, or between
		begin_bibtex/end_bibtex lines.

		It is permitted to produce a hybrid of tsv and ris/bibtex
		data. The TSV will take precedence over the RIS/BibTeX
		content. This allows you to manually override the contents of
		the RIS/BibTeX file without having to parse it yourself. You
		may also include extra fields which are absent from the
		Ris/BibTeX file on the site (the abstract is a common
		example).



==Standard Fields==

The output from the scraper, and the values in the test cases expect
the following standard fields. You may output any other fields you
like and CiteULike will just ignore them.


      citeulike_field      | bibtex_equivalent | ris_equivalent 
---------------------------+-------------------+----------------
 abstract                  | abstract          | AB
 address                   | address           | AD
 chapter                   | chapter           | 
 date_other                |                   | 
 day                       |                   | 
 edition                   | edition           | 
 end_page                  |                   | EP
 how_published             | howpublished      | 
 institution               | institution       | 
 isbn                      | isbn              | SN
 issn                      | issn              | SN
 issue                     | number            | IS
 journal                   | journal           | JO
 month                     |                   | 
 organization              | organization      | 
 publisher                 | publisher         | PB
 school                    | school            | 
 start_page                |                   | SP
 title                     | title             | TI
 title_secondary           | booktitle         | BT
 title_series              | series            | T3
 type                      |                   | 
 volume                    | volume            | VL
 year                      | year              | 



abstract:
		Raw text of the article's abstract. HTML and TeX are permitted
		and (one day) CiteULike will format them correctly.

address:
		Raw address of the publisher's address. This is appropriate
		especially for books, and should not be used to represent the
		address of the *author*.

chapter:
		Alphanumeric representation of the chapter this article
		appears in.

date_other:
		A date representation which doesn't fit into the standard
		mm/dd/yyyy notation. For example "Summer".

day:
		Numeric representation of the day of the month this article
		was published.

edition:
		The edition of a book, usually written in full as "Second"

end_page:
		The last page the article occupies in this issue. May be
		alphanumeric for publishers which insist on numbering their
		pages using letters.


how_published:
		Anything unusual about the method of publishing. E.g.: "Privately Published" 

institution:
		The name of the sponsoring institution for a technical report

isbn:
		The book's ISBN

issn:
		The journal's ISSN number

journal: 
		 The full (unabbreviated) journal title

month:
		Numeric month of the year 1-12.

organization:
		The sponsoring organisation for a conference or a manual

publisher:
		The publisher's name.

school:
		The name of the academic institution where a thesis was written

start_page:
		The first page the article occupies in this issue. May be
		alphanumeric for publishers which insist on numbering their
		pages using letters.
		
title:
		The title of this article.

title_secondary:
		The title of a book when only part is being cited.

title_series:
		The name of a series or a set of books

type:
		A coded indication of the type of article. See the next
		section for more details.

volume:
		The volume number of a journal or multi-volume book.
		
year:
		Four digit representation of the year of publication.


==Article Type==

Each article must define a field called "type" taking one of the following values:

 citeulike_type |           description            | bibtex_equivalent | ris_equivalent 
----------------+----------------------------------+-------------------+----------------
 BOOK           | Book                             | book              | BOOK
 CHAP           | Book chapter/section             | inbook            | CHAP
 CONF           | Conference proceedings (whole)   | proceedings       | CONF
 ELEC           | Electronic citation              | misc              | ELEC
 GEN            | Miscellaneous                    | misc              | GEN
 INCOL          | Book part (with own title)       | incollection      | CHAP
 INCONF         | Conference proceedings (article) | inproceedings     | CONF
 INPR           | In the press                     | unpublished       | INPR
 JOUR           | Journal article                  | article           | JOUR
 MANUAL         | Manual (technical documentation) | manual            | BOOK
 MTHES          | Thesis (Master's)                | mastersthesis     | THES
 PAMP           | Booklet                          | booklet           | PAMP
 REP            | Technical report                 | techreport        | RPRT
 THES           | Thesis (PhD)                     | phdthesis         | THES
 UNPB           | Unpublished work                 | unpublished       | UNPB


==How to submit your code==

Once you think you've got a working plugin, make sure that you write
copious test cases for it. As a developer, you know where the weak
spots in your code are, and where you've written the stuff most likely
to break when the site is redesigned. Please include test cases for
all of those.

When you're happy it works for all the articles on your site, please
submit your code to <plugins@citeulike.org>. I'll review the code and
make sure it's not going to do anything nasty to the server when it
runs. If everything checks out, I'll commit it to the repository on
SourceForge and put it online for you to use.


==Questions and Bugs==

It's entirely possibly that this documentation is incomplete. If you
have any questions, please contact <plugins@citeulike.org>. If you
think there's a bug anywhere in the code, I'd be delighted to receive
any patches which fix it. If you can't fix it, then please let me know
anyway, and I'll sort it out myself.

