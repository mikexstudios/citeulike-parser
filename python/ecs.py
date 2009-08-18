# Author: Kun Xi <kunxi@kunxi.org>
# License: Python Software Foundation License

"""
A Python wrapper to access Amazon Web Service(AWS) E-Commerce Serive APIs,
based upon pyamazon (http://www.josephson.org/projects/pyamazon/), enhanced
to meet the latest AWS specification(http://www.amazon.com/webservices).

This module defines the following classes:

- `Bag`, a generic container for the python objects
- `ListIterator`, a forward iterator adapter
- `PaginatedIterator`, a page-based iterator using lazy evaluation

Exception classes:

- `AWSException`
- `NoLicenseKey`
- `BadLocale`
- `BadOption`
- `ExactParameterRequirement`
- `ExceededMaximumParameterValues`
- `InsufficientParameterValues`
- `InternalError`
- `InvalidEnumeratedParameter`
- `InvalidISO8601Time`
- `InvalidOperationForMarketplace`
- `InvalidOperationParameter`
- `InvalidParameterCombination`
- `InvalidParameterValue`
- `InvalidResponseGroup`
- `InvalidServiceParameter`
- `InvalidSubscriptionId`
- `InvalidXSLTAddress`
- `MaximumParameterRequirement`
- `MinimumParameterRequirement`
- `MissingOperationParameter`
- `MissingParameterCombination`
- `MissingParameters`
- `MissingParameterValueCombination`
- `MissingServiceParameter`
- `ParameterOutOfRange`
- `ParameterRepeatedInRequest`
- `RestrictedParameterValueCombination`
- `XSLTTransformationError`

Functions:

- `setLocale`
- `getLocale`
- `setLicenseKey`
- `getLicenseKey`
- `getVersion`
- `setOptions`
- `getOptions`
- `buildRequest`
- `buildException`
- `query`
- `SimpleObject`
- `Collection`
- `Pagination`
- `unmarshal`
- `ItemLookup`
- `XMLItemLookup`
- `ItemSearch`
- `XMLItemSearch`
- `SimilarityLookup`
- `XMLSimilarityLookup`
- `ListLookup`
- `XMLListLookup`
- `ListSearch`
- `XMLListSearch`
- `CartCreate`
- `XMLCartCreate`
- `CartAdd`
- `XMLCartAdd`
- `CartGet`
- `XMLCartGet`
- `CartModify`
- `XMLCartModify`
- `CartClear`
- `XMLCartClear`
- `SellerLookup`
- `XMLSellerLookup`
- `SellerListingLookup`
- `XMLSellerListingLookup`
- `SellerListingSearch`
- `XMLSellerListingSearch`
- `CustomerContentSearch`
- `XMLCustomerContentSearch`
- `CustomerContentLookup`
- `XMLCustomerContentLookup`
- `BrowseNodeLookup`
- `XMLBrowseNodeLookup`
- `Help`
- `XMLHelp`
- `TransactionLookup`
- `XMLTransactionLookup`

Accroding to the ECS specification, there are two implementation foo and XMLfoo, for example, `ItemLookup` and `XMLItemLookup`. foo returns a Python object, XMLfoo returns the raw XML file.

How To Use This Module
======================
(See the individual classes, methods, and attributes for details.)

1. Apply for a Amazon Web Service API key from Amazon Web Service:
   https://aws-portal.amazon.com/gp/aws/developer/registration/index.html

2. Import it: ``import pyaws.ecs``

3. Setup the license key: ``ecs.setLicenseKey('YOUR-KEY-FROM-AWS')``
   or you could use the environment variable AMAZON_Meta.license_key

   Optional:
   a) setup other options, like AssociateTag, MerchantID, Validate
   b) export the http_proxy environment variable if you want to use proxy
   c) setup the locale if your locale is not ``us``

4. Send query to the AWS, and manupilate the returned python object.
"""

__author__ = "Kun Xi <kunxi@kunxi.org>"
__version__ = "0.3.0"
__license__ = "Python Software Foundation"
__docformat__ = 'restructuredtext'


import os, urllib, string
from xml.dom import minidom

import hmac
import hashlib
import base64
from time import strftime


class Meta:
    license_key = None
    secret_key = None
    locale = "us"
    version = "2007-04-04"
    options = {}

    locales = {
        None : "ecs.amazonaws.com",
        "us" : "ecs.amazonaws.com",
        "uk" : "ecs.amazonaws.co.uk",
        "de" : "ecs.amazonaws.co.de",
        "jp" : "ecs.amazonaws.co.jp",
        "fr" : "ecs.amazonaws.co.fr",
        "ca" : "ecs.amazonaws.co.ca",
    }

