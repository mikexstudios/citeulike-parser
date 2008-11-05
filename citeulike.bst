% Richard Cameron
% February 2005
% camster@citeulike.org

% Hack to turn bibliographies into a format Tcl can read easily.

% Based on refer.bst, original copyright notice is:

% March & April 1998
% James R. Larus
% larus@cs.wisc.edu
% Modified to produce better output for EndNote.
%
% 8/4/'90
%Ciaran McHale
%Department of Computer Science, Trinity College, Dublin 2, Ireland.
%Telephone: +353-1-772941 ext 1538    FAX: +353-1-772204   Telex: 93782 TCD EI
%email: cjmchale@cs.tcd.ie       or      cjmchale%cs.tcd.ie@cunyvm.cuny.edu
% Hacked together by Ciaran McHale (cjmchale@cs.tcd.ie) to translate
% BibTeX bibliographies into refer format
% Based on a bib style file by Kannan Varadhan
%



ENTRY
  {                                     % Arbitrary fields are ignored
    abstract
    address
    annote
    author
    booktitle
    chapter
    citeseerurl
    comment
    doi
    edition
    editor
    eid
    eprint
    howpublished
    institution
    journal
    key
    keywords
    local-url
    month
    note
    number
    organization
    pages
    publisher
    pdf
    school
    series
    title
    type
    url
    volume
    year
    mrnumber
    location
    priority
    citeulike-article-id
    issn
    isbn
  }
  {}                                    % no integer entry variables
  { label extra.label sort.label }      % label entry variables


STRINGS { s t a.name }


FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}

FUNCTION {and}
{   'skip$
    { pop$ #0 }
  if$
}

FUNCTION {or}
{   { pop$ #1 }
    'skip$
  if$
}

INTEGERS { nameptr namesleft numnames }

FUNCTION {handle.names}
{ 't :=         % type e.g. "A" for authors, "E" for editors
  's :=         % the string containing the names
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }

    { s nameptr "{ff{ }} {vv{ }} {ll{ }}{, jj}" format.name$ 'a.name :=

      a.name "others" =
        'skip$  % don't print out "%A others"
        { t "~citeulike-magic-level-1-separator~" * a.name * "~citeulike-magic-level-1-separator~" * write$ newline$ }
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {handle.maybe.empty}
{
  't :=
  duplicate$
  empty$
    'pop$
    { t "~citeulike-magic-level-1-separator~" * swap$ * "~citeulike-magic-level-1-separator~" * write$ newline$ }
  if$
}


FUNCTION {doprint1}
{
  abstract "abstract" handle.maybe.empty
  address "address" handle.maybe.empty
  annote "annote" handle.maybe.empty
  booktitle "booktitle" handle.maybe.empty
  chapter "chapter" handle.maybe.empty
  citeseerurl "citeseerurl" handle.maybe.empty
  comment "comment" handle.maybe.empty
  doi "doi" handle.maybe.empty
  edition "edition" handle.maybe.empty
  eid "eid" handle.maybe.empty
  eprint "eprint" handle.maybe.empty
  howpublished "howpublished" handle.maybe.empty
  institution "institution" handle.maybe.empty
  journal "journal" handle.maybe.empty
  key "key" handle.maybe.empty
  keywords "keywords" handle.maybe.empty
  local-url "local-url" handle.maybe.empty
  month "month" handle.maybe.empty
  note "note" handle.maybe.empty
  number "number" handle.maybe.empty
  organization "organization" handle.maybe.empty
  pages "pages" handle.maybe.empty
  pdf "pdf" handle.maybe.empty
  publisher "publisher" handle.maybe.empty
  school "school" handle.maybe.empty
  series "series" handle.maybe.empty
  title "title" handle.maybe.empty
  type "type" handle.maybe.empty
  url "url" handle.maybe.empty
  volume "volume" handle.maybe.empty
  year "year" handle.maybe.empty
  mrnumber "mrnumber" handle.maybe.empty
}
FUNCTION {doprint2}
{
  location "location" handle.maybe.empty
  priority "priority" handle.maybe.empty
  citeulike-article-id "citeulike-article-id" handle.maybe.empty
  issn "issn" handle.maybe.empty
  isbn "isbn" handle.maybe.empty
}
FUNCTION {translate}
{
  newline$

  "~citeulike-magic-level-0-separator~" * cite$ * "~citeulike-magic-level-0-separator~" * write$ newline$

  % there may be multiple authors so handle it differently
  author empty$
    { " empty author " cite$ * warning$ }
    { author "author" handle.names }
  if$

  editor empty$
    { }
    { editor "editor" handle.names }
  if$

  doprint1
  doprint2

  "~citeulike-magic-level-0-separator~" write$ newline$
}


FUNCTION {article} { type$ translate }
FUNCTION {book} { type$ translate }
FUNCTION {booklet} { type$ translate }
FUNCTION {conference} { type$ translate }
FUNCTION {inbook} { type$ translate }
FUNCTION {incollection} { type$ translate }
FUNCTION {inproceedings} { type$ translate }
FUNCTION {manual} { type$ translate }
FUNCTION {mastersthesis} { type$ translate }
FUNCTION {misc} { type$ translate }
FUNCTION {phdthesis} { type$ translate }
FUNCTION {proceedings} { type$ translate }
FUNCTION {techreport} { type$ translate }
FUNCTION {unpublished} { type$ translate }
FUNCTION {default.type} { cite$ " has an unknown entry type. Converting it to type 'misc'" * warning$ 
	"misc" translate}


% Added by larus

MACRO {jan} {"January"}

MACRO {feb} {"February"}

MACRO {mar} {"March"}

MACRO {apr} {"April"}

MACRO {may} {"May"}

MACRO {jun} {"June"}

MACRO {jul} {"July"}

MACRO {aug} {"August"}

MACRO {sep} {"September"}

MACRO {oct} {"October"}

MACRO {nov} {"November"}

MACRO {dec} {"December"}

MACRO {acmcs} {"ACM Computing Surveys"}

MACRO {acta} {"Acta Informatica"}

MACRO {cacm} {"Communications of the ACM"}

MACRO {ibmjrd} {"IBM Journal of Research and Development"}

MACRO {ibmsj} {"IBM Systems Journal"}

MACRO {ieeese} {"IEEE Transactions on Software Engineering"}

MACRO {ieeetc} {"IEEE Transactions on Computers"}

MACRO {ieeetcad}
 {"IEEE Transactions on Computer-Aided Design of Integrated Circuits"}

MACRO {ipl} {"Information Processing Letters"}

MACRO {jacm} {"Journal of the ACM"}

MACRO {jcss} {"Journal of Computer and System Sciences"}

MACRO {scp} {"Science of Computer Programming"}

MACRO {sicomp} {"SIAM Journal on Computing"}

MACRO {tocs} {"ACM Transactions on Computer Systems"}

MACRO {tods} {"ACM Transactions on Database Systems"}

MACRO {tog} {"ACM Transactions on Graphics"}

MACRO {toms} {"ACM Transactions on Mathematical Software"}

MACRO {toois} {"ACM Transactions on Office Information Systems"}

MACRO {toplas} {"ACM Transactions on Programming Languages and Systems"}

MACRO {tcs} {"Theoretical Computer Science"}

READ

ITERATE {call.type$}
