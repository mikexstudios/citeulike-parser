#!/usr/local/bin/python
import re, sys, urllib2, cookielib 

# regexp to extract the scopus eid of the article from the url
EID_REGEXP="&eid=[a-zA-Z0-9\.\-]*&"
# regexp to extract the input formfield holding the stateKey value for this session
STATEKEY_REGEXP='<input type="hidden" name="stateKey" value="[A-Z]*_[0-9]*">'
# regexp to extract the stateKey value from the stateKey input formfield
STATEKEY_REGEXP2='value="[A-Z]*_[0-9]*"'

#URL to the export page of an article (needed to get the stateKey value (export will fail without. Has something to do with sessions I guess))
SCOPUS_EXPORT_URL="http://www.scopus.com/scopus/citation/output.url?origin=recordpage&eid=%s&src=s&view=CiteAbsKeywsRefs"
#link to the actual RIS export of an article
SCOPUS_RIS_URL='http://www.scopus.com/scopus/citation/export.url?eid=%s&stateKey=%s&src=s&sid=&origin=recordpage&sort=&exportFormat=RIS'
#this is the querystring used to specify which fields to include in the export.
#It is possible to modify this. To know which fields are available, go to scopus, find a random article
#View the abstrac+refs, click on Output and select "Specify fields to be Exported" from the Output dropdown. Then look which formfields are available in the page source.
SCOPUS_RIS_FORMAT=[
r'view=SpecifyFields',
r'selectedAbstractInformationItems=Abstract',
r'selectedCitationInformationItems=Author%28s%29',
r'selectedCitationInformationItems=Document%20title',
r'selectedBibliographicalInformationItems=DOI',
r'selectedBibliographicalInformationItems=Publisher',
r'selectedBibliographicalInformationItems=Editor%28s%29',
r'selectedBibliographicalInformationItems=Abbreviated%20Source%20title',
r'selectedCitationInformationItems=Source%20title',
r'selectedBibliographicalInformationItems=Affiliations',
r'selectedCitationInformationItems=Year',
r'selectedCitationInformationItems=Volume%2C%20Issue%2C%20Pages',
r'selectedCitationInformationItems=Source%20and%20Document%20Type',
r'selectedOtherInformationItems=Conference%20information'
]
SCOPUS_RIS_FORMAT='&'+'&'.join(SCOPUS_RIS_FORMAT)
#Use this to just export everything
#SCOPUS_RIS_FORMAT='&view=FullDocument'

# error messages
ERR_STR_PREFIX = 'status\terr\t'
ERR_STR_FETCH = 'Unable to fetch the bibliographic data: '
ERR_STR_TRY_AGAIN = 'The server may be down.  Please try later.'
ERR_STR_NO_DOI = 'No document object identifier found in the URL: '
ERR_STR_REPORT = 'Please report the error to plugins@citeulike.org.'
ERR_STR_NO_EID = 'No eid could be found in the URL: '
ERR_STR_NO_STATEKEY = 'No statekey input field could be found in the source of the page at URL: '

# read url from std input
#url=sys.argv[1]
url = sys.stdin.readline()
#fetch the eid form the url
url = url.strip()
eid=re.search(EID_REGEXP,url).group(0)[5:-1]
if not eid:
    print ERR_STR_PREFIX+ERR_STR_NO_EID+url+'. '+ERR_STR_REPORT
    sys.exit(1)
#set up a html reader
cj=cookielib.CookieJar()
opener=urllib2.build_opener(urllib2.HTTPCookieProcessor(cj))
opener.addheaders=[('User-agent','Mozilla/5.0')] #needed to circumvent the crawler protection of Scopus

#get the html of the exportpage of this article
exporturl=SCOPUS_EXPORT_URL%(eid)
try:
    f3=opener.open(exporturl)
except:
    print ERR_STR_PREFIX+ERR_STR_FETCH+exporturl+'. '+ERR_STR_REPORT
    sys.exit(1)
exporthtml=f3.read()
#get the stateKey value for the current session and export
formfield=re.search(STATEKEY_REGEXP,exporthtml,re.MULTILINE).group(0)
stateKey=re.search(STATEKEY_REGEXP2,formfield).group(0)[7:-1]
if not stateKey:
    print ERR_STR_PREFIX+ERR_STR_NO_STATEKEY+exporturl+'. '+ERR_STR_REPORT

#get the RIS export version of the current article
risurl=SCOPUS_RIS_URL%(eid,stateKey)+SCOPUS_RIS_FORMAT
try:
    f2=opener.open(risurl)
except:
    print ERR_STR_PREFIX+ERR_STR_FETCH+risurl+'. '+ERR_STR_REPORT
    sys.exit(1)
ris=f2.read()

#get the doi
try:
    doi=re.search('^N1  - doi: \S*',ris,re.MULTILINE)
    doi=doi.group(0)
    doi=re.search('10\.\S*',doi).group(0)
except:
    doi=""

#get the document type
tpe=re.search('^TY  - \S*',ris,re.MULTILINE).group(0)[6:]

ris=str(ris).split('\n')
#remove the Source: Scopus and Export Date fields and some others. Also remove empty lines
ris2=ris[:]
ris=[]
for line in ris2:
    if not "Source: Scopus" in line and not "Export Date" in line and line!='' and not 'UR  - ' in line and not 'N1  - doi:' in line and not "Conference Code:" in line:
        ris.append(line)

ris='\n'.join(ris)

# print the results
print "begin_tsv"
print "linkout\tSCOPUS\t\t%s\t\t" % (eid)
if doi:
    print "linkout\tDOI\t\t%s\t\t" % (doi)
print "type\t%s"%tpe
print "doi\t" + doi
print "end_tsv"
print "begin_ris"
print ris
print "end_ris"
print "status\tok"