def __buildPlugins():
    """
    Build plugins used in unmarshal
    Return the dict like:
    Operation => { 'isByPassed'=>(...), 'isPivoted'=>(...),
        'isCollective'=>(...), 'isCollected'=>(...),
        isPaged=> { key1: (...), key2: (...), ... }
    """

    """
    ResponseGroups heirachy:
    Parent => children,

    The benefit of this layer is to reduce the redundency, when
    the child ResponseGroup change, it propaged to the parent
    automatically
    """
    rgh = {
        'CustomerFull': ('CustomerInfo', 'CustomerLists', 'CustomerReviews'),
        'Large': ('Accessories', 'BrowseNodes', 'ListmaniaLists', 'Medium', 'Offers', 'Reviews', 'Similarities', 'Tracks'),
        'ListFull': ('ListInfo', 'ListItems'),
        'ListInfo': ('ListMinimum', ),
        'ListItems': ('ListMinimum', ),
        'Medium': ('EditorialReview', 'Images', 'ItemAttributes', 'OfferSummary', 'Request', 'SalesRank', 'Small'),
        'OfferFull': ('Offers',),
        'Offers': ('OfferSummary',),
        'Variations': ('VariationMinimum', 'VariationSummary')
    }

    """
    ResponseGroup and corresponding plugins:
    ResponseGroup=>(isBypassed, isPivoted, isCollective, isCollected, isPaged)

    isPaged is defined as:
    { kwItems : (kwPage, kwTotalResults, pageSize) }

    - kwItems: string, the tagname of collection
    - kwPage: string, the tagname of page
    - kwTotalResults: string, the tagname of length
    - pageSize: constant integer, the size of each page

    CODE DEBT:

    - Do we need to remove the ResponseGroup in rgh.keys()? At least, Medium does not
    introduce any new attributes.

    """
    rgps = {
        'Accessories': ((), (), ('Accessories',), ('Accessory',), {}),
        'AlternateVersions': ((), (), (), (), {}),
        'BrowseNodeInfo': ((), (), ('Children', 'Ancestors'), ('BrowseNode',), {}),
        'BrowseNodes': ((), (), ('Children', 'Ancestors', 'BrowseNodes'), ('BrowseNode',), {}),
        'Cart': ((), (), (), (), {}),
        'CartNewReleases': ((), (), (), (), {}),
        'CartTopSellers': ((), (), (), (), {}),
        'CartSimilarities': ((), (), (), (), {}),
        'Collections': ((), (), (), (), {}),
        'CustomerFull': ((), (), (), (), {}),
        'CustomerInfo': ((), (), ('Customers',), ('Customer',), {}),
        'CustomerLists': ((), (), ('Customers',), ('Customer',), {}),
        'CustomerReviews': ((), (), ('Customers', 'CustomerReviews',),('Customer', 'Review'),{}),
        'EditorialReview': ((), (), ('EditorialReviews',), ('EditorialReview',), {}),
        'Help': ((), (), ('RequiredParameters', 'AvailableParameters',
            'DefaultResponseGroups', 'AvailableResponseGroups'),
             ('Parameter', 'ResponseGroup'), {}),
        'Images': ((), (), ('ImageSets',), ('ImageSet',), {}),
        'ItemAttributes': ((), ('ItemAttributes',), (), (), {}),
        'ItemIds': ((), (), (), (), {}),
        'ItemLookup.Small': ((), ('ItemAttributes',), (), ('Item',),
            {'Items': ('OfferPage', 'OfferPages', 10) }),
        'ItemSearch.Small': ((), ('ItemAttributes',), (), ('Item',),
            {'Items': ('ItemPage', 'TotalPages', 10) }),
        'Large': ((), (), (), (), {}),
        'ListFull': ((), (), (), ('ListItem', ), {}),
        'ListInfo': ((), (), (), (), {}),
        'ListItems': ((), (), ('Lists',), ('ListItem', 'List'), {'List': ('ProductPage',
            'TotalPages', 10)}),
        'ListmaniaLists': ((), (), ('ListmaniaLists', ), ('ListmaniaList',), {}),
        'ListMinimum': ((), (), (), (), {}),
        'Medium': ((), (), (), (), {}),
        'MerchantItemAttributes': ((), (), (), (), {}),
        'NewReleases': ((), (), ('NewReleases',), ('NewRelease',), {}),
        'OfferFull': ((), (), (), (), {}),
        'OfferListings': ((), (), (), (), {}),
        'Offers': ((), (), (), ('Offer',), {'Offers': ('OfferPage', 'TotalOfferPages', 10)}),
        'OfferSummary': ((), (), (), (), {}),
        'Request': (('Request',), (), (), (), {}),
        'Reviews': ((), (), ('CustomerReviews', ),('Review',), {}),
        'SalesRank': ((), (), (), (), {}),
        'SearchBins': ((), (), ('SearchBinSets',), ('SearchBinSet',), {}),
        'SimilarityLookup.Small': ((), ('ItemAttributes',), ('Items',), ('Item',), {}),
        'Seller': ((), (), (), (), {}),
        'SellerListing': ((), (), (), (), {}),
        'Similarities': ((), (), ('SimilarProducts',), ('SimilarProduct',), {}),
        'Small': ((), (), (), (), {}),
        'Subjects': ((), (), ('Subjects',), ('Subject',), {}),
        'TopSellers': ((), (), ('TopSellers',), ('TopSeller',), {}),
        'Tracks': ((), ('Tracks',), (), (), {}),
        'TransactionDetails': ((), (), ('Transactions', 'TransactionItems', 'Shipments'),
            ('Transaction', 'TransactionItem', 'Shipment'), {}),
        'Variations': ((), (), (), (), {}),
        'VariationMinimum': ((), (), ('Variations',), ('Variation',), {}),
        'VariationImages': ((), (), (), (), {}),
        'VariationSummary':((), (), (), (), {})
    }

    """
    Operation=>ResponseGroups
    """
    orgs = {
        'BrowseNodeLookup': ('Request', 'BrowseNodeInfo', 'NewReleases', 'TopSellers'),
        'CartAdd': ('Cart', 'Request', 'CartSimilarities', 'CartTopSellers', 'NewReleases'),
        'CartClear': ('Cart', 'Request'),
        'CartCreate': ('Cart', 'Request', 'CartSimilarities', 'CartTopSellers', 'CartNewReleases'),
        'CartGet': ('Cart', 'Request', 'CartSimilarities', 'CartTopSellers', 'CartNewReleases'),
        'CartModify': ('Cart', 'Request', 'CartSimilarities', 'CartTopSellers', 'CartNewReleases'),
        'CustomerContentLookup': ('Request', 'CustomerInfo', 'CustomerReviews', 'CustomerLists', 'CustomerFull'),
        'CustomerContentSearch': ('Request', 'CustomerInfo'),
        'Help': ('Request', 'Help'),
        'ItemLookup': ('Request', 'ItemLookup.Small', 'Accessories', 'BrowseNodes', 'EditorialReview', 'Images', 'ItemAttributes', 'ItemIds', 'Large', 'ListmaniaLists', 'Medium', 'MerchantItemAttributes', 'OfferFull', 'Offers', 'OfferSummary', 'Reviews', 'SalesRank', 'Similarities', 'Subjects', 'Tracks', 'VariationImages', 'VariationMinimum', 'Variations', 'VariationSummary'),
        'ItemSearch': ('Request', 'ItemSearch.Small', 'Accessories', 'BrowseNodes', 'EditorialReview', 'ItemAttributes', 'ItemIds', 'Large', 'ListmaniaLists', 'Medium', 'MerchantItemAttributes', 'OfferFull', 'Offers', 'OfferSummary', 'Reviews', 'SalesRank', 'SearchBins', 'Similarities', 'Subjects', 'Tracks', 'VariationMinimum', 'Variations', 'VariationSummary'),
        'ListLookup': ('Request', 'ListInfo', 'Accessories', 'BrowseNodes', 'EditorialReview', 'Images', 'ItemAttributes', 'ItemIds', 'Large', 'ListFull', 'ListItems', 'ListmaniaLists', 'Medium', 'Offers', 'OfferSummary', 'Reviews', 'SalesRank', 'Similarities', 'Subjects', 'Tracks', 'VariationMinimum', 'Variations', 'VariationSummary'),
        'ListSearch': ('Request', 'ListInfo', 'ListMinimum'),
        'SellerListingLookup': ('Request', 'SellerListing'),
        'SellerListingSearch': ('Request', 'SellerListing'),
        'SellerLookup': ('Request', 'Seller'),
        'SimilarityLookup': ('Request', 'SimilarityLookup.Small', 'Accessories', 'BrowseNodes', 'EditorialReview', 'Images', 'ItemAttributes', 'ItemIds', 'Large', 'ListmaniaLists', 'Medium', 'Offers', 'OfferSummary', 'Reviews', 'SalesRank', 'Similarities', 'Tracks', 'VariationMinimum', 'Variations', 'VariationSummary'),
        'TransactionLookup':('Request', 'TransactionDetails')
    }

    def collapse(responseGroups):
        l = []
        for x in responseGroups:
            l.append(x)
            if x in rgh.keys():
                l.extend( collapse(rgh[x]) )
        return l


    def mergePlugins(responseGroups, index):
        #return reduce(lambda x, y: x.update(set(rgps[y][index])), responseGroups, set())
        # this magic reduce does not work, using the primary implementation first.
        # CODEDEBT: magic number !
        if index == 4:
            s = dict()
        else:
            s = set()

        map(lambda x: s.update(rgps[x][index]), responseGroups)
        return s

    def unionPlugins(responseGroups):
        return dict( [ (key, mergePlugins(collapse(responseGroups), index)) for index, key in enumerate(['isBypassed', 'isPivoted', 'isCollective', 'isCollected', 'isPaged']) ])

    return dict( [ (k, unionPlugins(v)) for k, v in orgs.items() ] )


__plugins = __buildPlugins()

# Basic class for ECS
class Bag :
    """A generic container for the python objects"""
    def __repr__(self):
        return '<Bag instance: ' + self.__dict__.__repr__() + '>'


class ListIterator(list):
    pass


class PaginatedIterator(ListIterator):
    def __init__(self, XMLSearch, arguments, keywords, element, plugins):
        """
        Initialize a `PaginatedIterator` object.
        Parameters:

        - `XMLSearch`: a function, the query to get the DOM
        - `arguments`: a dictionary, `XMLSearch`'s arguments
        - `keywords`: a tuple, (kwItems, (kwPage, kwTotalPages, pageSize) )
        - `element`: a DOM element, the root of the collection
        - `plugins`: a dictionary, collection of plugged objects
        """
        kwItems, (kwPage, kwTotalPages, pageSize) = keywords

        self.search = XMLSearch
        self.arguments = arguments
        self.plugins = plugins
        self.keywords ={'Items':kwItems, 'Page':kwPage}
        self.total_page = int(element.getElementsByTagName(kwTotalPages).item(0).firstChild.data)
        self.page = 1
        self.cache = unmarshal(XMLSearch, arguments, element, plugins, ListIterator())

    def __iter__(self):
        while True:
            for x in self.cache:
                yield x
            self.page += 1
            if self.page > self.total_page:
                raise StopIteration
            self.arguments[self.keywords['Page']] = self.page
            dom = self.search(** self.arguments)
            self.cache = unmarshal(self.search, self.arguments, dom.getElementsByTagName(self.keywords['Items']).item(0), self.plugins, ListIterator())


def SimpleObject(XMLSearch, arguments, kwItem, plugins=None):
    """Return simple object from `unmarshal`"""
    dom = XMLSearch(** arguments)
    return unmarshal(XMLSearch, arguments, dom.getElementsByTagName(kwItem).item(0), plugins)

def Collection(XMLSearch, arguments, kwItems, plugins=None):
    """Return collection of objects from `unmarshal` using ListIterator interface."""
    dom = XMLSearch(** arguments)
    return unmarshal(XMLSearch, arguments, dom.getElementsByTagName(kwItems).item(0), plugins, ListIterator())

def Pagination(XMLSearch, arguments, keywords, plugins):
    return PaginatedIterator(XMLSearch, arguments, keywords,
        XMLSearch(** arguments).getElementsByTagName(keywords[0]).item(0),
        plugins)


# Exception classes
class AWSException(Exception) : pass
class NoLicenseKey(AWSException) : pass
class BadLocale(AWSException) : pass
class BadOption(AWSException): pass
# Runtime exception
class ExactParameterRequirement(AWSException): pass
class ExceededMaximumParameterValues(AWSException): pass
class InsufficientParameterValues(AWSException): pass
class InternalError(AWSException): pass
class InvalidEnumeratedParameter(AWSException): pass
class InvalidISO8601Time(AWSException): pass
class InvalidOperationForMarketplace(AWSException): pass
class InvalidOperationParameter(AWSException): pass
class InvalidParameterCombination(AWSException): pass
class InvalidParameterValue(AWSException): pass
class InvalidResponseGroup(AWSException): pass
class InvalidServiceParameter(AWSException): pass
class InvalidSubscriptionId(AWSException): pass
class InvalidXSLTAddress(AWSException): pass
class MaximumParameterRequirement(AWSException): pass
class MinimumParameterRequirement(AWSException): pass
class MissingOperationParameter(AWSException): pass
class MissingParameterCombination(AWSException): pass
class MissingParameters(AWSException): pass
class MissingParameterValueCombination(AWSException): pass
class MissingServiceParameter(AWSException): pass
class ParameterOutOfRange(AWSException): pass
class ParameterRepeatedInRequest(AWSException): pass
class RestrictedParameterValueCombination(AWSException): pass
class XSLTTransformationError(AWSException): pass

# make a valid RESTful AWS query, that is signed, from a dictionary
# http://docs.amazonwebservices.com/AWSECommerceService/latest/DG/index.html?RequestAuthenticationArticle.html
# code by Robert Wallis: SmilingRob@gmail.com, your hourly software contractor
def amazonWebServicesUrl(aws_access_key_id, secret, query_dictionary):
    query_dictionary["AWSAccessKeyId"] = aws_access_key_id
    query_dictionary["Timestamp"] = strftime("%Y-%m-%dT%H:%M:%SZ")
    query_pairs = []
    for (k,v) in query_dictionary.items():
	if v:
	    query_pairs.append(k+"="+urllib.quote(v))
#    query_pairs = map(
#       lambda (k,v):(k+"="+urllib.quote(v)),
#      query_dictionary.items()
# )
    # The Amazon specs require a sorted list of arguments
    query_pairs.sort()
    query_string = "&".join(query_pairs)
    hm = hmac.new(
        secret,
        "GET\nwebservices.amazon.com\n/onca/xml\n"+query_string,
        hashlib.sha256
    )
    signature = urllib.quote(base64.b64encode(hm.digest()))
    query_string = "https://webservices.amazon.com/onca/xml?%s&Signature=%s" % (query_string, signature)
    return query_string


def buildRequest(argv):
    """Build the REST request URL from argv."""
    url = "https://" + Meta.locales[getLocale()] + "/onca/xml?Service=AWSECommerceService&" + 'Version=%s&' % Meta.version
    argv['Service'] =  "AWSECommerceService"
    argv['Version'] =  Meta.version

    if not argv['AWSAccessKeyId']:
        argv['AWSAccessKeyId'] = getLicenseKey()
    argv.update(getOptions())
    # return url + '&'.join(['%s=%s' % (k,urllib.quote(str(v))) for (k,v) in argv.items() if v])
    return amazonWebServicesUrl(getLicenseKey(), getSecretKey(), argv)


def buildException(els):
    """Build the exception from the returned DOM node
    Note: only the first exception is raised."""
    error = els[0]
    class_name = error.childNodes[0].firstChild.data[4:]
    msg = error.childNodes[1].firstChild.data

    e = globals()[ class_name ](msg)
    return e


def query(url):
    """Send the query url and return the DOM
    Exception is raised if there are errors"""
    u = urllib.FancyURLopener()
    usock = u.open(url)
    dom = minidom.parse(usock)
    usock.close()

    errors = dom.getElementsByTagName('Error')
    if errors:
        e = buildException(errors)
        raise e
    return dom


def unmarshal(XMLSearch, arguments, element, plugins=None, rc=None):
    """Return the `Bag` / `ListIterator` object with attributes
    populated using DOM element.

    Parameters:

    - `XMLSearch`: callback function, used when construct PaginatedIterator
    - `arguments`: arguments of `XMLSearch`
    - `element`: DOM object, the DOM element interested in
    - `plugins`: a dictionary, collection of plugged objects to fine-tune
      the object attributes
    - `rc`: Bag object, parent object

    This core function is inspired by Mark Pilgrim (f8dy@diveintomark.org)
    with some enhancement. Each node.tagName is evalued by plugins' callback
    functions:

    - if tagname in plugins['isBypassed']
        this elment is ignored
    - if tagname in plugins['isPivoted']
        this children of this elment is moved to grandparents
        this object is ignored.
    - if tagname in plugins['isCollective']
        this elment is mapped to []
    - if tagname in plugins['isCollected']
        this children of elment is appended to grandparent
        this object is ignored.
    - if tagname in plugins['isPaged'].keys():
        this PaginatedIterator is constructed for the object

    CODE DEBT:

    - Use optimal search for optimization if necessary
    """

    if(rc == None):
        rc = Bag()

    childElements = [e for e in element.childNodes if isinstance(e, minidom.Element)]

    if childElements:
        for child in childElements:
            key = child.tagName
            if hasattr(rc, key):
                attr = getattr(rc, key)
                if type(attr) <> type([]):
                    setattr(rc, key, [attr])
                setattr(rc, key, getattr(rc, key) + [unmarshal(XMLSearch, arguments, child, plugins)])
            elif isinstance(child, minidom.Element):
                if child.tagName in plugins['isPivoted']:
                    unmarshal(XMLSearch, arguments, child, plugins, rc)
                    continue
                elif child.tagName in plugins['isBypassed']:
                    continue

                if child.tagName in plugins['isCollective']:
                    value = unmarshal(XMLSearch, arguments, child, plugins, ListIterator())
                elif child.tagName in plugins['isPaged'].keys():
                    value = PaginatedIterator(XMLSearch, arguments, (child.tagName, plugins['isPaged'][child.tagName]), child, plugins)
                else :
                    value = unmarshal(XMLSearch, arguments, child, plugins)

                if child.tagName in plugins['isCollected']:
                    rc.append(value)
                else :
                    setattr(rc, key, value)
    else:
        rc = "".join([e.data for e in element.childNodes if isinstance(e, minidom.Text)])
    return rc



# User interfaces

def ItemLookup(ItemId, IdType=None, SearchIndex=None, MerchantId=None, Condition=None, DeliveryMethod=None, ISPUPostalCode=None, OfferPage=None, ReviewPage=None, ReviewSort=None, VariationPage=None, ResponseGroup=None, AWSAccessKeyId=None):
    '''ItemLookup in ECS'''
    return SimpleObject(XMLItemLookup, vars(), 'Item', __plugins['ItemLookup'])


def XMLItemLookup(ItemId, IdType=None, SearchIndex=None, MerchantId=None, Condition=None, DeliveryMethod=None, ISPUPostalCode=None, OfferPage=None, ReviewPage=None, ReviewSort=None, VariationPage=None, ResponseGroup=None, AWSAccessKeyId=None):
    '''DOM representation of ItemLookup in ECS'''

    Operation = "ItemLookup"
    return query(buildRequest(vars()))


def ItemSearch(Keywords, SearchIndex="Blended", Availability=None, Title=None, Power=None, BrowseNode=None, Artist=None, Author=None, Actor=None, Director=None, AudienceRating=None, Manufacturer=None, MusicLabel=None, Composer=None, Publisher=None, Brand=None, Conductor=None, Orchestra=None, TextStream=None, ItemPage=None, OfferPage=None, ReviewPage=None, Sort=None, City=None, Cuisine=None, Neighborhood=None, MinimumPrice=None, MaximumPrice=None, MerchantId=None, Condition=None, DeliveryMethod=None, ResponseGroup=None, AWSAccessKeyId=None):
    '''ItemSearch in ECS'''

    return Pagination(XMLItemSearch, vars(),
        ('Items', __plugins['ItemSearch']['isPaged']['Items']), __plugins['ItemSearch'])


def XMLItemSearch(Keywords, SearchIndex="Blended", Availability=None, Title=None, Power=None, BrowseNode=None, Artist=None, Author=None, Actor=None, Director=None, AudienceRating=None, Manufacturer=None, MusicLabel=None, Composer=None, Publisher=None, Brand=None, Conductor=None, Orchestra=None, TextStream=None, ItemPage=None, OfferPage=None, ReviewPage=None, Sort=None, City=None, Cuisine=None, Neighborhood=None, MinimumPrice=None, MaximumPrice=None, MerchantId=None, Condition=None, DeliveryMethod=None, ResponseGroup=None, AWSAccessKeyId=None):
    '''DOM representation of ItemSearch in ECS'''

    Operation = "ItemSearch"
    return query(buildRequest(vars()))


def SimilarityLookup(ItemId, SimilarityType=None, MerchantId=None, Condition=None, DeliveryMethod=None, ResponseGroup=None, OfferPage=None, AWSAccessKeyId=None):
    '''SimilarityLookup in ECS'''

    return Collection(XMLSimilarityLookup, vars(), 'Items', __plugins['SimilarityLookup'])


def XMLSimilarityLookup(ItemId, SimilarityType=None, MerchantId=None, Condition=None, DeliveryMethod=None, ResponseGroup=None, OfferPage=None, AWSAccessKeyId=None):
    '''DOM representation of SimilarityLookup in ECS'''

    Operation = "SimilarityLookup"
    return query(buildRequest(vars()))


# List Operations

def ListLookup(ListType, ListId, ProductPage=None, ProductGroup=None, Sort=None, MerchantId=None, Condition=None, DeliveryMethod=None, ResponseGroup=None, AWSAccessKeyId=None):
    '''ListLookup in ECS'''
    return Pagination(XMLListLookup, vars(),
        ('List', __plugins['ListLookup']['isPaged']['List']),
        __plugins['ListLookup'])


def XMLListLookup(ListType, ListId, ProductPage=None, ProductGroup=None, Sort=None, MerchantId=None, Condition=None, DeliveryMethod=None, ResponseGroup=None, AWSAccessKeyId=None):
    '''DOM representation of ListLookup in ECS'''

    Operation = "ListLookup"
    return query(buildRequest(vars()))


def ListSearch(ListType, Name=None, FirstName=None, LastName=None, Email=None, City=None, State=None, ListPage=None, ResponseGroup=None, AWSAccessKeyId=None):
    '''ListSearch in ECS'''

    argv = vars()
    plugins = {
        'isBypassed': (),
        'isPivoted': ('ItemAttributes',),
        'isCollective': ('Lists',),
        'isCollected': ('List',),
        'isPaged' : { 'Lists': ('ListPage', 'TotalResults', 10) }
    }
    return Pagination(XMLListSearch, argv,
        ('Lists', plugins['isPaged']['Lists']), plugins)


def XMLListSearch(ListType, Name=None, FirstName=None, LastName=None, Email=None, City=None, State=None, ListPage=None, ResponseGroup=None, AWSAccessKeyId=None):
    '''DOM representation of ListSearch in ECS'''

    Operation = "ListSearch"
    return query(buildRequest(vars()))


#Remote Shopping Cart Operations
def CartCreate(Items, Quantities, ResponseGroup=None, AWSAccessKeyId=None):
    '''CartCreate in ECS'''

    return __cartOperation(XMLCartCreate, vars())


def XMLCartCreate(Items, Quantities, ResponseGroup=None, AWSAccessKeyId=None):
    '''DOM representation of CartCreate in ECS'''

    Operation = "CartCreate"
    argv = vars()
    for x in ('Items', 'Quantities'):
        del argv[x]

    __fromListToItems(argv, Items, 'ASIN', Quantities)
    return query(buildRequest(argv))


def CartAdd(Cart, Items, Quantities, ResponseGroup=None, AWSAccessKeyId=None):
    '''CartAdd in ECS'''

    return __cartOperation(XMLCartAdd, vars())


def XMLCartAdd(Cart, Items, Quantities, ResponseGroup=None, AWSAccessKeyId=None):
    '''DOM representation of CartAdd in ECS'''

    Operation = "CartAdd"
    CartId = Cart.CartId
    HMAC = Cart.HMAC
    argv = vars()
    for x in ('Items', 'Cart', 'Quantities'):
        del argv[x]

    __fromListToItems(argv, Items, 'ASIN', Quantities)
    return query(buildRequest(argv))


def CartGet(Cart, ResponseGroup=None, AWSAccessKeyId=None):
    '''CartGet in ECS'''
    return __cartOperation(XMLCartGet, vars())


def XMLCartGet(Cart, ResponseGroup=None, AWSAccessKeyId=None):
    '''DOM representation of CartGet in ECS'''

    Operation = "CartGet"
    CartId = Cart.CartId
    HMAC = Cart.HMAC
    argv = vars()
    del argv['Cart']
    return query(buildRequest(argv))


def CartModify(Cart, Items, Actions, ResponseGroup=None, AWSAccessKeyId=None):
    '''CartModify in ECS'''

    return __cartOperation(XMLCartModify, vars())


def XMLCartModify(Cart, Items, Actions, ResponseGroup=None, AWSAccessKeyId=None):
    '''DOM representation of CartModify in ECS'''
    Operation = "CartModify"
    CartId = Cart.CartId
    HMAC = Cart.HMAC
    argv = vars()
    for x in ('Cart', 'Items', 'Actions'):
        del argv[x]

    __fromListToItems(argv, Items, 'CartItemId', Actions)
    return query(buildRequest(argv))


def CartClear(Cart, ResponseGroup=None, AWSAccessKeyId=None):
    '''CartClear in ECS'''
    return __cartOperation(XMLCartClear, vars())


def XMLCartClear(Cart, ResponseGroup=None, AWSAccessKeyId=None):
    '''DOM representation of CartClear in ECS'''

    Operation = "CartClear"
    CartId = Cart.CartId
    HMAC = Cart.HMAC
    argv = vars()
    del argv['Cart']

    return query(buildRequest(argv))


def __fromListToItems(argv, items, id, actions):
    '''Convert list to AWS REST arguments'''

    for i in range(len(items)):
        argv["Item.%d.%s" % (i+1, id)] = getattr(items[i], id);
        action = actions[i]
        if isinstance(action, int):
            argv["Item.%d.Quantity" % (i+1)] = action
        else:
            argv["Item.%d.Action" % (i+1)] = action


def __cartOperation(XMLSearch, arguments):
    '''Generic cart operation'''

    plugins = {
        'isBypassed': ('Request',),
        'isPivoted': (),
        'isCollective': ('CartItems', 'SavedForLaterItems'),
        'isCollected': ('CartItem', 'SavedForLaterItem'),
        'isPaged': {}
    }
    return SimpleObject(XMLSearch, arguments, 'Cart', plugins)


# Seller Operation
def SellerLookup(Sellers, FeedbackPage=None, ResponseGroup=None, AWSAccessKeyId=None):
    '''SellerLookup in AWS'''

    argv = vars()
    plugins = {
        'isBypassed': ('Request',),
        'isPivoted': (),
        'isCollective': ('Sellers',),
        'isCollected': ('Seller',),
        'isPaged': {}
    }
    return Collection(XMLSellerLookup, argv, 'Sellers', plugins)


def XMLSellerLookup(Sellers, FeedbackPage=None, ResponseGroup=None, AWSAccessKeyId=None):
    '''DOM representation of SellerLookup in AWS'''

    Operation = "SellerLookup"
    SellerId = ",".join(Sellers)
    argv = vars()
    del argv['Sellers']
    return query(buildRequest(argv))


def SellerListingLookup(SellerId, Id, IdType="Listing", ResponseGroup=None, AWSAccessKeyId=None):
    '''SellerListingLookup in AWS

    Notice: although the repsonse includes TotalPages, TotalResults,
    there is no ListingPage in the request, so we have to use Collection
    instead of PaginatedIterator. Hope Amazaon would fix this inconsistance'''

    argv = vars()
    plugins = {
        'isBypassed': ('Request',),
        'isPivoted': (),
        'isCollective': ('SellerListings',),
        'isCollected': ('SellerListing',),
        'isPaged': {}
    }
    return Collection(XMLSellerListingLookup, argv, "SellerListings", plugins)


def XMLSellerListingLookup(SellerId, Id, IdType="Listing", ResponseGroup=None, AWSAccessKeyId=None):
    '''DOM representation of SellerListingLookup in AWS'''

    Operation = "SellerListingLookup"
    return query(buildRequest(vars()))


def SellerListingSearch(SellerId, Title=None, Sort=None, ListingPage=None, OfferStatus=None, ResponseGroup=None, AWSAccessKeyId=None):
    '''SellerListingSearch in AWS'''

    argv = vars()
    plugins = {
        'isBypassed': ('Request',),
        'isPivoted': (),
        'isCollective': ('SellerListings',),
        'isCollected': ('SellerListing',),
        'isPaged' : { 'SellerListings': ('ListingPage', 'TotalResults', 10) }
    }
    return Pagination(XMLSellerListingSearch, argv,
        ('SellerListings', plugins['isPaged']['SellerListings']), plugins)


def XMLSellerListingSearch(SellerId, Title=None, Sort=None, ListingPage=None, OfferStatus=None, ResponseGroup=None, AWSAccessKeyId=None):
    '''DOM representation of SellerListingSearch in AWS'''

    Operation = "SellerListingSearch"
    return query(buildRequest(vars()))


def CustomerContentSearch(Name=None, Email=None, CustomerPage=1, ResponseGroup=None, AWSAccessKeyId=None):
    '''CustomerContentSearch in AWS'''

    return Collection(XMLCustomerContentSearch, vars(), 'Customers', __plugins['CustomerContentSearch'])


def XMLCustomerContentSearch(Name=None, Email=None, CustomerPage=1, ResponseGroup=None, AWSAccessKeyId=None):
    '''DOM representation of CustomerContentSearch in AWS'''

    Operation = "CustomerContentSearch"
    argv = vars()
    for x in ('Name', 'Email'):
        if not argv[x]:
            del argv[x]
    return query(buildRequest(argv))


def CustomerContentLookup(CustomerId, ReviewPage=1, ResponseGroup=None, AWSAccessKeyId=None):
    '''CustomerContentLookup in AWS'''

    argv = vars()
    plugins = {
        'isBypassed': ('Request',),
        'isPivoted': (),
        'isCollective': ('Customers',),
        'isCollected': ('Customer',),

    }
    return Collection(XMLCustomerContentLookup, argv, 'Customers', __plugins['CustomerContentLookup'])


def XMLCustomerContentLookup(CustomerId, ReviewPage=1, ResponseGroup=None, AWSAccessKeyId=None):
    '''DOM representation of CustomerContentLookup in AWS'''

    Operation = "CustomerContentLookup"
    return query(buildRequest(vars()))


# BrowseNode
def BrowseNodeLookup(BrowseNodeId, ResponseGroup=None, AWSAccessKeyId=None):
    """
    BrowseNodeLookup in AWS
    """
    return Collection(XMLBrowseNodeLookup, vars(), 'BrowseNodes', __plugins['BrowseNodeLookup'])


def XMLBrowseNodeLookup(BrowseNodeId, ResponseGroup=None, AWSAccessKeyId=None):
    '''DOM representation of BrowseNodeLookup in AWS'''

    Operation = "BrowseNodeLookup"
    return query(buildRequest(vars()))


# Help
def Help(HelpType, About, ResponseGroup=None, AWSAccessKeyId=None):
    '''Help in AWS'''
    return SimpleObject(XMLHelp, vars(), 'Information', __plugins['Help'])


def XMLHelp(HelpType, About, ResponseGroup=None, AWSAccessKeyId=None):
    '''DOM representation of Help in AWS'''

    Operation = "Help"
    return query(buildRequest(vars()))


# Transaction
def TransactionLookup(TransactionId, ResponseGroup=None, AWSAccessKeyId=None):
    '''TransactionLookup in AWS'''
    return Collection(XMLTransactionLookup, vars(), 'Transactions', __plugins['TransactionLookup'])


def XMLTransactionLookup(TransactionId, ResponseGroup=None, AWSAccessKeyId=None):
    '''DOM representation of TransactionLookup in AWS'''

    Operation = "TransactionLookup"
    return query(buildRequest(vars()))


# helper functions
def setLocale(locale):
    """Set the locale
    if unsupported locale is set, BadLocale is raised."""
    if Meta.locales.has_key(locale):
        Meta.locale = locale
    else :
        raise BadLocale, ("Unsupported locale. Locale must be one of: %s" %
            ', '.join([x for x in Meta.locales.keys() if x]))

def getLocale():
    """Get the locale"""
    return Meta.locale



def setSecretKey(secret_key):
    Meta.secret_key = secret_key

def getSecretKey():
    return Meta.secret_key

def setLicenseKey(license_key=None):
    """Set AWS license key.
    If license_key is not specified, the license key is set using the
    environment variable: AMAZON_Meta.license_key; if no license key is
    set, NoLicenseKey exception is raised."""
    if license_key:
        Meta.license_key = license_key
    else :
        Meta.license_key = os.environ.get('AWS_LICENSE_KEY', None)


def getLicenseKey():
    """Get AWS license key.
    If no license key is specified,  NoLicenseKey is raised."""
    if Meta.license_key:
        return Meta.license_key
    else :
        raise NoLicenseKey, ("Please get the license key from  http://www.amazon.com/webservices")


def getVersion():
    """Get the version of ECS specification"""
    return Meta.version


def setOptions(options):
    """
    Set the general optional parameter, available options are:
    - AssociateTag
    - MerchantID
    - Version
    - Validate
    """

    if set(options.keys()).issubset( set(['AssociateTag', 'MerchantID', 'Validate']) ):
        Meta.options.update(options)
    else:
        raise BadOption, ('Unsupported option')


def getOptions():
    """Get options"""
    return Meta.options
