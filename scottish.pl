#/usr/bin/perl -w

$/ = "";
my @data = <DATA>;

# print @data;
my $data = join ",", @data;

#print $data;

my @in = ();

while ($data =~ /([A-Za-z\'\-]+)/gm) {
	#print "Word is $1, ends at position ", pos $data, "\n";
	my $word = $1;
	if ($word =~ /^Mac/) {
		push @in, $word;
		# print "$word\n";
	}
}


undef %saw;
@saw{@in} = ();
@out = sort keys %saw;  # remove sort if undesired

print "\"";
print join "\", \"", @out;
print "\"\n";


exit;
__DATA__
Names and Spellings of Names connected with Clans & Tartans


Visit http://www.houseoftartan.co.uk to find your tartan


Visit http://www.electricscotland.com/webclans to read about your clan history

Scottish Clans DNA Project
http://www.electricscotland.com/webclans/dna_projectndx.htm

Please Note: This page is the copyright of House of Tartan and Electric Scotland but you may print out this page providing the whole document (including header) is kept together. Equally you may use this on your own web site providing the House of Tartan and Electric Scotland logos and web urls are kept with the document. At the end of the day a lot of work went into creating this and we'd simply like to retain the credit for the work and any resultant publicity. We will also update this page from time to time as we obtain further information.  Should you know of a name we don't include in here please send an email to Alastair McIntyre with the name and clan connection and we'll add it to the page on our next update.

On a final note you should be aware that the Chief of the Clan is the final arbiter of what names are associated with his/her clan and you would be advised to check with the clan itself as the final source of information. You can read about Clans, Families and Septs, as they are viewed by the Lyon Court for further clarification. (http://www.electricscotland.com/webclans/clans_families_septs.htm)

Last updated: 13th June 2008

A
Abercrombie
Clan History: http://electricscotland.com/webclans/atoc/abercrom.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=2
Associated Names and Septs (with spelling variations):
Abarcrumbie Abarcrumby Abercrombie Abercromby Abercrombye Abercrummye Abircromby Abircromme Abircromy Abircromye Abircrumby Abircrumbye Abircrummy Abircrumy


Agnew
Clan History: http://electricscotland.com/webclans/atoc/agnew.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=3
Associated Names and Septs (with spelling variations):
Aggnew Agneaux Agneli Agnew Agnewe Agnex Aignell Angnew Aygnel Slavan

Aitken
Clan History: http://electricscotland.com/webclans/atoc/aitcheson.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=656
Associated Names and Septs (with spelling variations):
Achenson Acheson Achesone Achesoun Achesoune Achesune Achieson Achiesoun Achinsoun Achisone Achisoune Aichensoun Aicheson Aichesone Aitcheson Aitchesoun Aitchesoune Aitchison Aitchysoune Aithchinson Aschesone Atchesone Atchison Atchisone Aticione Atyesoun Atzensone Atzeson Echesone Eticione Etzesone

Akins
Clan History: http://electricscotland.com/webclans/atoc/akins.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1066
Associated Names and Septs (with spelling variations):
Achain Achin Acken Ackin Ackine Ackins Ackyn Ackyne Agan Aickin Aickine Aicking Aikan Aikein Aiken Aikens Aikeyne Aikin Aikine Aiking Aikins Aikne Aikun Aikyne Aitkens Akein Aken Akene Akens Akin Akine Aking Akins Akyne Akyngs Akyns Aukin Ayken Aykkyne Eaken Eakens Eakin Eakings Eakins Eanes Ecken Eckin Eckins Eken Ekens Ekin Ekins Ekons

Allison
Clan History: http://electricscotland.com/webclans/atoc/allison.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=4
Associated Names and Septs (with spelling variations):
Aillieson Alanesone Alason Aleinson Alensone Aleson Alesone Alesoun Aleynson Aleynsson Aliesone Aliesoune Alinson Alison Alisone Alissone Alizon Allanson Allansone Allansoune Allason Allasone Allasoun Allasoune Allasson Alleson Allesoun Allesoune Allinson Allison Allisone Allsoun Alynson Alysone

Anderson
Clan History: http://electricscotland.com/webclans/atoc/anderson.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=5
Associated Names and Septs (with spelling variations):
Aindrea Anderson Anderson Anderson Andersone Andersonne Andersoun Andersoune Anderston Andesoune Andie Andirsoone Andirsoune Andirston Andirstoun Andison Andree Andreson Andresoun Andrew Andrewes Andrews Andrewson Andro Androe Androson Androsone Androsoun Androsoune Androw Andrson Andson Andy Andyrson Anndra Enderson Endherson Endirsone MacAindreis MacAndrew MacAndrie MacAndro MacAndy MacKandrew Makandro

Arbuthnott
Clan History: http://electricscotland.com/webclans/atoc/arbuthno/index.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=10
Associated Names and Septs (with spelling variations):
Aberbothenoth Aberbuthenoth Aberbuthno Aberbuthnocht Abirbuthenott Arbuthnat Arbuthnet Arbuthneth Arbuthnot Arbuthnoth Arbuthnott

Armstrong
Clan History: http://electricscotland.com/webclans/atoc/armstron.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=11
Associated Names and Septs (with spelling variations):
Armestrang Armstrang Armstrong Armystrang Crosar Crosier Crozer Fortenbras Harmestrang

B
Baillie
Clan History: http://electricscotland.com/webclans/atoc/baillie.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=16
Associated Names and Septs (with spelling variations):
Baile Bailey Bailie Bailive Bailley Baillie Bailly Baillye Baillyie Baillze Bailue Baily Bailyne Bailyow Bailze Bailzea Bailzie Baleus Ballie Ballye Baly Balye Balze Balzie Bayley Baylie Bayllie Baylly Baylzee Baylzie Beale Polkemet


Baird
Clan History: http://electricscotland.com/webclans/atoc/baird.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=17
Associated Names and Septs (with spelling variations):
Baard Baird Bard Barde Beard Beird MacBard

Balfour
Clan History: http://electricscotland.com/webclans/atoc/balfour.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=20
Associated Names and Septs (with spelling variations):
Balfer Balfewer Balflower Balfoir Balfoor Balfor Balfouir Balfour Balfowir Balfowr Balfowyr Baufour Baufoure Baulfour Bawfowre Bawlfour Bawlfowr

Barclay
Clan History: http://electricscotland.com/webclans/atoc/barclay.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=24
Associated Names and Septs (with spelling variations):
Barckley Barckly Barclay Barclay Barclay Barclaye Barclet Barclye Barcula Barculay Barkla Barklaw Barklay Barkley Berclay Bercley Bercula Berkele Berkeley Berklaw Towie Towy

Baxter
Clan History: http://electricscotland.com/webclans/atoc/baxter.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=26
Associated Names and Septs (with spelling variations):
Bacster Baker Bakster Baxstair Baxstar Baxstare Baxster Baxtar Baxter MacBaxtar MacBaxter MacVaxter Makbaxstar

Bell
Clan History: http://electricscotland.com/webclans/atoc/bell.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=28
Associated Names and Septs (with spelling variations):
Baeill Bail Baill Bails Bale Bales Ball Bayle Bayles Beal Beale Beall Bealles Bealls Beals Beel Beele Beeles Beels Behel Beil Beils Bel Bele Bell Belle Bellis Biehl Biel Biels Bile Biles Bill MacMoil

Bethune
Clan History: http://electricscotland.com/webclans/atoc/bethune.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1371
Associated Names and Septs (with spelling variations):
Bethune

Birral
Clan History: http://electricscotland.com/webclans/atoc/birrell.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=29
Associated Names and Septs (with spelling variations):
Birell Birral Birrall Birrel Birrell Burell Burelle Burral Burrale Burrall Burrel Burrell

Birse
Clan History: http://electricscotland.com/webclans/atoc/birse.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=30
Associated Names and Septs (with spelling variations):
Birse Birss Brass Buyers Byers Byres Byris Byrs Byrss

Bisset
Clan History: http://electricscotland.com/webclans/atoc/bisset.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=32
Associated Names and Septs (with spelling variations):
Besat Besate Bessat Biset Biseth Bissaite Bissart Bissat Bissate Bissatt Bisset Bisseth Bissett Bissott Bizet Buset Byset Byseth Byssate Byssot

Blackstock
Clan History: http://electricscotland.com/webclans/atoc/blackstock.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1272
Associated Names and Septs (with spelling variations):
Blackstock

Blair
Clan History: http://electricscotland.com/webclans/atoc/blair.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=34
Associated Names and Septs (with spelling variations):
Blair Blar Blare Blayr Blayre MacBlair

Borthwick
Clan History: http://electricscotland.com/webclans/atoc/borthwic.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=37
Associated Names and Septs (with spelling variations):
Barthwick Boirthuik Boirthvik Bortheik Borthek Borthock Borthuyke Borthweke Borthwick Borthwick Borthwik Borthwyke

Boswell
Clan History: http://electricscotland.com/webclans/atoc/boswell.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1123
Associated Names and Septs (with spelling variations):
Burberry

Bowie
Clan History: http://electricscotland.com/webclans/atoc/bowie.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=38
Associated Names and Septs (with spelling variations):
Bouie Bouwie Boway Bowey Bowie Bowy Bowye Boye Buie Buy MacIlbowie MacIlbuie

Boyd
Clan History: http://electricscotland.com/webclans/atoc/boyd.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=39
Associated Names and Septs (with spelling variations):
Bhoid Bod Bodha Boed Boht Boid Boyd Boyde Boyt

Brodie
Clan History: http://electricscotland.com/webclans/atoc/brodie.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=41
Associated Names and Septs (with spelling variations):
Brady Breaddie Breadie Briddie Bridie Bridy Bridye Broadie Broddie Broddy Brodie Brodye Brothie Bryde Brydie

Brown
Clan History: http://electricscotland.com/webclans/atoc/brown.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=42
Associated Names and Septs (with spelling variations):
Braun Bron Brouin Broun Broune Brown Browne Browyn Brun Brune Brwne George Brown

Bruce
Clan History: http://electricscotland.com/webclans/atoc/bruce.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=43
Associated Names and Septs (with spelling variations):
Airth Broce Brois Broise Broiss Brose Brouss Bruc Bruce Bruce Brues Bruice Bruis Brus Bruse Bruss Bruwes Bruys Bruze Carruthers Crosbie

Buchan
Clan History: http://electricscotland.com/webclans/atoc/buchan.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=45
Associated Names and Septs (with spelling variations):
Bochane Boghan Buccan Bucchaine Bucchan Buchan Buchane Bughan Buquhan

Buchanan
Clan History: http://electricscotland.com/webclans/atoc/buchana.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=46
Associated Names and Septs (with spelling variations):
Aslan Auslan Bochnannane Boqhannan Boquhennane Boquhennnan Buchanan Buchquannan Buchquhannan Buchquhannane Bucqhannane Bucquannane Buhannane Buquhannan Buquhannane Calman Clay Coleman Colman Conlay Conley Cormac Cormack Cormag Cormick Cosland Cousland Cowsland Dewar Deware Dewere Donleavy Donlevy Dove Dow Dowe Dunleavy Dunslef Gebbieson Geib Gib Gibb Gibbeson Gibbie Gibbieson Gibbinson Gibbisone Gibbon Gibbons Gibbs Gibson Gibsone Gibsoun Gibsoune Gilbert Gilbertson Gilbertsone Gipson Gipsone Gipsoun Gracey Gracie Gracy Graisich Grasich Grass Grasse Grasseich Grassiche Grassichsone Grassick Grassie Grasycht Graysich Greasaighe Greasich Grecie Greishich Greoschich Greoshich Greshach Gresich Gressiche Greusach Greusaich Grevsach Griasaich Griesck Gybbesone Gybson Gybsone Gybsoun Gypsone Harper Harperson Harpeur Harpur Jore Lanie Lanye Lenay Lenna Lennie Lenny Leny MacAbin MacAbsolon MacAldonich MacAlman MacAlmant MacAlmont MacAmhaoir MacAnally MacAndeoir MacAnnally MacArmick MacAslan MacAsland MacAslen MacAslin MacAuselan MacAuslan MacAusland MacAuslane MacAuslin MacCallman MacCalmain MacCalman MacCalmin MacCalmon MacCalmont MacCamant MacCannally MacCarmick MacCarmike MacCaslan MacCasland MacCaslane MacCaslen MacCaslin MacCasline MacCausland MacChananaich MacChormaig MacChritter MacChruitar MacChruiter MacChruter MacChruytor MacChrytor MacChurteer MacClae MacClay MacCleay MacClew MacColeman MacCollea MacColmain MacColman MacComok MacConlea MacCormack MacCormaic MacCormaig MacCormick MacCormock MacCormok MacCornack MacCornick MacCornock MacCornok MacCowatt MacCowbyn MacCuabain MacCubben MacCubbin MacCubbine MacCubbing MacCubbon MacCubein MacCubeine MacCuben MacCubene MacCubine MacCubyn MacCubyne MacCurchie MacDimslea MacDonleavy MacDonnslae MacGibbon MacGibbone MacGibboney MacGibon MacGibonesoun MacGiboun MacGibson MacGilbert MacGormick MacGormock MacGrasaych MacGrassych MacGrassycht MacGrasycht MacGrayych MacGreische MacGreish MacGresche MacGresich MacGressich MacGressiche MacGreusach MacGreusaich MacGreusich MacGubb MacGubbin MacGybbon MacHouat MacHrurter MacHruter MacHuat MacIldonich MacInair MacInally MacInayr MacInchruter MacIndeoir MacIndeor MacIndoe MacIndoer MacInnuer MacInnuier MacInnyeir MacInuair MacInuar MacInuire MacInuyer MacJore MacKeandla MacKermick MacKernock MacKibbin MacKibbon MacKindew MacKindlay MacKinla MacKinlay MacKinley MacKmaster MacKnaer MacKnair MacKnaire MacKornock MacKornok MacKwatt MacKynnair MacKynnayr MacLae MacLay MacLea MacLeay MacLey MacMagister MacMaster MacMaurice MacMhurchaidh MacMorice MacMories MacMoris MacMoroquhy MacMurachy MacMurchaidh MacMurchie MacMurchou MacMurchy MacMurd MacMurdo MacMurdoch MacMurdy MacMuredig MacMurphy MacMurquhe MacMurquhie MacMurtchie MacNair MacNally MacNar MacNare MacNayair MacNayer MacNayr MacNayre MacNear MacNeer MacNeir MacNeur MacNewer MacNoyar MacNoyare MacNoyiar MacNuer MacNuir MacNuire MacNure MacNuyer MacNvyr MacObyn MacOldonich MacOnlay MacOrmack MacOuat MacOwat MacQharter MacQherter MacQuaben MacQuarter MacQuat MacQuattie MacQuatty MacQueeban MacQuhartoune MacQuhat MacQuhatti MacQuhattie MacQuhirtir MacQuhirtour MacQuhirtoure MacQuhorter MacQuhriter MacQuibben MacQuibbon MacQuiben MacQuirter MacRob MacRobb MacRobe MacRuter MacUbein MacUbin MacUbine MacUrchie MacUrchy MacVannan MacVat MacVorchie MacVurchie MacWat MacWatt MacWatte MacWattie MacWatty MacWete MacWhirter MacWhirtour MacWhorter MacWhrurter MacWhyrter MacWirter MacWorthie MacWurchie Maistersone Maistertoun Maistertoune Maistertown Makarmik Makaslane Makcormok Makcubeyn Makcubyn Makcubyng Makgeboun Makgibboun Makley Makmoris Makmuldonych Makmurche Makmurquhy Maknair Maknare Maknayr Maknewar Maknoyar Makrutour Makrutur Makwat Makwatty Makwete Makynnair Masterson Masterton Mastertone Maurice Meldonich Mewhirter Mhurchaidh Mildonich Morice Morrice Morris Muldonich Muldonycht Murchad Murchadh Murchaidh Murcheson Murchesoun Murchie Murchieson Murchison Murchosone Murchosoun Murchy Murquhason Murquhasson Murquhessoun Murquhosoun Murtchie Reisk Risk Risken Rusken Ruskin Spetal Spetall Spetalle Spettale Spettall Spital Spitale Spitel Spittal Spittale Spittel Spittele Spittell Spytale Vair Vatsone Vatsoun Vatt Vcmurrochie Veir Vere Veyre Wair Ware Wason Wasson Wat Wateson Watson Watsone Watsoun Watsoune Watt Wattie Watts Wattsone Watty Wayre Wear Weare Weer Weir Weire Were Werr Weyir Weyr Whier Wier Wir Wire Yell Yoile Yool Yoole Youle Youll Yuel Yuill Yuille Yule Yull Yulle Zuill

Buie
Clan History: http://electricscotland.com/webclans/atoc/buie.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=753
Associated Names and Septs (with spelling variations):
Buie

Burnett
Clan History: http://electricscotland.com/webclans/atoc/burnett.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=55
Associated Names and Septs (with spelling variations):
Blackhall Burnaitt Burnat Burnate Burnet Burnett

Burns
Clan History: http://electricscotland.com/webclans/atoc/burns.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=57
Associated Names and Septs (with spelling variations):
Bernes Bernis Bernys Burnace Burnasse Burnes Burness Burnice Burnis Burns Burns

C
Cameron
Clan History: http://electricscotland.com/webclans/atoc/cameron.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=58
Associated Names and Septs (with spelling variations):
Cale Cambernon Cambrin Cambrone Cameron Cameronne Camirun Cammeron Camron Camrone Camroun Camrowne Camrun Canedie Challmers Chalmair Chalmbers Chalmer Chalmers Chalmour Chalmyr Chamber Chambers Chamer Chamyr Chaumer Claerk Clark Clarke Clarkson Clarksone Clearkson Cleary Clerach Clerc Clerck Clercsone Cleric Clerie Clerk Clerke Clerkson Clerksone Clerksoun Clerksson Douie Dowie Dowy Fail Fall Gelruth Gildawie Gildowie Gilduff Gilledow Gilleduff Gillegowie Gilleroth Gillreith Gilreith Gilrod Gilrooff Gilrooth Gilroth Gilrouth Gilrowth Gilrucht Gilruff Gilruth Gylleroch Gylruth Huie Kanide Kanydi Kenadie Kenede Kenedy Keneidy Kenide Kennadee Kennatie Kennaty Kennedi Kennedy Kennedye Kennetie Kennety Kennide Kennyde Kennydy Kenyde Kinydy Kyneidy Kynidy Leary MacAldowie MacAldowrie MacAldowy MacAlduie MacAleerie MacAloney MacAlonie MacChlerich MacChlery MacClearey MacCleary MacClerich MacCleriche MacClerie MacClery MacClirie MacClurich MacCualraig MacCuaraig MacEantailyeour MacElduff MacEleary MacFaell MacFail MacFal MacFale MacFall MacFaul MacFauld MacFaull MacFayle MacFoill MacFyall MacGildhui MacGilduff MacGildui MacGilevie MacGilewe MacGilladubh MacGilldowie MacGilledow MacGilleduf MacGilleduibh MacGillegowie MacGillemartin MacGillemertin MacGillery MacGillewe MacGillewey MacGillewie MacGillewy MacGillewye MacGilliduffi MacGilliewie MacGilligowie MacGilligowy MacGilliue MacGilliwie MacGillogowy MacGillonie MacGillony MacGilmartine MacGilvie MacHilliegowie MacIlday MacIldeu MacIldeus MacIldew MacIldoui MacIldowie MacIldowy MacIldue MacIlduf MacIlduff MacIlduy MacIlewe MacIlghuie MacIlguie MacIlguy MacIllewe MacIllewie MacIllhuy MacIlliduy MacIlmartine MacIlmertin MacInclerich MacInclerie MacInclerycht MacIntailyeour MacIntayleor MacIntaylor MacIntyller MacIntylor MacKail MacKaill MacKale MacKeil MacKeldey MacKeldowie MacKell MacKildaiye MacKilday MacKillmartine MacKintaylzeor MacKleiry MacKphaill MacKyntalyhur MacLear MacLeary MacLerich MacLerie MacLonvie MacLouvie MacMalduff MacMarten MacMartin MacMartun MacMartyne MacMertein MacMertene MacMertin MacOchtery MacOchtrie MacOchtry MacOlonie MacOlony MacOlrig MacOnie MacOulric MacOurlic MacPaill MacPaul MacPhael MacPhaell MacPhail MacPhaile MacPhaill MacPhale MacPhaul MacPhaull MacPhayll MacPhell MacPhial MacPhiel MacSoirle MacSorle MacSorley MacSorlie MacSorll MacSorlle MacSorrill MacSorrle MacSouarl MacTalzyr MacUalraig MacUaraig MacUlric MacUlrich MacUlrick MacUlrig MacVail MacVale MacWalrick Mairtin Makfaill Makfale Makfele Makgillevye Makgillewe Makgillewie Makintailzour Makintalyour Maklearie Makmartin Makoolrik Makphaile Makyntailzour Martein Martin Martine Martyn Martyne Mickellduff Nickphaile Pal Paul Paule Paull Pol Pole Serle Soirlie Somerled Somhairle Sommerled Sorill Sorlet Sorley Sorleyson Sorlie Sorll Sorlle Sorrie Sourle Sumerled Sumerledi Sumerleht Sumerleith Sumerleth Sumerlethus Summerleith Surlay Surleus Surley Surly Tailer Tailleur Tailliour Taillor Taillur Taillyer Taillzier Tailyeour Tailzer Tailzieor Tailzieour Talyeor Talyhour Talzeor Talzior Talzour Tayler Tayleur Tayliour Tayllur Taylor Taylowre Taylyhour Taylyour Telyour Tyllour Vail


Cameron Of Erracht
Clan History: http://electricscotland.com/webclans/atoc/cameron.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=665
Associated Names and Septs (with spelling variations):
Cameron

Cameron Of Locheil
Clan History: http://electricscotland.com/webclans/atoc/cameron.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=913
Associated Names and Septs (with spelling variations):
Lochiel

Campbell
Clan History: http://electricscotland.com/webclans/atoc/campbel.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=63
Associated Names and Septs (with spelling variations):
Banaghtyn Banauchtyn Banauthyn Bannachty Bannachtyn Bannantyne Bannatine Bannatyne Bannochtyne Benauty Bennachtyne Bennothine Benothyne Bernes Bernis Bernys Burnace Burnasse Burnes Burness Burnice Burnis Burns Cambal Cambale Cambel Cambele Cambell Cambelle Camble Cammell Campbele Campbell Campbill Campble Chambelle Craignish Dennoun Denone Denoon Denoone Denoun Denoune Denowne Denune Donon Dunnon Dunnone Dunnown Dunnune Dunon Dunoon Dunoun Dunown Dunune Ellar Euer Evar Evir Ewar Ewer Ewers Gebbieson Geib Gib Gibb Gibbeson Gibbie Gibbieson Gibbinson Gibbisone Gibbon Gibbons Gibbs Gibson Gibsone Gibsoun Gibsoune Gilbert Gilbertson Gilbertsone Ginsoune Gipson Gipsone Gipsoun Glas Glass Glasse Gybbesone Gybson Gybsone Gybsoun Gypsone Hawes Haws Hawson Hawsone Horie Hurray Hurrie Hurry Ivar Iver Iverson Ivirach Ivor Ivory Iwur Kambail Kambaile Kambayl Keesack Kellar Keller Killichoan Kissack Kissick Kissock Kumpel Louise MacAlar MacAllar MacAmelyne MacAmlain MacAomlin MacAsh MacAver MacAves MacAvis MacAvish MacAwis MacAwishe MacAws MacCaish MacCaishe MacCallar MacCallien MacCallion MacCalzean MacCash MacCaueis MacCauish MacCause MacCavis MacCavish MacCavss MacCaweis MacCawis MacCaws MacCeasag MacCeasaig MacCellair MacCeller MacCisaig MacCoan MacCowan MacCowen MacCowir MacCowne MacCuabain MacCubben MacCubbin MacCubbine MacCubbing MacCubbon MacCubein MacCubeine MacCuben MacCubene MacCubine MacCubyn MacCubyne MacCuir MacCullion MacCur MacCure MacCusack MacEalair MacEiver MacEllar MacEllere MacEmlinn MacEsayg MacEuer MacEuir MacEur MacEure MacEvar MacEver MacEwer MacEwir MacEwyre MacFederan MacFedran MacFun MacFunie MacFunn MacGeever MacGibbon MacGibbone MacGibon MacGibonesoun MacGiboun MacGibson MacGilchois MacGilhosche MacGillecoan MacGillequhoan MacGillequhoane MacGillhois MacGillichoan MacGillichoane MacGillochoaine MacGiver MacGlasrich MacGlasserig MacGlassrich MacIlchoan MacIlchoane MacIlchoen MacIlchomhghain MacIlfun MacIlhaos MacIlhois MacIlhoise MacIlhose MacIlhouse MacIllhois MacIllhos MacIllhose MacIllichoan MacIvar MacIver MacIverach MacIvirach MacIvor MacKalar MacKawes MacKeaver MacKeever MacKeevor MacKeiver MacKelar MacKellar MacKellayr MacKeller MacKellor MacKeur MacKever MacKevor MacKevors MacKewer MacKewyr MacKilhoise MacKillhose MacKillichoan MacKillor MacKilquhone MacKiver MacKivers MacKivirrich MacKlehois MacKowean MacKowen MacKowie MacKowin MacKowne MacKownne MacKowyne MacKuir MacKure MacLaws MacLehoan MacLehose MacNicail MacNiccoll MacNichol MacNichole MacNicholl MacNickle MacNicol MacNicoll MacNychol MacNychole MacNycholl MacOmelyne MacOwan MacOwen MacPheadarain MacPheddrin MacPhedearain MacPhederan MacPhedran MacPhedrein MacPhedron MacPheidearain MacPheidiran MacPheidran MacPheidron MacPhun MacPhune MacPhuney MacPhunie MacPhunn MacPhuny MacQuaben MacQuharrane MacQuibben MacQuibbon MacQuiben MacTaevis MacTamhais MacTause MacTaveis MacTavish MacTawisch MacTawys MacThamais MacThamhais MacThavish MacUbein MacUbin MacUbine MacUir MacUre MacYuir Makallar Makavhis Makawis Makcaus Makcawis Makcaws Makcawys Makcubeyn Makcubyn Makcubyng Makcure Makelar Makewer Makgilhois Makgilhoise Makgillechoan Makgillichoan Makillichoan Makilquhone Makiver Makkellar Maknichol Maknicoll Maknychol Maknycholl Micklehose Mucklehose Neclason Neclasson Necolson Nichol Nicholay Nichole Nicholl Nicholson Nicholsone Nicholsoun Nickle Niclasson Nicol Nicole Nicoll Nicollsoun Nicolson Nuccol Nucholl Nuckall Nuckle Nucolson Nycholay Nycholl Nycholson Nycholsoun Orr Orre Oure Penkerton Pincartone Pincartoune Pincriton Pinkartoun Pinkcartoune Pinkerton Pinkertoune Pyncartoun Pyncartoune Pynkertone Pynkertoun Pynkertoune Tais Taise Taish Taiss Tam Tameson Tamesone Tamson Tamsone Taus Taweson Tawesson Tawis Taws Tawse Tawseon Tawseson Tawson Tawst Tawus Thomason Thomasson Thomassone Thomassoun Thomessone Thompson Thomson Thomsone Thomsoun Thomsoune Thomsson Tomson Tomsone Ure Urie Urri Urrie Urry Yvar Yvir Ywar

Campbell Of Argyll
Clan History: http://electricscotland.com/webclans/atoc/campbel.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=70
Associated Names and Septs (with spelling variations):
Campbell

Campbell Of Breadalbane
Clan History: http://electricscotland.com/webclans/families/cambells_breadalbane.htm
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=71
Associated Names and Septs (with spelling variations):
Cambal Cambale Cambel Cambele Cambell Cambelle Camble Cammell Campbele Campbell Campbill Campble Chambelle Chombeich Chombich Combach Combich Connochie Connoquhie Conochie Fichar Fischair Fischar Fischare Fischear Fischer Fisher Fisser Garro Garroch Garrow Gerrow Kambail Kambaile Kambayl Kumpel MacArlich MacArliche MacAvery MacCairlich MacCairlie MacCairly MacCarlach MacCarlich MacCarliche MacCarlie MacCarlycht MacCherlich MacChombeich MacChombich MacChomich MacChonachy MacCombich MacComiche MacComick MacConachie MacConachy MacConaghy MacConche MacConchie MacConchy MacCondach MacCondachie MacCondachy MacCondie MacCondochie MacCondoquhy MacConechie MacConechy MacConiquhy MacConkey MacConnachie MacConnaghy MacConnchye MacConnechie MacConnechy MacConnichie MacConnochie MacConnoquhy MacConnquhy MacConochey MacConochie MacConoughey MacConquhie MacConquhy MacConquy MacCrom MacCron MacCrone MacCrum MacCrumb MacCrume MacCrumie MacDairmid MacDairmint MacDarmid MacDearmid MacDearmont MacDermaid MacDermand MacDerment MacDermid MacDermont MacDermot MacDermott MacDhiarmaid MacDhomhnuill MacDhonnachie MacDiarmid MacDiarmond MacDonach MacDonachie MacDonachy MacDonagh MacDonchy MacDonnach MacDonnchaidh MacDonochie MacDonough MacDonquhy MacDouagh MacGarrow MacHerlick MacHerloch MacHonichy MacIlchomich MacInechy MacIneskair MacInesker MacInisker MacInneskar MacInnesker MacKairlie MacKairly MacKarlich MacKchonchie MacKearlie MacKearly MacKerley MacKerlich MacKerliche MacKerlie MacKerloch MacKhonachy MacKinneskar MacKondachy MacKonochie MacKunuchie MacNeskar MacNesker MacOnachie MacOnachy MacOnchie MacOndochie MacOndoquhy MacOnechy MacOnochie MacOnohie MacOstrich MacOstrick MacTarmayt Makarlich Makchonachy Makconchie Makconoch Makerliche Makonoquhy Vconchie

Campbell Of Cawdor
Clan History: http://electricscotland.com/webclans/families/cambells_cawdor.htm
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=72
Associated Names and Septs (with spelling variations):
Cadall Caddel Caddell Cadder Cadell Cadella Caldaile Caldell Calder Caldor Cambal Cambale Cambel Cambele Cambell Cambelle Camble Cammell Campbele Campbell Campbill Campble Cattal Cattall Cattell Cattle Cauder Caudle Caulder Cawdale Cawdor Chambelle Cowdale Kambail Kambaile Kambayl Kumpel O'Docharty Torie Torrie Torry

Campbell Of Loudoun
Clan History: http://electricscotland.com/webclans/atoc/campbel.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=76
Associated Names and Septs (with spelling variations):
Cambal Cambale Cambel Cambele Cambell Cambelle Camble Cammell Campbele Campbell Campbill Campble Chambelle Kambail Kambaile Kambayl Kumpel Louden Loudon Loudoun Lowden Lowdon

Carmichael
Clan History: http://electricscotland.com/webclans/atoc/carmich.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=79
Associated Names and Septs (with spelling variations):
Carmechele Carmichael Carmichaill Carmichel Carmichell Carmigell Carmighell Carmitely Carmychale Carmychall Carmychel Carmychell Cayrmichel Cayrmichell Kermychell

Carnegie
Clan History: http://electricscotland.com/webclans/atoc/carnegi.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=80
Associated Names and Septs (with spelling variations):
Balinhard Ballinhard Carinnegi Carnage Carnagie Carnagy Carneaggie Carneggie Carnegi Carnegie Carnegy Carnigy Carrinegy Carryneggi Kernagy Kornegay

Carrick
Clan History: http://electricscotland.com/webclans/district_of_carrick.htm
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=674
Associated Names and Septs (with spelling variations):
Carric Carrick Carrik Carryk Karrick Karryc MacEachan MacEacharin MacEachin

Charteris
Clan History: http://electricscotland.com/webclans/atoc/charteris.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=-863725188
Associated Names and Septs (with spelling variations):
Charteris

Cheape
Clan History: http://electricscotland.com/webclans/atoc/cheape.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1382
Associated Names and Septs (with spelling variations):
Cheape

Chisholm
Clan History: http://electricscotland.com/webclans/atoc/chishol.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=82
Associated Names and Septs (with spelling variations):
Cheishame Cheishelm Cheisholme Chesame Chesehelme Cheseholm Cheseim Cheshelm Cheshelme Chesholm Chesholme Cheshom Chesim Chesolm Chesolme Chesom Chesome Chessam Chessame Chesseholme Chisholm Chisholme Chism Chisolm Chisolme Chisomme Chissem Chissim Chissolme Schisholme Schishome Schisolme Schisome Sheshelm Shisholme

Christie
Clan History: http://electricscotland.com/webclans/atoc/christi.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=83
Associated Names and Septs (with spelling variations):
Christeson Christian Christie Christinus Christison Christisone Christisoun Christopher Christopherson Christy Chrystal Chrystall Chryste Chrysteson Chrystesone Chrystesoun Chrystesoune Chrystie Chrystiesone Chrystison Chrystisoun Chrysty Chrystyson Creste Cresteson Crestesone Criste Cristeson Cristie Cristin Cristison Cristisone Cristy Cristyson Cristysoun Cristysoune Crystal Crysteson MacChristian MacChristie MacChristy MacChrystal MacCrastyne MacCristal MacCriste MacCristie MacCristin MacCristine MacKirsty

Cian
Clan History: http://electricscotland.com/webclans/scotsirish/carroll.htm
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=819
Associated Names and Septs (with spelling variations):
Cian

Clan Chattan
Clan History: http://electricscotland.com/webclans/atoc/chattan.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=84
Associated Names and Septs (with spelling variations):
Adamson Adamsone Ademson Ademsoun Ademsoune Aesone Aison Aissone Aissoun Aissoune Alees Aleese Archibald Ason Asone Asson Assone Aue Ave Ay Aye Ayesone Ayson Aysone Aysoun Ayssoun Bain Baine Baines Bane Bayin Bayn Bayne Baynes Baynne Bean Beanes Beine Bene Bhaine Brabener Brabiner Brabnar Braboner Brabunar Brabuner Braibener Braymer Brebener Brebner Breboner Brember Brembner Bremner Brimer Brimmer Brimner Brobner Brymer Brymner Caidh Caig Catan Catanach Catanache Catanoch Cate Cathan Catnach Cattan Cattanach Cattanoch Cattenach Cattenoch Ceiteach Chatain Chattan Chombeich Chombich Chombie Claerk Clark Clarke Clarkson Clarksone Clearkson Cleary Clerach Clerc Clerck Clercsone Cleric Cleric Clerie Clerk Clerke Clerkson Clerksone Clerksoun Clerksson Clunie Clunnie Cluny Clwny Clwnye Coates Coats Coitis Coittes Coittis Comb Combach Combe Combich Combie Conlay Conley Cotis Cottes Cottis Coults Couric Coutes Coutis Couts Coutts Couttss Coutys Cowltis Cowtes Cowtis Cowttis Crarer Crerar Crerer Criathrar Cultis Cults Curie Curray Curre Curri Currie Curry Currye Cutis Dallas Dallass Dallyas Dason Dasone Daueson Dauesoun Dauiesone Dauison Dauisone Dauisoun Dauson Dausoun Dauyson Dauysone Daveson Davidson Davidsone Davie Daviesoune Davis Davison Davisoun Davitson Davyson Davysone Daw Dawe Dawes Daweson Dawson Dawsone Dawysone Dawysoun Dean Deane Deason Deasone Deasson Deassoun Dein Dene Desson Deyne Dick Dickason Dickeson Dickie Dickison Dickson Dicsoun Dikiesoun Dikkyson Dikson Diksonne Dikyson Dixon Dolace Dolas Dolasse Dolays Doles Doleys Dollace Dolles Eason Easone Easson Eldar Eldare Elder Esson Fail Fairhar Fall Farahar Farcar Farchar Farchare Farcharsone Farcharsoun Farchyrson Farhard Farqhar Farqrson Farquar Farquhar Farquharson Farquharsone Farquhart Farthquhare Faurcharson Faurcharsone Fearachar Fearchair Fercard Ferchar Ferchard Ferchart Fercheth Ferchware Feresoun Ferghard Ferhare Ferkar Ferquard Ferquhar Ferquharsoun Fersen Ferson Ferthet Findel Findelasone Findlaisone Findlauson Findlaw Findlay Findlayson Findley Findleysone Finlaison Finlason Finlasone Finlasoun Finlaw Finlawsone Finlawsoune Finlay Finlayson Finley Finlinson Fionnla Fionnlach Fionnlagh Forquhair Fourcharsoun Fyndelay Fyndelosoun Fyndlae Fyndlasoun Fyndlaw Fynlaw Fynlawesone Fynloson Galashan Galeaspe Gellas Gellion Ghillaspic Gilasp Gilaspy Gilderoy Gilhaspy Gilhespy Gilies Gilise Gilispie Gillan Gillas Gillaspik Gillaspy Gillean Gilleis Gilleon Gilles Gillespey Gillespie Gillian Gillice Gillie Gillies Gilliosa Gillis Gillise Gilliss Gillon Gilray Gilroy Gilry Gilvray Gilyean Gilzean Gilzeane Glashan Glashen Glashin Glen Glene Gleney Glenn Glennay Glennie Glenny Gleny Golane Golin Gollan Golland Gollane Gollin Gollon Gove Gow Gowan Gowans Gowen Gowie Gowin Gracey Gracie Gracy Graisich Grasich Grass Grasse Grasseich Grassiche Grassichsone Grassick Grassie Grasycht Graysich Greasaighe Greasich Grecie Greishich Greoschich Greoshich Greshach Gresich Gressiche Greusach Greusaich Grevsach Griasaich Griesck Gylis Gyllis Hairdy Hardie Hardy Hardye Heagie Heagy Heegie Heggie Hegie Hegy Higgie Hosack Hosak Hosick Hossack Hossok Hossoke Ison Isone Kae Kay Kaye Kayt Keathe Keay Kee Keht Keith Kellas Kelles Kerracher Ket Keth Kethe Key Keyth Keythe Keytht Kite Knevan Kowtis Leary Lees Leys Lion Lione Lios Lioun Lyon Lyoun Lyoune MacAig MacAige MacAindreis MacAlbea MacAleerie MacAlees MacAliece MacAnally MacAndrew MacAndrie MacAndro MacAndy MacAnnally MacA'Phearsain MacA'Phearsoin MacAppersone MacArdie MacArdy MacArquhar MacAy MacBain MacBaith MacBane MacBardie MacBathe MacBay MacBayne MacBea MacBean MacBeane MacBeath MacBeatha MacBeathy MacBee MacBehan MacBeith MacBen MacBeth MacBetha MacBey MacBheath MacBheatha MacBheathain MacBurie MacCagy MacCaig MacCaige MacCannally MacCarday MacCardie MacCardney MacCardy MacCarquhar MacCarracher MacChardaidh MacChardy MacChlerich MacChlery MacChomay MacChombeich MacChombich MacChomich MacClachan MacClachane MacClathan MacClearey MacCleary MacCleche MacClees MacCleiche MacCleisch MacCleish MacCleishe MacCleisich MacClerich MacCleriche MacClerie MacClery MacClese MacCleys MacCliesh MacClirie MacClurich MacCoage MacColeis MacColleis MacColm MacColme MacColmie MacColmy MacComaidh MacComais MacComas MacComash MacComb MacCombe MacCombich MacCombie MacCombs MacCome MacComes MacComey MacComiche MacComick MacComie MacComish MacComy MacConche MacConchie MacConchy MacCondach MacCondachie MacCondachy MacCondie MacCondochie MacCondoquhy MacConnchye MacConquhy MacConquy MacCourich MacCuinn MacCulican MacCuligan MacCuligin MacCulikan MacCuliken MacCune MacCunn MacCurich MacCurie MacCurrach MacCurragh MacCurrich MacCurrie MacCurry MacCwne MacDade MacDaid MacDavid MacEarachar MacEaracher MacEgie MacEleary MacElhatton MacElpersoun MacElroy MacElvain MacElveen MacElwain MacEntyre MacEracher MacErar MacErchar MacErracher MacErrocher MacFaell MacFail MacFal MacFale MacFall MacFarquhar MacFarquher MacFarsane MacFarsne MacFarson MacFaul MacFauld MacFaull MacFayle MacFerchar MacFerquhair MacFerquhare MacFerson MacFersoune MacFoill MacForsoun MacFuirigh MacFyall MacGabhawn MacGhobhainn MacGhowin MacGilchatton MacGiligan MacGillas MacGillavary MacGillebeatha MacGillechattan MacGilleglash MacGilleis MacGillese MacGillevary MacGillevoray MacGillevorie MacGillevray MacGillewra MacGillewray MacGillican MacGillies MacGilligain MacGilligan MacGilligin MacGillis MacGillish MacGillivary MacGillivoor MacGillivraid MacGillivray MacGillivrie MacGillivry MacGillowray MacGillvary MacGillveray MacGillvery MacGillvra MacGillvray MacGilrey MacGilroy MacGilroye MacGilvane MacGilvary MacGilvery MacGilvory MacGilvra MacGilvray MacGilweane MacGilwrey MacGlashan MacGlashen MacGlashin MacGlassan MacGlassin MacGlasson MacGleish MacGouan MacGoun MacGoune MacGovin MacGow MacGowan MacGowen MacGown MacGowne MacGowy MacGruaig MacGuilvery MacGuin MacGulican MacHarday MacHardie MacHardy MacHatton MacHay MacHee MacHillies MacHilmane MacHomas MacHomash MacHomie MacHquan MacHquhan MacHuin MacIlbraie MacIlchattan MacIlchombie MacIlchomich MacIlchomie MacIlchomy MacIlees MacIleish MacIlhatton MacIlishe MacIliwray MacIllees MacIlleese MacIlleglass MacIlleish MacIllory MacIllvain MacIllveyan MacIllvra MacIlmeane MacIlmeine MacIlmeyne MacIloray MacIlra MacIlray MacIlrie MacIlroy MacIluray MacIlvain MacIlvaine MacIlvane MacIlvayne MacIlvean MacIlveane MacIlveen MacIlveerie MacIlvery MacIlvian MacIlvora MacIlvoray MacIlvory MacIlvra MacIlvrach MacIlvrae MacIlvray MacIlwain MacIlwaine MacIlweine MacIlwra MacIlwray MacInally MacInclerich MacInclerie MacInclerycht MacInferson MacInteer MacIntire MacIntyir MacIntyr MacIntyre MacKaggie MacKaig MacKaige MacKaigh MacKandrew MacKardie MacKbayth MacKcaige MacKeag MacKeandla MacKeeg MacKegg MacKeggie MacKeig MacKeith MacKelecan MacKelegan MacKelican MacKelrae MacKelvain MacKentyre MacKeracher MacKerchar MacKercher MacKerichar MacKericher MacKerracher MacKerricher MacKethe MacKglesson MacKhardie MacKigg MacKilferson MacKilican MacKilikin MacKillican MacKillicane MacKillichane MacKilligan MacKilligane MacKilligin MacKilrae MacKilrea MacKilroy MacKilvain MacKilvane MacKilven MacKilwein MacKilweyan MacKilwyan MacKindlay MacKinfarsoun MacKinla MacKinlay MacKinley MacKintishie MacKintoch MacKintoche MacKintoisch MacKintorss MacKintosh MacKintyre MacKleiry MacKleroy MacKlewain MacKomash MacKomie MacKommie MacKomy MacKperson MacKphaill MacKpharsone MacKqueane MacKquyne MacKreiche MacKritchy MacKulican MacKurrich MacKury MacKygo MacKynioyss MacKyntoich MacKyntossche MacKyntoys MacLear MacLeary MacLeash MacLees MacLeesh MacLeich MacLeish MacLerich MacLerie MacLeroy MacLese MacLess MacLewain MacLglesson MacLise MacLish MacLiss MacLroy MacMhourich MacMhuireadhaigh MacMhuirich MacMhuirrich MacMordoch MacMuiredhaigh MacMuiredhuigh MacMuirigh MacMurich MacMurrich MacMurriche MacMurrycht MacNally MacNaoimhin MacNeiving MacNevin MacNivaine MacNiven MacOmie MacOmish MacOnchie MacOnlay MacOulroy MacOurich MacPaill MacPaul MacPearson MacPerson MacPersone MacPersonn MacPhael MacPhaell MacPhail MacPhaile MacPhaill MacPhale MacPharson MacPhaul MacPhaull MacPhayll MacPhearson MacPhell MacPhersen MacPherson MacPhersone MacPhial MacPhiel MacQhardies MacQuain MacQuan MacQuaynes MacQuean MacQueane MacQueen MacQueeney MacQueenie MacQuein MacQueine MacQuen MacQuene MacQueyn MacQueyne MacQuhan MacQuheen MacQuhen MacQuhenn MacQuhenne MacQuheyne MacQuhyn MacQuhyne MacQuien MacQuin MacQuine MacQuinne MacQuinnes MacRaild MacRaill MacRailt MacReekie MacReiche MacRiche MacRichie MacRikie MacRitchey MacRitchie MacRitchy MacRyche MacSayde MacSeveney MacShuibhne MacSuain MacSuin MacSwain MacSwaine MacSwan MacSwane MacSween MacSwen MacSweyne MacSwyde MacSwyne MacTarlach MacTarlich MacTear MacTeer MacTeir MacTer MacTere MacTerlach MacTeyr MacThearlaich MacThom MacThomaidh MacThomais MacThomas MacThome MacThomie MacTier MacTire MacToiche MacTomais MacToschy MacToshy MacTyr MacTyre MacUirigh MacUne MacUrich MacVail MacVain MacVaine MacVale MacVane MacVarraich MacVarrich MacVean MacVeane MacVeirrich MacVirrich MacVirriche MacVoerich MacVorich MacVoriche MacVorrich MacVourich MacVurich MacVurie MacVurirch MacVuririch MacVurrich MacVurriche MacWean MacWeane MacWhan MacWhanne MacWhin MacWhinn MacWirrich MacWirriche MacWurie MacYlory MacYlroy MacYlroye MacYlveine MacYntyre Maelbeth Makandro Makcome Makcomius Makconchie Makcurrie Makeeg Makfaill Makfale Makfarson Makfassane Makfele Makferquhair Makfersan Makfersone Makfersoun Makferssoun Makghobhainn Makgilroy Makgilvane Makgowane Makgowin Makhaig Makillewray Makilmain Makilmeyn Makilrow Makilvane Makilvene Makilwene Makilwyane Makimpersone Makintare Makkilrow Maklearie Makleis Makmurdie Makmurriche Makmurthe Makphaile Makphersone Makquean Makquene Makquhan Makquhane Makquhen Makquhon Makryche Makteir Makter Makthome Makthomy Maktyre Makulikin Makvirriche Makynparsone Malbeth Maquhon Meikleroy Mekilwaine Melbeth Micklroy Milroy Mordac Mordake Mordik Mordoc Mordok Mordyk Moreduc Morthaich Mourdac Mteir Muireach Muireadhach Muiredach Murdac Murdak Murdoc Murdoch Murdock Murdoson Murdy Murreich Murthac Murthak Naomhin Nickphaile Nobil Nobile Nobill Noble Pal Paul Paule Paull Pearson Pharquhair Pherharchd Phinlaw Pol Pole Quin Quinn Raich Reach Reacht Reaich Reauch Reaucht Reche Rechie Rechtie Rechy Reiach Reith Reithe Reoch Reoche Rethe Reuch Revan Revans Reyth Riach Riauch Riche Richie Rioch Rioche Ritchie Roeoch Rychy Rychze Rytchie Saythe Scaith Scayth Schau Schaw Schawe Scheoch Scheok Schiach Schioch Schioche Seah Seath Seith Seth Sha Shau Shaw Shawe Shay Sheach Sheath Sheehan Sheoch Shiach Siache Sith Sithach Sithech Sithig Skaith Smeayth Smith Smyith Smyithe Smyth Smythe Suain Svan Sveinn Swain Swan Swane Swann Swayne Sween Swein Sweing Swen Sweyn Sweyne Swyde Swyn Swyne Sythach Sythag Sythock Tam Tameson Tamesone Tamson Tamsone Tarall Taroll Tarrel Tarrell Tarrill Terale Terrel Terrell Terroll Thom Thomas Thomason Thomasson Thomassone Thomassoun Thome Thomessone Thompson Thoms Thomson Thomsone Thomsoun Thomsoune Thomsson Thowmis Thowms Tire Toash Toische Tomson Tomsone Tyre Vail Vcgillevorie Vconchie Versen

Clan Cian
Clan History: http://electricscotland.com/webclans/scotsirish/carroll.htm
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=938272859
Associated Names and Septs (with spelling variations):
Carroll Cassells Correl Correll Corril Corrill Karwell Keenan O'Carroll O'Conner O'Karrell

Clark
Clan History: http://electricscotland.com/webclans/atoc/clerke.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=88
Associated Names and Septs (with spelling variations):
Claerk Clark Clarke Clarkson Clarksone Clearkson Cleary Clerach Clerc Clerck Clercsone Clerie Clerk Clerke Clerkson Clerksone Clerksoun Clerksson Leary MacAleerie MacChlerich MacChlery MacClearey MacCleary MacClerich MacCleriche MacClerie MacClery MacClirie MacClurich MacEleary MacInclerich MacInclerie MacInclerycht MacKleiry MacLear MacLeary MacLeerie MacLerich MacLerie Maklearie

Cleland
Clan History: http://electricscotland.com/webclans/atoc/cleland.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=90
Associated Names and Septs (with spelling variations):
Clalan Cleadland Cleadlande Cleaveland Cleeland Cleiland Cleilland Cleland Clelane Clelend Clellan Clelland Clellane Clellond Clenel Clerland Cliland Kalland Kealand Kealland Keelland Kelland Kneband Kneland MacClallane MacCleallane MacCleilane MacClelan MacClellan MacClelland MacKlellan MacKlellane MacKnellan Nield Niland Nilland Noland Nyland

Clergy
Clan History: http://electricscotland.com/webclans/atoc/clerke.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=818
Associated Names and Septs (with spelling variations):
Clergy

Clerke Of Ulva
Clan History: http://electricscotland.com/webclans/atoc/clerke.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=861
Associated Names and Septs (with spelling variations):
Ulva

Cochrane
Clan History: http://electricscotland.com/webclans/atoc/cochran.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=91
Associated Names and Septs (with spelling variations):
Cawchrin Coachran Coachrin Cocheran Cocherane Cochran Cochrane Cochrein Cochren Cochroune Cogherane Coheran Cohern Coichraine Coichran Colquheran Colquhran Couchran Coughran Coweran Cowran

Cockburn
Clan History: http://electricscotland.com/webclans/atoc/cockbur.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=92
Associated Names and Septs (with spelling variations):
Chockeburn Cobron Cocburn Cockburn Cogburn Cogburne Cokborn Cokborne Cokbrine Cokbrown Cokbrowne Cokburne Cokeburn Cokeburne Cowborn Cukburn Kocburn Kokburn Kokburne Kokeburn Kokeburne

Colquhoun
Clan History: http://electricscotland.com/webclans/atoc/colquho.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=93
Associated Names and Septs (with spelling variations):
Caan Cachoune Cahoon Cahoun Cahoune Cahun Cahund Cahune Calhoon Calhoun Calquhoun Calquhoune Calwhone Caun Choquoyn Cohune Colchoun Colechon Colfune Colhoun Colhoune Collquhone Colqhoun Colqhuen Colquhone Colquhoun Colquhoune Colquhowne Colquhyn Colqwhone Colwhone Colwhoun Couen Cowan Cowane Cowans Cowen Cowhen Cowing Cowquhowne Culchon Culchone Culchoun Culquhone Culquhoun Culquhoune Culqwhone Culqwon Culqwone Culwone Gahn Kelquon Killichoan Kilpatric Kilpatrick Kilwhone Kirkpatrick Kirkpatrik Kulwoon Kulwoun Kylkone Kylpatrik Kylpatryk Mac-A-Chounich Mac-A-Chonnick Mac-A-Chounich MacCoan MacCowan MacCowen MacCowne MacGillecoan MacGillequhoan MacGillequhoane MacGillichoan MacGillichoane MacGillochoaine MacIlchoan MacIlchoane MacIlchoen MacIlchomhghain MacIllichoan MacInturner MacKillichoan MacKilquhone MacKowean MacKowen MacKowie MacKowin MacKowne MacKownne MacKowyne MacLehoan MacMagnus MacMain MacMaines MacMainess MacMains MacMan MacManes MacManis MacMann MacMannas MacMannes MacMannus MacManus MacMayne MacMhannis MacOwan MacOwen Main Mainn Mainsoun Makgillechoan Makgillichoan Makillichoan Makilquhone Mane Mayne Qulchom Qulchone Qulwone Quohon Turneour Turner Turnor Turnour Turnoure

Connel
Clan History: http://electricscotland.com/webclans/atoc/connal.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1375
Associated Names and Septs (with spelling variations):
Connel

Cooper
Clan History: http://electricscotland.com/webclans/atoc/cooper.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=97
Associated Names and Septs (with spelling variations):
Cooper Copper Coupar Coupare Couper Couppar Cowlpar Cowlper Cowpar Cowper Culpar Cupar Cuper Cupir

Craig
Clan History: http://electricscotland.com/webclans/atoc/craig.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=100
Associated Names and Septs (with spelling variations):
Crag Crage Cragge Cragie Craig Craigh

Cranston
Clan History: http://electricscotland.com/webclans/atoc/cransto.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=101
Associated Names and Septs (with spelling variations):
Cranestone Cranestowne Cranston Cranstone Cranstoun Cranystoun Craynston Creinstoun Crenestone

Crawford
Clan History: http://electricscotland.com/webclans/atoc/crawfor.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=102
Associated Names and Septs (with spelling variations):
Crafford Crafoard Crafoord Craford Crafort Crafuirde Crafurd Crauffurd Craufoord Crauford Crauforth Craufurd Craufurde Craunford Craweford Crawfaird Crawfeurd Crawffurd Crawford Crawfurd Crouford Krauford

Cumming
Clan History: http://electricscotland.com/webclans/atoc/cumming.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=103
Associated Names and Septs (with spelling variations):
Bochane Boghan Buccan Bucchaine Bucchan Buchan Buchane Bughan Buquhan Comine Common Commons Comyn Comyns Cumin Cumine Cuming Cummin Cummine Cumming Cummings Cummins Cumyn Knevan MacNaoimhin MacNeiving MacNevin MacNivaine MacNiven Naomhin Neiven Neivin Nevane Nevein Neveine Nevene Nevin Nevins Nevinus Nevison Nevyn Nevyne Nevyng Newein Newin Newing Nifin Nivein Niven Niveson Nivine Niving Nivison Rossel Rossell Rusel Russale Russall Russaule Russel Russell Russelle

Cunningham
Clan History: http://electricscotland.com/webclans/atoc/cunning.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=105
Associated Names and Septs (with spelling variations):
Chonigham Conigham Conighame Conningans Conyghans Conyngham Conynghame Cunigham Cunigom Cuninggame Cuningham Cuninghame Cunningghame Cunningham Cunninghame Cunnygam Cunnyngayme Cunnynghame Cunygam Cunyghame Cunymgham Cunyngaham Cunyngahame Cunyngame Cunynghame Cwnninghame Cwnygham Cwnyghame Kuningham Kyninghame Warnebald

Currie
Clan History: http://electricscotland.com/webclans/atoc/currie.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1387
Associated Names and Septs (with spelling variations):
Curie Currie

D
Dalrymple
Clan History: http://electricscotland.com/webclans/dtog/dalrymp.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=106
Associated Names and Septs (with spelling variations):
Dalrimpill Dalrumpil Dalrumpill Dalrumple Dalrympil Dalrympille Dalrymple Darumple Darymple Dawrumpyl Derumpill


Dalzell
Clan History: http://electricscotland.com/webclans/dtog/dalzell.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=107
Associated Names and Septs (with spelling variations):
Alidiel Daleyhell Daleyhelle Daliel Daliell Dalielle Dalliell Dalsell Dalyel Dalyell Dalyhel Dalyhell Dalyiel Dalzel Dalzell Dalzelle Dalziel Dalziell Dayzill Deell Deill Deyell Diyell Duill Dyayell Dyell

Davidson
Clan History: http://electricscotland.com/webclans/dtog/davidso.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=109
Associated Names and Septs (with spelling variations):
Dason Dasone Daueson Dauesoun Dauiesone Dauison Dauisone Dauisoun Dauson Dausoun Dauyson Dauysone Daveson Davey Davidson Davidsone Davie Daviesoune Davis Davison Davisoun Davitson Davyson Davysone Daw Dawe Dawes Daweson Dawson Dawsone Dawysone Dawysoun Day Dean Deane Deason Deasone Deasson Deassoun Dein Dene Desson Deyne Kae Kay Kaye Keay Kee Key MacDade MacDaid MacDavid Slora Slorach

Deas
Clan History: http://electricscotland.com/webclans/dtog/deas.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=111
Associated Names and Septs (with spelling variations):
Daes Days Deas Deays Deys

Denny
Clan History: http://electricscotland.com/webclans/scotsirish/denny.htm
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1434
Associated Names and Septs (with spelling variations):
Denny

Denovan
Clan History: http://electricscotland.com/webclans/dtog/denovan.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1433
Associated Names and Septs (with spelling variations):
Denovan

Douglas
Clan History: http://electricscotland.com/webclans/dtog/douglas.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=113
Associated Names and Septs (with spelling variations):
Cavers Dogles Douglace Douglas Douglase Douglass Dougles Douglis Douglles Dovglas Dowglace Dowglas Dowglass Dowglasse Drysdale Duglas Dulglas Dulglass Forest Forrest Glaister Glen Glendinning Inglis Kirkpatrick Lockerby MacGuffie MacGuffock Morton Sandilands

Drummond
Clan History: http://electricscotland.com/webclans/dtog/drummon.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=114
Associated Names and Septs (with spelling variations):
Begg Beggs Brewer Brostar Broster Broustar Broustare Brouster Broustir Browistar Browstare Browster Carghille Cargil Cargile Cargill Cargyl Crowder Doeg Dog Doig Dormond Dormondy Dreumond Droman Drominth Drommonde Drommount Dromonde Dromounde Dromund Droumound Drumman Drummond Drummont Drummot Drummyn Drumon Drumont Drumund Drumunde Grewar Grewer Grewyr Growar Gruar Gruer Kergill Kergille Kergyl Kergyll Kergylle MacCrewer MacCrewir MacCrobie MacCrouder MacCrouther MacCrowther MacDormond MacGrader MacGrevar MacGrewar MacGrewer MacGrouther MacGrowder MacGrowther MacGruar MacGrudaire MacGrudder MacGruder MacGruer MacGruthar MacGruther MacHrudder MacHruder MacRither MacRobbie MacRobi MacRobie MacRobin MacRuar MacRudder MacRudrie MacRuer Magruder Makgruder Makroby Makrudder Muschate Muschet Muschett Mushet Rabbe Robbie Robe Robie Roby Robye

Dunbar
Clan History: http://electricscotland.com/webclans/dtog/dunbar.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=116
Associated Names and Septs (with spelling variations):
Aberlady Dounbare Dumbar Dumbare Dunbar Dunbarre Pitgaven

Duncan
Clan History: http://electricscotland.com/webclans/dtog/duncan.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=117
Associated Names and Septs (with spelling variations):
Donnchad Donnchadh Donnchaidh Duncan Duncane Duncaneson Duncanson Duncanus Dunchad Dunckane Dunckiesone Dunecan Dunecanus Dunkan Dunkane Dunkanson Dunkansoun Dunkeson Dunkesone Dunkesoun Dunkinssone Dunkysoun

Dundas
Clan History: http://electricscotland.com/webclans/dtog/dundas.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=118
Associated Names and Septs (with spelling variations):
Dass Dundas Dundass

Dunlop
Clan History: http://electricscotland.com/webclans/dtog/dunlop.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=119
Associated Names and Septs (with spelling variations):
Dalape Dewlap Donlap Donlip Donlop Downlop Dullope Dunlap Dunlape Dunlip Dunlop Dunlope Dunlopp Dunluop

E
Elliot
Clan History: http://electricscotland.com/webclans/dtog/elliot.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=122
Associated Names and Septs (with spelling variations):
Aelwold Allat Dalliot Eleot Elewald Eliot Eliott Ellat Elleot Ellet Ellett Ellette Elliot Elliott Elliotti Ellot Ellote Ellott Elluat Ellwald Ellwod Ellwodd Ellwold Ellwood Eluat Elwald Elwalde Elwand Elwat Elwet Elwett Elwod Elwold Elwood Elwoode Elwoold Elyot Elyoth Helewald Hellwood Illot


Elphinstone
Clan History: http://electricscotland.com/webclans/dtog/elphinstone.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=123
Associated Names and Septs (with spelling variations):
Elfinistun Elfinstone Elfynston Elphestoun Elphingstone Elphingstoun Elphinston Elphinstone Elphinstun Elphistin Elphistoun Elphistun Elphynston Elphynstoun Elphynstoune

Erskine
Clan History: http://electricscotland.com/webclans/dtog/erskine.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=124
Associated Names and Septs (with spelling variations):
Aersken Aerskine Aersking Areskin Areskine Arskeyne Arskin Arskine Arskyn Askin Askine Assequin Erkyrn Erschin Erschine Ersken Erskine Erskye Erskyn Erskyne Erskynn Ersskyne Hasquin Herskyne Hirskyne Ireskin Irskine Irskyn Irskyne

F
Falconer
Clan History: http://electricscotland.com/webclans/dtog/falconer.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=125
Associated Names and Septs (with spelling variations):
Falcener Falconer Falknar Falknor Fauconer Faulkner Fawconer


Farquharson
Clan History: http://electricscotland.com/webclans/dtog/farquha.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=126
Associated Names and Septs (with spelling variations):
Barrie Barry Berrie Berry Bonach Bowman Brabener Brabiner Brabnar Braboner Brabunar Brabuner Braibener Braymer Brebener Brebner Breboner Brember Brembner Bremner Brimer Brimmer Brimner Brobner Brymer Brymner Caig Christie Christison Christy Coates Coats Coitis Coittes Coittis Conlay Conley Cotis Cottes Cottis Coults Coutes Coutis Couts Coutts Couttss Coutys Cowltis Cowtes Cowtis Cowttis Cromar Cultis Cults Cutis Fairhar Farahar Farcar Farchar Farchare Farcharsone Farcharsoun Farchyrson Farhard Farqhar Farqrson Farquar Farquhar Farquharson Farquharsone Farquhart Farthquhare Faurcharson Faurcharsone Fearachar Fearchair Fercard Ferchar Ferchard Ferchart Fercheth Ferchware Ferghard Ferhare Ferkar Ferquard Ferquhar Ferquharsoun Ferries Ferthet Findel Findelasone Findlaison Findlaisone Findlauson Findlaw Findlay Findlayson Findley Findleysone Finlaison Finlason Finlasone Finlasoun Finlaw Finlawsone Finlawsoune Finlay Finlayson Finley Finlinson Fionnla Fionnlach Fionnlagh Forquhair Fourcharsoun Fyndelay Fyndelosoun Fyndlae Fyndlasoun Fyndlaw Fynlaw Fynlawesone Fynloson Gracey Gracie Gracy Graisich Grasich Grass Grasse Grasseich Grassiche Grassichsone Grassick Grassie Grasycht Graysich Greasaighe Greasich Grecie Greishich Greoschich Greoshich Greshach Gresich Gressiche Greusach Greusaich Grevsach Griasaich Griesck Hairdy Hardie Hardy Hardye Kellas Kerracher Kowtis Leys Lion Lione Lioun Lyon Lyoun Lyoune MacAig MacAige MacAnally MacAnnally MacArdie MacArdy MacArquhar MacArtney MacBardie MacCaig MacCaige MacCannally MacCarday MacCardie MacCardney MacCardy MacCarquhar MacCarracher MacCartney MacChardaidh MacChardy MacCoage MacCuaig MacEarachar MacEaracher MacEracher MacErar MacErchar MacErracher MacErrocher MacFarquhar MacFarquher MacFerchar MacFerquhair MacFerquhare MacGrasaych MacGrassych MacGrassycht MacGrasycht MacGrayych MacGreische MacGreish MacGresche MacGresich MacGressich MacGressiche MacGreusach MacGreusaich MacGreusich MacGruaig MacHarday MacHardie MacHardy MacInally MacKaig MacKaige MacKaigh MacKardie MacKcaige MacKeag MacKeandla MacKeeg MacKegg MacKeig MacKeracher MacKerchar MacKercher MacKerichar MacKericher MacKerracher MacKerricher MacKhardie MacKigg MacKindlay MacKinla MacKinlay MacKinley MacNally MacOnlay MacQhardies Makeeg Makferquhair Makhaig Paterson Pharquhair Pherharchd Phinlaw Raich Reach Reacht Reaich Reauch Reaucht Reche Reiach Reith Reithe Reoch Reoche Rethe Reuch Reyth Riach Riauch Rioch Rioche Roeoch

Farquharson Of Finzean
Clan History: http://electricscotland.com/webclans/dtog/farquha.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1266
Associated Names and Septs (with spelling variations):
Finzean

Fergusson
Clan History: http://electricscotland.com/webclans/dtog/ferguso.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=136
Associated Names and Septs (with spelling variations):
Faires Fargesoun Fargie Fargisone Farguesoun Fargusone Fargussoun Farrie Farries Feargie Feres Feresoun Fergeson Fergie Fergousoune Fergowsone Fergus Ferguson Fergusone Fergusson Fergussoun Ferres Ferries Ferris Forgie Forgusoun Furguson Kersey MacCersie MacCorvie MacCorwis MacFargus MacFergus MacFerries MacHerres MacHerries MacKaras MacKearass MacKearrois MacKearsie MacKeraish MacKeras MacKerras MacKerris MacKersey MacKersie MacKersy Pheres Phires

Fergusson Of Atholl
Clan History: http://electricscotland.com/webclans/dtog/ferguso.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=140
Associated Names and Septs (with spelling variations):
Ceddy Kadie Kady Keadie Kedde Keddie Keddy Kede Kedie Kiddie Kiddy MacAda MacAdaidh MacAddie MacAde MacAdie MacAid MacCadie MacChaddy MacEddie MacKadie MacKeddey MacKeddie MacKedy MacKiddie

Fitzpatrick
Clan History: http://electricscotland.com/webclans/scotsirish/fitzpatrick.htm
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1000
Associated Names and Septs (with spelling variations):
Fitzpatrick

Fletcher
Clan History: http://electricscotland.com/webclans/dtog/fletcher.htm
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=143
Associated Names and Septs (with spelling variations):
Dunans Flechyr Fledger Fleger Fleschar Flescher Fleschor Fleschour Flesher Flesser Flessher Flesshour Flessor Fletcheour Fletcher MacClester MacFleger MacInleaster MacInleister MacInlester MacInlister MacLeister Makfleger Makinlestar

Forbes
Clan History: http://electricscotland.com/webclans/dtog/forbes.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=144
Associated Names and Septs (with spelling variations):
Banarman Banermain Banerman Bannerman Bannermane Bennerman Berrie Berry Ffordyce Foirdyse Forbace Forbas Forbes Forbose Forbss Fordise Fordyce Fordys Fordyse Forebess MacCowatt MacHouat MacHuat MacKwatt MacOuat MacOwat MacQuat MacQuattie MacQuatty MacQuhat MacQuhatti MacQuhattie MacVat MacWat MacWatt MacWatte MacWattie MacWatty MacWete Makwat Makwatty Makwete Mechie Mediltoune Meechie Mekie Michie Michieson Middleton Mideltowne Midilton Midiltoun Midtoun Myddiltoun Myddiltoune Mydilton Vatsone Vatsoun Vatt Wason Wasson Wat Wateson Watson Watsone Watsoun Watsoune Watt Wattie Watts Wattsone Watty

Forrester
Clan History: http://electricscotland.com/webclans/dtog/forrester.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=147
Associated Names and Septs (with spelling variations):
Forastir Forest Forestar Forester Forrest Forrestar Forrester Forstar Forstare Forster Foryster Fostar Foster Froster

Forsyth
Clan History: http://electricscotland.com/webclans/dtog/forsyth.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=148
Associated Names and Septs (with spelling variations):
Faresyth Fearsithe Fersith Fersy Fersyth Foresyth Forseyth Forsith Forsithe Forsitht Forsycht Forsyth Forsythe Forsytht MacForsyth

Frame
Clan History: http://electricscotland.com/webclans/dtog/frame.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=149
Associated Names and Septs (with spelling variations):
Fframe Fraim Fram Frame Fraym Frayme

Fraser
Clan History: http://electricscotland.com/webclans/dtog/fraser.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=150
Associated Names and Septs (with spelling variations):
Abernethy Biset Bissaite Bissatt Bisset Bisseth Bissett Brewster Byset Cowie Crowder Fraiser Fraisser Fraissier Frasair Fraseir Fraser Frasier Frassel Frasser Fraysher Fraysser Frazer Frazier Fresal Fresale Fresall Fresare Frescell Fresel Fresell Freser Fresill Fresle Fressair Fressell Fresser Frew Freyser Frezel Frezer Friseal Friselle Friser Frissell Frisselle Frizell Frizzell Fryssar Fryssell Frysser Grewar Grewer Grewyr Growar Gruar Gruer Heston MacAves MacAvis MacAvish MacAwis MacAwishe MacCaueis MacCauish MacCause MacCavis MacCavish MacCavss MacCaweis MacCawis MacCaws MacCrewer MacCrewir MacCrouder MacCrouther MacCrowther MacGrader MacGrevar MacGrewar MacGrewer MacGrouther MacGrowder MacGrowther MacGruar MacGrudaire MacGrudder MacGruder MacGruer MacGruthar MacGruther MacHrudder MacHruder MacKawes MacRither MacRuar MacRudder MacRudrie MacRuer MacTaevis MacTamhais MacTause MacTaveis MacTavish MacTawisch MacTawys MacThamais MacThamhais MacThavish Magruder Makavhis Makawis Makcaus Makcawis Makcaws Makcawys Makgruder Makrudder Oliver Simpkin Twaddell Twaddle Twedie Twedy Tweeddale Tweeddy Tweedie Tweedy

Fraser Of Lovat
Clan History: http://electricscotland.com/webclans/dtog/fraser.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=152
Associated Names and Septs (with spelling variations):
Kimm Kimmie Kin Lovat Lovatt Lovett Lovitt MacImmey MacImmie MacKemie MacKemmie MacKemy MacKenmie MacKhimy MacKim MacKimmie MacKimmy MacKym MacKymmie MacShimes MacShimidh MacShimie MacShimmie MacSimon MacSymon Makemy Makkymme Makkymmie Semsone Semsoun Sim Sime Simm Simmey Simmie Simon Simpson Simson Sym Syme Symesone Symesoune Symesson Symin Symmie Symon Sympsone Sympsoun Sympsoune Symson Symsone Symsoun Symsoune

G
Galbraith
Clan History: http://electricscotland.com/webclans/dtog/galbrai.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=154
Associated Names and Septs (with spelling variations):
Balgair Begg Cabreth Calbraith Calbrathe Calbratht Calbreath Caubraith Cobreath Coubreach Coubreath Coubrough Coubruch Couburgh Coulbrough Cowbratht Cowbreath Cowbroch Cowbrough Cubrugh Cubrughe Culbreth Galbrach Galbracht Galbrad Galbraith Galbrat Galbrath Galbrathe Galbrayt Galbraytht Galbreath Gallbraith Gallbraithe Gallebrad Gawbrath Gilbreath MacBartny MacBerkny MacBertny MacBirtny MacBraten MacBratney MacBratnie MacBretnach MacBretney MacBretnie MacBretny MacVretny MacVrettny Makbrechne Makbretne Makbretny Malbratnie


Galloway
Clan History: http://electricscotland.com/webclans/dtog/galloway.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=161
Associated Names and Septs (with spelling variations):
Acarsan Acarsen Acarson Achinfour Adair Aggnew Agneaux Agneli Agnew Agnewe Agnex Ahannay Ahanney Aignell Aird Airie Allies Anewith Angnew Anwoth Arbigland Auld Aygnel Bankhead Barskine Beck Been Bennoch Birney Birnie Blackett Blacklock Blain Blane Bodden Bogrie Bogue Bombie Borland Braden Bradfute Braidfoot Bratney Bratnie Broadfoot Buckle Buittle Cairnie Cairns Caldow Cammock Candlish Cannan Cardoness Carlton Carmount Carnachan Carnahan Carnochan Carrie Carsan Carsen Carson Carssane Caskey Caskie Casskie Castlellaw Cathay Cathey Cathie Cathy Caunce Caven Cavens Cellach Chandlish Chrystal Chrystall Clanachan Clanahan Clannachan Clanochan Cleave Clenachan Clenaghan Clenochan Clerie Clingan Clingen Clinton Clogg Clokie Clugston Clukie Cogan` Coles Coltart Colthard Colthart Coltherd Colthert Coltran Coltrane Combline Conchie Conheath Coning Conning Corbie Corkran Corkrane Cornick Corsan Corsane Corsen Corson Coskry Coughtrey Coulthar Coulthard Coulthart Cririe Crockatt Crocket Crockett Crogo Crosbie Crosby Crum Crystal Cubbin Cubbison Cuffie Culloch Culton Culwen Cumstoun Curran Currans Cutler Denton Dillidaff Dinnell Dodds Donnan Doran Dougan Dowal Dowall Doweill Dowele Dowell Dowgal Dowill Drennan Drinnan Dronan Dronnan Drynan Drynen Dubucan Dugan Dunbar Dungalson Durand Durant Eagleson Edgar Enterkin Ewart Fade Faed Faid Fead Feid Fetridge Fiddison Fiddleton Fied Finnan Foulds Fowlds Gachen Gallaway Gallouay Galloway Gallowaye Gallowey Galoway Galowey Gannochan Garmory Garmurie Garmury Garro Garroch Garrow Garvey Garvie Gass Gehan Gemilson Gemilston George Germory Germurie Gerrand Gerrond Gerrow Ghie Gillilan Gilliland Gimpsie Gimpsy Glendinning Gorthrick Guffock Gugan Gulline Gunion Gunnion Gunnyon Gurran Habbishaw Haddow Hadow Haffie Hairhill Hairstains Hairstanes Halbert Halbertson Hallam Hallum Halthoirne Halthorn Halthorne Hance Handley Hannan Harestains Harestanes Harg Haslop Hastan Hasten Haston Hathorn Hathorne Haulthorne Hauthorn Hauthorne Hawthorn Hawthorne Herbertson Herbieson Herbison Heron Heughan Hillow Holliday Hollins Howatson Howitson Hughan Iterson Jellie Jelly Jollie Jolly Jore Jorie Kean Keand Keane Keenan Keene Kells Kelton Kelvey Kelvie Kene Kenna Kennan Kenney Keron Kerron Kettridge Kevan Kildonan Killock Kingan Kinhilt Kinna Kinniburgh Kinzean Kirkconnell Kirkcudbright Kirkdale Kirkhoe Kirkwood Kniblo Lachlanson Lachlieson Lagg Landsborough Landsburgh Laucht Lewars Lidderdale Limond Limont Lusk Maben Mabie MacAbin MacAfee MacAffie MacAlach MacAlear MacAlinden MacAlinton MacAndlish MacAnn MacArtnay MacArtney MacAskie MacAughtrie MacAughtry MacAull MacAvery MacAvoy MacBerkny MacBertny MacBirney MacBirnie MacBirtny MacBlain MacBlane MacBrair MacBraire MacBraten MacBratney MacBratnie MacBreck MacBrennan MacBretnach MacBretney MacBretnie MacBretny MacBriar MacBroom MacBryne MacBurney MacBurnie MacByrne MacCaa MacCadu MacCaffe MacCaffie MacCalmont MacCalvine MacCalvyn MacCambil MacCammell MacCammon MacCammond MacCamon MacCance MacCanch MacCanchie MacCandlish MacCanse MacCardney MacCargo MacCarnochan MacCarson MacCartnay MacCartney MacCaskie MacCaskin MacCathail MacCathay MacCathie MacCathy MacCaughtrie MacCaughtry MacCavat MacCavell MacChaffie MacChesney MacCheyne MacChord MacChristian MacChristie MacChristy MacChrystal MacChullach MacClacherty MacClamroch MacClanachan MacClanaghan MacClanahan MacClanaquhen MacClannachan MacClannochan MacClannochane MacClannoquhen MacClanochan MacClanochane MacClanohan MacClanoquhen MacClansburgh MacClatchie MacClatchy MacClave MacCleave MacCleche MacClees MacCleiche MacCleisch MacCleish MacCleishe MacCleisich MacClenachan MacClenaghan MacClenaghen MacClenahan MacCleneghan MacClenighan MacClennaghan MacClennochan MacClennoquhan MacClennoquhen MacClenoquhan MacCleve MacCleys MacCliesh MacClingan MacClinie MacClinighan MacClinnie MacClinton MacClonachan MacClone MacCloo MacCloor MacClory MacCloskey MacClour MacCluir MacCluire MacClullich MacClumpha MacClung MacClunochen MacClure MacCluskey MacCluskie MacClusky MacClymond MacClymont MacCoard MacColeis MacColleis MacColloch MacColly MacColm MacColmain MacColman MacColme MacComb MacCombe MacCome MacComiskey MacCord MacCormack MacCormaic MacCormaig MacCormick MacCormock MacCormok MacCornack MacCornick MacCornock MacCornok MacCosker MacCoskery MacCoskrie MacCoskry MacCoubray MacCoubrey MacCoubrie MacCoulach MacCoulagh MacCoulaghe MacCourt MacCowlach MacCrabit MacCraccan MacCrach MacCrachan MacCrachen MacCrackan MacCracken MacCrae MacCraich MacCraie MacCraikane MacCraith MacCraken MacCrea MacCreaddie MacCreadie MacCreary MacCreath MacCreddan MacCredie MacCree MacCreerie MacCreery MacCreigh MacCreight MacCreire MacCreirie MacCreith MacCrekan MacCrekane MacCrendill MacCrenild MacCreory MacCrerie MacCrery MacCrie MacCrindell MacCrindill MacCrindle MacCrire MacCririck MacCririe MacCristal MacCriste MacCristie MacCristin MacCristine MacCrokane MacCron MacCrone MacCroskie MacCrossan MacCrundle MacCrunnell MacCryndill MacCryndle MacCrynell MacCrynill MacCrynnell MacCrynnill MacCuabain MacCubben MacCubbin MacCubbine MacCubbing MacCubbon MacCubein MacCubeine MacCuben MacCubene MacCubine MacCubyn MacCubyne MacCucheon MacCudden MacCudie MacCue MacCuffie MacCuimrid MacCullach MacCullagh MacCullaghe MacCullaigh MacCullan MacCullauch MacCullen MacCullie MacCullin MacCullo MacCulloch MacCullocht MacCullogh MacCulloh MacCullough MacCully MacCune MacCunn MacCure MacCusker MacCutchan MacCutchen MacCutcheon MacCutchion MacCutheon MacCwne MacDearmid MacDearmont MacDermaid MacDermand MacDerment MacDermid MacDermont MacDermot MacDermott MacDill MacDole MacDoll MacDonart MacDool MacDoual MacDouall MacDouell MacDoul MacDouwille MacDouyl MacDovall MacDovele MacDoville MacDovylle MacDowal MacDowale MacDowall MacDowalle MacDowele MacDowell MacDowelle MacDowile MacDowille MacDowilt MacDowll MacDowylle MacDoyle MacDual MacDuall MacDuel MacDuhile MacDule MacDull MacDuoel MacDuwell MacDuwyl MacEletyn MacElligatt MacElroy MacEtterick MacEttrick MacEuer MacEuir MacEur MacEure MacEvoy MacFadden MacFade MacFadin MacFadion MacFagan MacFaid MacFead MacFeat MacFeate MacFedrice MacFegan MacFetridge MacFrederick MacFrizzel MacFrizzell MacFrizzle MacGaa MacGaa MacGachey MacGachie MacGannet MacGarmorie MacGarmory MacGarva MacGarvey MacGarvie MacGauchan MacGauchane MacGauchin MacGaughrin MacGaugie MacGaukie MacGavin MacGaw MacGaychin MacGe MacGeachan MacGeachen MacGeachie MacGeachin MacGeachy MacGeaghy MacGeak MacGechan MacGechie MacGee MacGeechan MacGehee MacGeoch MacGeorge MacGeouch MacGermorie MacGeth MacGethe MacGeuchie MacGey MacGhee MacGhey MacGhie MacGhye MacGie MacGigh MacGilbothan MacGilfud MacGill MacGillecongall MacGillvane MacGilnew MacGilvane MacGilvar MacGilveil MacGilvernock MacGilweane MacGimpsie MacGimpsy MacGinnis MacGirr MacGivern MacGladrie MacGledrie MacGlenaghan MacGlew MacGlone MacGoldrick MacGomerie MacGomery MacGorlick MacGougan MacGrain MacGranahan MacGrane MacGreen MacGrindal MacGroary MacGrory MacGrundle MacGrury MacGubb MacGuckin MacGuffey MacGuffie MacGuffoc MacGuffock MacGuffog MacGugan MacGuigan MacGunnion MacGuoga MacGy MacGye MacHaffey MacHaffie MacHaffine MacHans MacHarg MacHarrie MacHarry MacHarvie MacHay MacHee MacHgie MacHilmane MacHnight MacHoul MacHoule MacHowell MacHucheon MacHucheoun MacHuitcheon MacHulagh MacHullie MacHutchen MacHutcheon MacHutchin MacHutchon MacHutchoun MacIlduf MacIlduff MacIlhaffie MacIlhagga MacIlhauch MacIlhaugh MacIlhench MacIllrick MacIllvain MacIllveyan MacIlmeine MacIlmeyne MacIlmorie MacIlmorrow MacIlna MacIlnae MacIlnaey MacIlneive MacIlnew MacIloure MacIlraich MacIlraith MacIlravey MacIlravie MacIlreach MacIlreath MacIlreave MacIlrevie MacIlriach MacIlrith MacIlrivich MacIlroy MacIlroych MacIluraick MacIlvain MacIlvaine MacIlvane MacIlvar MacIlvayne MacIlvean MacIlveane MacIlveen MacIlvernock MacIlvian MacIlwain MacIlwaine MacIlweine MacIlwhannel MacIlwraith MacIlwraithe MacIlwrathe MacIlwrick MacIlwrith MacInstray MacInstrie MacInstry MacJanet MacJannet MacJarrow MacJerrow MacJiltroch MacK MacKculloch MacKdowall MacKe MacKeachan MacKeachie MacKeachy MacKean MacKeand MacKee MacKeenan MacKelly MacKelvain MacKelvey MacKelvie MacKena MacKeney MacKenie MacKenna MacKennah MacKennan MacKennane MacKennay MacKenney MacKeon MacKeowan MacKeown MacKeracken MacKern MacKerrin MacKerron MacKerrow MacKetterick MacKettrick MacKewan MacKewin MacKewn MacKey MacKghie MacKie MacKilhaffy MacKill MacKille MacKilmurray MacKilvain MacKilvane MacKilven MacKilvie MacKilwein MacKilweyan MacKilwyan MacKindle MacKinna MacKinnay MacKinney MacKinnie MacKinstay MacKinstrey MacKinstrie MacKinstry MacKirsty MacKitterick MacKittrick MacKlanachen MacKlemurray MacKlewain MacKluire MacKmorran MacKmurrie MacKnach MacKnacht MacKnae MacKnaight MacKnaught MacKnawcht MacKnaycht MacKnayt MacKne MacKneach MacKnee MacKneicht MacKneis MacKneische MacKneishe MacKness MacKnicht MacKnie MacKnight MacKnish MacKnitt MacKoen MacKoun MacKowean MacKowen MacKowie MacKowin MacKowloch MacKowloche MacKowne MacKownne MacKowyne MacKrachin MacKraken MacKrekane MacKrenald MacKrenele MacKuen MacKuenn MacKuffie MacKukan MacKulagh MacKullie MacKulloch MacKullouch MacKune MacKwhinney MacKy MacKye MacKynnell MacKyrnele MacLamroch MacLanachan MacLanaghan MacLanaghen MacLandsborough MacLannachen MacLanochen MacLanoquhen MacLatchie MacLatchy MacLauchrie MacLeannaghain MacLees MacLeesh MacLeich MacLeish MacLenaghan MacLenechen MacLenochan MacLeroy MacLese MacLess MacLetchie MacLeur MacLewain MacLin MacLinden MacLise MacLish MacLiss MacLockie MacLokie MacLoon MacLoor MacLuir MacLulaghe MacLulaich MacLulich MacLulli MacLullich MacLullick MacLumfa MacLumpha MacLung MacLur MacLure MacLurg MacLuskey MacLuskie MacLusky MacLwannell MacLwhannel MacLyn MacLyndon MacManamy MacManaway MacMarten MacMartin MacMartun MacMartyne MacMaster MacMeechan MacMeekan MacMeeken MacMeekin MacMeeking MacMeikan MacMenamie MacMenamin MacMenemie MacMenemy MacMenigall MacMertein MacMertene MacMertin MacMichan MacMickan MacMicken MacMickin MacMicking MacMikan MacMiken MacMonagle MacMoran MacMorane MacMoreland MacMoren MacMorin MacMorine MacMorland MacMorran MacMorrane MacMorrin MacMoryn MacMoryne MacMulron MacMunagle MacMunn MacMurd MacMurdo MacMurdy MacMurray MacMurre MacMurree MacMurrie MacMurrin MacMurry MacMurrye MacMury MacMyn MacMyne MacMynneis MacNacht MacNae MacNaght MacNaicht MacNaight MacNairn MacNait MacNarin MacNatt MacNauch MacNauche MacNaught MacNauth MacNay MacNea MacNee MacNeelie MacNees MacNeice MacNeid MacNeigh MacNeight MacNeillie MacNeilly MacNeis MacNeische MacNeish MacNeiss MacNeit MacNelly MacNely MacNesche MacNess MacNett MacNey MacNicht MacNie MacNielie MacNiff MacNight MacNillie MacNily MacNische MacNish MacNitt MacNoah MacNoaise MacNutt MacNysche MacObyn MacOloghe MacOnee MacOulie MacOwlache MacQuaben MacQualter MacQuater MacQuatter MacQuay MacQue MacQuee MacQueeban MacQuey MacQuhae MacQuhalter MacQuhannil MacQuhirr MacQuie MacQuikan MacQuiltroch MacReadie MacReady MacReary MacRedie MacReirie MacRerie MacRie MacRindle MacRinnell MacRinnyl MacRiridh MacRirie MacRone MacRowat MacRowatt MacRynald MacRynall MacRyndill MacRynell MacRynild MacScamble MacScilling MacSkellie MacSkelly MacSkimming MacSloy MacSwigan MacSwiggan MacTaldrach MacTaldridge MacTaldroch MacTurk MacUaltair MacUbein MacUbin MacUbine MacUlagh MacUlaghe MacUllie MacUlloch MacVannel MacVater MacVennie MacVinie MacVinnie MacVitie MacVittae MacVittie MacWalter MacWaltir MacWater MacWattir MacWeeny MacWha MacWhae MacWhan MacWhaneall MacWhanell MacWhanle MacWhannall MacWhanne MacWhannel MacWhannell MacWhannil MacWhanrall MacWhin MacWhinn MacWhinney MacWhinnie MacWhir MacWhire MacWhirr MacWhirrie MacWhonnell MacWhunye MacWhy MacWhynie MacWiggan MacWinney MacYlveine Madole Magall Magee Mageth Magy Mahaddie Mahaffey Mahaffie Mahalfie Maickie Makcluir Makcoulach Makcowllach Makcowloch Makcrakan Makcrakane Makcraken Makcrire Makcrunnell Makcubeyn Makcubyn Makcubyng Makcullo Makculloch Makcullocht Makdowale Makdowelle Makdull Makee Makenaght Makgachane Makgachyn Makgarmory Makge Makgee Makgeouch Makgey Makghe Makghie Makgie Makgilvane Makgy Makgye Makhuchone Makhulagh Makie Makilmain Makilmeyn Makilvane Makilvene Makilwene Makilwyane Makintalgart Makke Makkee Makkey Makkie Makknacht Makknaicht Maklure Makmorane Maknath Maknauch Maknaucht Maknech Maknee Makneis Makneisch Makneische Makneiss Makneissche Maknes Maknish Makrinnyl Makririe Makrunnell Makrynnild Makrynyll Makwatter Makwir Maky Malcowlach Masterson Mawhinney Mawhinnie Maydole Megall Meikleman Melveen Melven Melvin Melving Melvyne Melwene Melwin Melwyn Merrick Merricks Mewhinney Mibbie Milhaffie Milhench Millican Milligan Milliken Millikin Milroy Milvain Milwain Milwee Minn Monfode Monreith Morin Morran Morren Morrin Morthland Moslie Mouncey Mouncie Mounsie Mullikin Mulmurray Mulmury Munches Mundell Murren Naische Naish Naos Neal Neale Neasch Neason Neeson Neil Neill Neilly Neis Neische Neish Neison Neisson Nes Nesche Ness Nessan Netherwood Neuall Newall Nies Niesh Nish Noe Pagan Palloch Parton Paulin Pirie Pirieson Piriesoun Pirrie Polmallet Pottie Purse Purton Quentin Quintin Rae Railton Rain Ralton Rasper Reachton Reochtan Rerik Rerrick Revie Rigg Roddy Rodgerson Rome Roney Ronnay Rowat Rowatt Rowet Rowett Sanchar Sanquhar Selbach Shank Shankland Shanklin Shanks Shannan Shannon Sharper Sharpraw Shennan Shennane Sitlington Skellie Skelly Skilling Skimming Sloan Sloane Sorbie Sorby Southwick Sproat Sprot Sprott Sprout Staffein Stobhill Stow Strawhorn Stroyan Studgeon Sturgeon Syar Syer Tagart Taggart Taggert Tegart Teggart Thorbrand Thorburn Thurbrand Thurburn Torbain Torbane Trustrie Twynholm Ur Urr Vans Warplay Wateret Watret Whandle Whannel Whannell Whitewright Whonnell Winning Wither Yates

Gammell
Clan History: http://electricscotland.com/webclans/dtog/gemmell.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1383
Associated Names and Septs (with spelling variations):
Gammell

Gayre
Clan History: http://electricscotland.com/webclans/dtog/gair.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=165
Associated Names and Septs (with spelling variations):
Angear Gair Gaire Gar Gayer Gayr Gayre Gear Ger Gere Ghiorr Gyre

Gibbs
Clan History: http://electricscotland.com/webclans/dtog/gibsone.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1431
Associated Names and Septs (with spelling variations):
Gibb

Gillies
Clan History: http://electricscotland.com/webclans/dtog/gillies.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=168
Associated Names and Septs (with spelling variations):
Gellas Gilies Gilise Gillas Gilleis Gilles Gillice Gillie Gillies Gilliosa Gillis Gillise Gilliss Gylis Gyllis MacGillas MacGilleis MacGillese MacGillies MacGillis MacGillish MacHillies

Gladstone
Clan History: http://electricscotland.com/webclans/dtog/gladstaines.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=169
Associated Names and Septs (with spelling variations):
Gladistane Gladstain Gladston Gladstone Gladstones Gladtsten Glaidstoun Glaidstounes Gledstain Gledstaines Gledstains Gledstan Gledstand Gledstane Gledstanes Gledstanis Gledstone Glestanis

Gordon
Clan History: http://electricscotland.com/webclans/dtog/gordon.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=173
Associated Names and Septs (with spelling variations):
Abergeldie Achenson Acheson Achesone Achesoun Achesoune Achesune Achieson Achiesoun Achinsoun Achisone Achisoune Ackin Ackyn Ackyne Adam Adams Adamson Adamsone Addesoun Addie Addison Addy Ade Ademson Ademsoun Ademsoune Adeson Adesone Adesoun Adie Adies Adieson Adiesone Adiesoun Adison Adisoun Ady Adye Adyson Aedie Aedieson Aichensoun Aicheson Aichesone Aicken Aickin Aickine Aicking Aiddie Aidie Aidy Aidye Aikein Aiken Aikeyne Aikin Aikine Aiking Aikne Aikun Aikyne Aitcheson Aitchesoun Aitchesoune Aitchison Aitchysoune Aitcken Aithchinson Aitkane Aitken Aitkene Aitkin Aitkine Aitkins Aitkyn Aitkyne Aken Akene Akin Akine Akyne Aschesone Atchesone Atchison Atchisone Aticione Atken Atkin Atkine Atkins Atkinson Atknson Atkyn Atkynson Atkynsoun Attkinsone Atyesoun Atzensone Atzeson Atzinson Aukin Aydeson Aykkyne Aytkine Aytkyn Aytkyne Barrie Barry Colen Coleyn Connan Connen Connon Connor Crom Cromb Crombie Crommie Cromy Croume Crum Crumbie Crummy Culane Cullane Cullen Darg Darge Dargie Eadie Eakin Eakins Echesone Eckin Eddie Edie Edison Edisone Edisoun Esselmont Essilmounthe Esslemont Eticione Etzesone Gairdner Gardenar Gardenare Gardener Gardennar Gardinar Gardinare Gardiner Gardnar Gardnard Gardnare Gardner Gardynar Gardynnyr Geddas Geddeis Geddes Geddess Geddis Gedes Gesmond Giddes Gordon Gordun Huntley Huntlie Huntly Jaap Jaip Jap Jape Japp Jappie Jappy Jasemond Jassimine Jessamine Jesseman Jessemond Jessieman Jessiman Jessimen Jessyman Joip Jop Jopp Jupe Jupp Juppe Juppie Larrie Laurence Laurie Laurri Laury Lawrence Lawrie Lawry Lowrey Lowrie MacAdaim MacAdam MacAdame MacAddam MacAddame MacCadam MacCadame MacCaddam MacCaddame MacCaddim MacKadam MacKadem Makadam Makadame Makadem Makcaddam Mill Millan Millen Millin Milln Mills Miln Milne Milner Milnes Mkkadam Morice Morrice Morris Mylen Myll Myln Mylnar Mylne Tod Todd Todde Tode Tood Yape Yeap Yep

Gow
Clan History: http://electricscotland.com/webclans/dtog/gow.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=180
Associated Names and Septs (with spelling variations):
Gove Gow Gowan Gowans Gowanson Gowen Gowie Gowin MacGabhawn MacGhobhainn MacGhowin MacGouan MacGoun MacGoune MacGovin MacGow MacGowan MacGowen MacGown MacGowne MacGowy Makghobhainn Makgowane Makgowin Smeayth Smith Smyith Smyithe Smyth Smythe

Graham
Clan History: http://electricscotland.com/webclans/dtog/graham.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=182
Associated Names and Septs (with spelling variations):
Airth Auchinloick Ballewen Blair Buchlyrie Conyers Drumaguhassle Duchray Dugalston Esbank Glenny Graem Graeme Graham Grahame Grahem Graheme Grahm Grahme Grahym Graiham Gram Grame Graym Grayme Greeme Grehme Grem Greme Greym Greyme Grim Grime Grimes Grimm Gruamach Grym Hadden Haldane Lingo MacCrime MacGibbon MacGilvern MacGilvernoel MacGrime MacIlvern MacShille Monzie Pitcairn Pyott Rednock Regent Sirowan Sterling

Graham Of Menteith
Clan History: http://electricscotland.com/webclans/dtog/graham.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=184
Associated Names and Septs (with spelling variations):
Alderdice Alerdes Alerdice Alerdyce Alirdes Allardes Allardice Allardyce Allerdais Allerdas Allerdes Allirdas Allirdasse Allirdes Allyrdas Allyrdes Alyrdes Ardes Bontein Bontine Bontyne Bountene Buntain Bunten Buntene Bunteyne Buntin Buntine Bunting Bunton Buntyn Buntyne Buntyng Buntynge Dog Doig Graem Graeme Graham Grahame Grahem Graheme Grahm Grahme Grahym Graiham Gram Grame Graym Grayme Greeme Grehme Grem Greme Greym Greyme Grim Grime Grimm Grym MacCrime MacCurtain MacGilvernock MacGrime MacKeurtain Manteeth Mentayth Menteath Menteith Mentheth Monteath Montecht Monteith Munteith Muntethe Mynteith Mynteth Myntethe

Graham Of Montrose
Clan History: http://electricscotland.com/webclans/dtog/graham.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=183
Associated Names and Septs (with spelling variations):
Bonar Bonnar Montrose

Grant
Clan History: http://electricscotland.com/webclans/dtog/grant.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=189
Associated Names and Septs (with spelling variations):
Achnach Auchindachie Ballindalloch Chiaran Ciaran Gilderoy Gilray Gilroy Gilry Grant Grantt Graunt Graunte MacElheran MacElherran MacElroy MacGilrey MacGilroy MacGilroye MacIlheran MacIlherran MacIllory MacIlrie MacIlroy MacKeleran MacKern MacKerrin MacKerron MacKiaran MacKiarran MacKilrae MacKilrea MacKilroy MacKleroy MacLeroy MacLroy MacOulroy MacQuorn MacQuorne MacYlroy MacYlroye Makcoran Makgilroy Makilrow Makquorne Meikleroy Micklroy Milroy

Gray
Clan History: http://electricscotland.com/webclans/dtog/gray.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1390
Associated Names and Septs (with spelling variations):
Gray Grey

Gunn
Clan History: http://electricscotland.com/webclans/dtog/gunn.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=193
Associated Names and Septs (with spelling variations):
Cain Eanrig Eanruig Enrick Enrig Gailey Galdie Galie Gallach Gallaich Gallie Galloch Gally Galy Ganson Gaudie Gauldie Gaunson Gawenson Gawensone Gawieson Gelie Gely Georgeson Georgesone Gills Gollach Gun Gunn Gunni Henderson Hendersone Hendersonne Hendersoun Hendersoune Hendery Hendirsone Hendirsoune Hendrie Hendrisoune Hendry Henersoun Hennersoune Hennryson Henresoun Henreysoun Henriesoun Henrison Henrisone Henrisoun Henrisoune Henry Henryesson Henryson Henrysoun Inrick Inrig Jameson Jamesone Jamesoune Jamieson Jamison Jamisone Jamyson Jamysone Jemison Jeorgison Johnesson Johnnessone Johnson Joneson Jonesson Jonessone Jonson Jonsone Jonsoun Kean Keand Keane Keene Kendrick Kene Kenrick MacAin MacAne MacCanrig MacCanrik MacCayne MacColly MacCorkell MacCorkil MacCorkill MacCorkle MacCuilam MacCuley MacCulliam MacCulzian MacEan MacEane MacEanruig MacEnrick MacEoin MacHamish MacHendric MacHendrie MacHendry MacHenish MacHenrie MacHenrik MacHenry MacIain MacIan MacIlmanus MacJames MacJamis MacKain MacKames MacKane MacKanrig MacKeamish MacKean MacKeand MacKein MacKendric MacKendrich MacKendrick MacKendrie MacKendrig MacKendry MacKenrick MacKilliam MacKjames MacKwilliam MacMaghnuis MacMagnus MacMain MacMaines MacMainess MacMains MacMan MacManes MacManis MacMann MacMannas MacMannes MacMannus MacManus MacMayne MacMhannis MacQuilliam MacRob MacRobb MacRobe MacSwanney MacUilam MacUilleim MacVillie MacWilliam MacWilliame MacWilliams MacWillie MacWyllie Magniss Magnus Magnuss Magnusson Magnussonn Main Mainn Mainsoun Makane Makanry Makayn Makcane Makcayne Makean Makhenry Makkane Makkean Makrob Makwilliam Makwillie Man Mane Mann Mansioun Manson Mansone Mansoun Mansson Manssoun Manus Maunsone Maunusone Mayne Monson Neelson Neillsone Neilson Neilsone Neilsoun Neilsoune Neleson Nelesoun Nelson Nelsone Nelsonne Nelsoun Neylsone Nielson Nilson Nilsone Nilsoune Nylson Robeson Robesoun Robinson Robison Robisone Robson Robsone Sandeson Sandesone Sandesoun Sandesoune Sandesounn Sandie Sandiesoune Sandison Sandy Swainson Swaneson Swanie Swannay Swanne Swanney Swannie Swanson Villsone Vilsone Vilsoun Vylsone Wiley Willameson Willeamsoun Willesoun Williamson Williamsone Willie Willson Willsone Willsoun Willyamsone Wilsoine Wilson Wilsone Wilsoun Wilsoune Wilsowne Wily Wilyamson Wilyemsoun Wolson Wolsoun Wulson Wulsone Wyleson Wylie Wyllie Wylly Wyllyamson Wylson Wylsoune Wyly Wylye

Guthrie
Clan History: http://electricscotland.com/webclans/dtog/guthrie.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=196
Associated Names and Septs (with spelling variations):
Gotheray Gothra Gothraw Gothray Gotrae Gotray Gotraye Gotrey Gotthra Gottrae Gottray Gottraye Gottre Guthere Gutherie Gutherye Guthre Guthree Guthrie Guthry Guthrye Gutrae Guttere Guttraw Guttre Hawkins

H
Haig
Clan History: http://electricscotland.com/webclans/htol/haig.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=197
Associated Names and Septs (with spelling variations):
Hage Haghe Haig Haigh


Haldane
Clan History: http://electricscotland.com/webclans/htol/haldane.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=-1289065989
Associated Names and Septs (with spelling variations):
Haldane

Hall
Clan History: http://electricscotland.com/webclans/htol/hall.htm
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1392
Associated Names and Septs (with spelling variations):
Hall

Hamilton
Clan History: http://electricscotland.com/webclans/htol/hamilto.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=198
Associated Names and Septs (with spelling variations):
Cadzow Hamilton Hammeltoune Hammyltoun Hammyltoune Hamulthone Hamyltone Hamyltoune

Hannay
Clan History: http://electricscotland.com/webclans/htol/hannay.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=199
Associated Names and Septs (with spelling variations):
Ahannay Ahanney Hanay Hanna Hannah Hannay Hannaye

Harkness
Clan History: http://electricscotland.com/webclans/htol/harkness.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=200
Associated Names and Septs (with spelling variations):
Harkess Harkness Harkniss Herkenesse Herkness

Hay
Clan History: http://electricscotland.com/webclans/htol/hay.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=202
Associated Names and Septs (with spelling variations):
Alderston Arral Arrel Arrell Arrol Arroll Aue Ave Ay Aye Ayer Beagrie Constable Dalgetty Dalgety Dalgitty Dalgity De Plessis Delgatie Delgattie Delgatty Delgaty Delgety Dellahay Drumelizior Dupplin Errol Errole Erroll Garra Garrad Garrow Geij Gifford Hawson Hay Haya Haya Hayburn Hayden Haye Hayens Hayes Hayfield Hayhoe Hayhow Haylees Haylor Hayne Haynes Haynie Hays Hayse Hayson Hayston Haystoun Hayter Hayton Hayward Haywood Hea Hej Hey Heys Kellour Kinnoull Laisk Lask Laske Laski Laxfirth Laysk Leask Leaske Leish Leisk Leith Lesk Lesque Lisk Lockerwort Louask Lowask Lowsk MacArra MacGaradh MacGarra MacGarrow MacHay O'Garrow O'Hay Peebles Peoples Slains Turriff Tweeddale Yester

Hay & Leith
Clan History: http://electricscotland.com/webclans/htol/hay.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=204
Associated Names and Septs (with spelling variations):
Leish Leith Leithe Leth Lethe Leyth Leythe

Henderson
Clan History: http://electricscotland.com/webclans/htol/henders.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=206
Associated Names and Septs (with spelling variations):
Eanrig Eanruig Enderson Endherson Endirsone Enrick Enrig Henderson Hendersone Hendersonne Hendersoun Hendersoune Hendery Hendirsone Hendirsoune Hendrie Hendrisoune Hendry Henersoun Hennersoune Hennryson Henresoun Henreysoun Henriesoun Henrison Henrisone Henrisoun Henrisoune Henry Henryesson Henryson Henrysoun Inrick Inrig Kendrick Kenrick MacCanrig MacCanrik MacEanruig MacEnrick MacHendric MacHendrie MacHendry MacHenrie MacHenrik MacHenry MacKanrig MacKendric MacKendrich MacKendrick MacKendrie MacKendrig MacKendry MacKenrick Makanry Makhenry

Hepburn
Clan History: http://electricscotland.com/webclans/htol/hepburn.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=208
Associated Names and Septs (with spelling variations):
Adinston Hapburn Hebbourn Hebburn Hepburn Hepburne Hopburn

Herd
Clan History: http://electricscotland.com/webclans/htol/herd.htm
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1393
Associated Names and Septs (with spelling variations):
Herd

Home
Clan History: http://electricscotland.com/webclans/htol/home.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=209
Associated Names and Septs (with spelling variations):
Aiton Ayton Aytoun Hewme Hom Home Hoom Hoome Houm Houme Hum Hume Huym MacK

Hope-Vere
Clan History: http://electricscotland.com/webclans/htol/hope.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=897
Associated Names and Septs (with spelling variations):
Hope Vere Hope-Vere

Hunter
Clan History: http://electricscotland.com/webclans/htol/hunter.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=694
Associated Names and Septs (with spelling variations):
Hunt Huntair Huntar Huntayr Hunter Huntere Huntres Huntter

Hunter Of Hunterston
Clan History: http://electricscotland.com/webclans/htol/hunter.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=211
Associated Names and Septs (with spelling variations):
Hunt Huntair Huntar Huntayr Hunter Huntere Hunterston Huntres Huntter Hwtar

I
Inglis
Clan History: http://electricscotland.com/webclans/htol/Inglis.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=212
Associated Names and Septs (with spelling variations):
Englis Ingalls Ingals Ingles Inglis


Innes
Clan History: http://electricscotland.com/webclans/htol/Innes.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=213
Associated Names and Septs (with spelling variations):
Dinnes Duness Dynnes Ennis Inays Ince Inees Ineess Ineys Innes Innice Innie Innis MacRob MacRobb MacRobe MacTary Makrob Markoke Marnach Marnagh Marno Marnoch Marnoche Marnock Marnoe Marnoh Maver Mavers Mavor Mawar Mawer Mechel Mediltoune Meitchel Mernath Michell Michill Middleton Mideltowne Midilton Midiltoun Midtoun Mitchell Mitchol Mitschael Mitsschal Mittchel Mychell Myddiltoun Myddiltoune Mydilton Mytchell Redford Reidfurd Tayne Thain Thaine Thane Thayn Thayne Theyne Villsone Vilsone Vilsoun Vylsone Wiley Willesoun Willie Willson Willsone Willsoun Wilsoine Wilson Wilsone Wilsoun Wilsoune Wilsowne Wily Wolson Wolsoun Wulson Wulsone Wyleson Wylie Wyllie Wylly Wylson Wylsoune Wyly Wylye

Irvine
Clan History: http://electricscotland.com/webclans/htol/Irvine.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=217
Associated Names and Septs (with spelling variations):
Eirryn Erevein Erewine Ervine Erwin Erwine Erwing Erwinne Erwyn Erwyne Herwynd Herwyne Hurven Irewing Irewyne Irrewin Irrewine Irrewing Irruwing Irrwin Irrwing Iruin Iruwyn Iruyn Iruyne Irvein Irveing Irveyn Irvin Irvine Irving Irvinge Irvinn Irvying Irvyn Irwan Irwen Irwin Irwine Irwing Irwyn Irwyne Irwyng Irwynn MacIrvine Urwen Urwin Urwing Urwyng Yrwin Yrwing

Irving Of Glentulchan
Clan History: http://electricscotland.com/webclans/htol/Irvine.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1173
Associated Names and Septs (with spelling variations):
Glentulcan

J
Jardine
Clan History: http://electricscotland.com/webclans/htol/jardine.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=218
Associated Names and Septs (with spelling variations):
Gairdner Garden Gardenar Gardenare Gardener Gardennar Gardin Gardinar Gardinare Gardiner Gardino Gardinus Gardnar Gardnard Gardnare Gardner Gardynar Gardynnyr Gerdain Gerden Jardane Jarden Jardin Jardine Jarding Jardyn Jardyne Jerden Jerdone


Johnstone
Clan History: http://electricscotland.com/webclans/htol/johnsto.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=220
Associated Names and Septs (with spelling variations):
Johanstoun Johnestoun Johnestowne Johngston Johnnestoun Johnnstoune Johnston Johnstone Johnstoun Johnstounne Joneston Joniston Jonstoun Lockerbie Lockerby Rome

K
Keith
Clan History: http://electricscotland.com/webclans/htol/keith.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=221
Associated Names and Septs (with spelling variations):
Austeane Austein Austene Austin Austine Austyn Caidh Cate Ceiteach Chaney Chayne Cheen Chein Cheine Chene Cheney Chesne Cheyne Cheyney Chiene Chisnie Chyine Chyne Dick Dickason Dickeson Dickie Dickison Dickson Dicsoun Dikiesoun Dikkyson Dikson Diksonne Dikyson Dixon Kayt Keathe Keht Keith Ket Keth Kethe Keyth Keythe Keytht Kite Marchael Marchall Marchell Marschal Marschale Marschel Marschell Marshall Merchel Merchell Merschaell Merschale Merschell Mershael Mershell Oisteane Oistiane Ostaine Ostian Ostien Ousteane Oustene Oustian Oustiane Oustine Owstiane Owstine


Kennedy
Clan History: http://electricscotland.com/webclans/htol/kennedy.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=222
Associated Names and Septs (with spelling variations):
Canedie Carric Carrick Carrik Carryk Cassellis Cassells Cassels Cassilis Cassillis Cassils Holmes Kanide Kanydi Karrick Karryc Kenadie Kenede Kenedy Keneidy Kenide Kennadee Kennatie Kennaty Kennedi Kennedy Kennedye Kennetie Kennety Kennide Kennyde Kennydy Kenyde Kinnedi Kinydy Kyneidy Kynidy MacCualraig MacCuaraig MacOlrig MacOulric MacOurlic MacUalraig MacUaraig MacUlric MacUlrich MacUlrick MacUlrig MacWalrick Makoolrik

Kerr
Clan History: http://electricscotland.com/webclans/htol/kerr.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=223
Associated Names and Septs (with spelling variations):
Car Carr Carrach Carre Cearr Cer Kar Kare Karr Karre Kaurr Kayr Keire Ker Kere Kerr Kerre Keyr Kier

Kidd
Clan History: http://electricscotland.com/webclans/htol/kidd.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=227
Associated Names and Septs (with spelling variations):
Kid Kidd Kydd

Kilgour
Clan History: http://electricscotland.com/webclans/htol/kilgour.htm
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=228
Associated Names and Septs (with spelling variations):
Kilgour

Kincaid
Clan History: http://electricscotland.com/webclans/htol/kincaid.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=229
Associated Names and Septs (with spelling variations):
Kincaid Kinkaid Kinkead Kinkid Kyncade Kyncaid Kyncaide Kyncayd Kynkad Kynked

Kinnear
Clan History: http://electricscotland.com/webclans/htol/kinnear.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1397
Associated Names and Septs (with spelling variations):
Kinnear

L
Laing
Clan History: http://electricscotland.com/webclans/ctol/laing.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=657
Associated Names and Septs (with spelling variations):
Aicken Aitcken Aitkane Aitken Aitkene Aitkin Aitkine Aitkyn Aitkyne Atken Atkin Atkine Atkyn Aytkine Aytkyn Aytkyne Laing


Lamont
Clan History: http://electricscotland.com/webclans/htol/lamont.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=230
Associated Names and Septs (with spelling variations):
Blac Black Blacke Blackie Blaick Blaik Blaike Blaikey Blaikie Blak Blake Blayk Bourdon Braun Bron Brouin Broun Broune Brown Browne Browyn Brun Brune Brwne Burden Burdon Burdone Burdoun Burdun Clement Clements Clucas Douie Dowie Dowy Fetridge Gildawie Gildowie Gilduff Gilfeather Gilfedder Gilledow Gilleduff Gillegowie Gilpedder Huie Lam Lamb Lambe Lambi Lambie Lamby Lamie Lamme Lammie Lamond Lamondson Lamonson Lamont Landass Landers Landes Landess Landis Laumanson Lawmanson Lawmondson Lemmon Lemmont Lemond Leuches Limond Limont Louk Louke Lucas Luches Luck Luckie Luckieson Luik Luke MacAldowie MacAldowrie MacAldowy MacAlduie MacClaman MacClamon MacClement MacClements MacClemont MacCliments MacClimont MacClucas MacClugash MacClugass MacClugeis MacClymond MacClymont MacElduff MacFaddrik MacFadrick MacFaid MacFater MacFather MacFatridge MacFeaters MacFederan MacFedran MacFeeters MacFetridge MacGildhui MacGilduff MacGildui MacGilevie MacGilewe MacGilfatrick MacGilfatrik MacGilladubh MacGilldowie MacGilledow MacGilleduf MacGilleduibh MacGillefatrik MacGillefedder MacGillegowie MacGillepartik MacGillepatrick MacGillepatrik MacGillephadrick MacGillephadruig MacGillewe MacGillewey MacGillewhome MacGillewie MacGillewy MacGillewye MacGilliduffi MacGilliewie MacGillifudricke MacGilligowie MacGilligowy MacGilliphatrick MacGilliquhome MacGilliue MacGilliwie MacGillogowy MacGillphatrik MacGilparick MacGilphadrick MacGilpharick MacGilvie MacGlugas MacGyllepatric MacHilliegowie MacHpatrick MacIlday MacIldeu MacIldeus MacIldew MacIldoui MacIldowie MacIldowy MacIldue MacIlduf MacIlduff MacIlduy MacIlewe MacIlfadrich MacIlfatrik MacIlghuie MacIlguie MacIlguy MacIlhane MacIliphadrick MacIllepatrick MacIllephadrick MacIllephedder MacIllepheder MacIllephudrick MacIllewe MacIllewie MacIllfatrick MacIllhuy MacIlliduy MacIlmoun MacIlmune MacIlmunn MacIlpadrick MacIlpatrick MacIlpedder MacIlquham MacIlquhan MacIlwham MacIlwhom MacInturner MacKeldey MacKeldowie MacKildaiye MacKilday MacKilmine MacKilpatrick MacKlemin MacLaiman MacLammie MacLamon MacLamond MacLamont MacLaomuinm MacLaugas MacLawmane MacLeman MacLemme MacLemon MacLemond MacLeougas MacLimont MacLockie MacLokie MacLougas MacLowkas MacLucais MacLucas MacLucase MacLuckie MacLucky MacLugaish MacLugas MacLugash MacLugeis MacLugers MacLuggan MacLugish MacLuguis MacLuke MacLymont MacMalduff MacMunn MacOlphatrick MacPartick MacPatrick MacPeeters MacPhadraig MacPhadrick MacPhadrig MacPhadrik MacPhadruck MacPhadruig MacPhadryk MacPharick MacPhater MacPhatrick MacPhatricke MacPhatryk MacPheadair MacPheadarain MacPhedar MacPheddair MacPheddrin MacPhedearain MacPhederan MacPhedran MacPhedrein MacPhedron MacPheidearain MacPheidiran MacPheidran MacPheidron MacPhorich MacSoirle MacSorle MacSorley MacSorlie MacSorll MacSorlle MacSorrill MacSorrle MacSouarl Makfatrick Makgillevye Makgillewe Makgillewie Makilmone Makilmun Makilmune Maklucas Makmun Makpatrik Malpatric Meiklam Meiklefatrick Meikleham Meiklem Meiklfatrick Mickellduff Mund Munn Padair Padan Padesone Padison Padon Padraig Padruig Padson Padyn Padyne Pait Paitt Paruig Patair Pate Patein Paten Paterson Patersone Patersoun Patersoune Patesone Patheson Pathruig Patieson Patirsone Patirsoun Patison Patisone Patisoune Paton Patone Patonson Patonsoun Patoun Patoune Patowne Patric Patrick Patrickson Patricksone Patricson Patrikson Patrison Patrisone Patrisoun Patrykson Patten Patterson Pattie Pattinson Pattison Pattisoune Patton Pattone Pattoun Pattoune Pattounsoun Pattowsone Paty Patynson Patyrson Pautoun Pawton Pawtonsoun Pawtoun Pawtoune Peathine Pedair Pedan Pedden Peden Pedin Petensen Pethein Pethin Petirsoun Phadair Serle Soirlie Somerled Somhairle Sommerled Sorill Sorlet Sorley Sorleyson Sorlie Sorll Sorlle Sorrie Sourle Sumerled Sumerledi Sumerleht Sumerleith Sumerleth Sumerlethus Summerleith Surlay Surleus Surley Surly Toward Towart Turneour Turner Turnor Turnour Turnoure Vcclymont White Whyte Whytt Whytte

Lauder
Clan History: http://electricscotland.com/webclans/htol/lauder.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=237
Associated Names and Septs (with spelling variations):
Ladar Lauder Laudor Laudre Lauther Lauueder Lavedier Lavedre Lawadir Lawadyr Lawdir Lawdre Lawdyr Lawedre Lawther Leather Loweder

Leask
Clan History: http://electricscotland.com/webclans/htol/leask.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=238
Associated Names and Septs (with spelling variations):
Brogan Laisk Lask Laske Laski Laysk Leask Leaske Leisk Lesk Lesque Lisk Louask Lowask Lowsk

Lennox
Clan History: http://electricscotland.com/webclans/htol/lennox.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=239
Associated Names and Septs (with spelling variations):
Lennox Lenox Levenax Levinax Levynnax MacCorc MacCork MacGurgh MacGurk MacGurkich MacKork

Leslie
Clan History: http://electricscotland.com/webclans/htol/leslie.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=240
Associated Names and Septs (with spelling variations):
Abbernetti Abernathie Abernathy Aberneathy Abernethi Abernethie Abernethny Abernethy Abernyte Abernythe Abirnethie Abirnethny Abirnethy Abirnyte Abirnythy Abrenythie Aburnethe Achindachy Achyndachy Bartelmew Bartholomew Bartill Bartilmew Bertholmew Bertholomei Bertillmew Habernethi Leslei Lesley Lesli Leslie Lesly Lessely Lessley Lesslie

Lindsay
Clan History: http://electricscotland.com/webclans/htol/lindsay.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=242
Associated Names and Septs (with spelling variations):
Buyers Byers Byres Byris Byrs Cobb Dequhar Deuchair Deuchar Deuchars Deuchart Deucharys Deucher Deuchor Deughar Deugher Deuquhair Deuquhar Deuquhare Deuquhyre Dewchar Dewchare Dewquhar Dewquhir Doucher Doughar Douquhar Dowchar Dowgar Duchar Duchir Duchre Duquhar Duquhare Lindesse Lindissi Lindsay Lindsey Linsey Lyndissay MacClintoch MacClintock MacGhillefhiondaig MacGilliondaig MacIlandick MacIllandick MacInlaintaig MacLentick MacLintoch MacLintock

Livingston
Clan History: http://electricscotland.com/webclans/htol/livings.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=244
Associated Names and Septs (with spelling variations):
Leavack Leavock Levack Levingestoune Levingestun Levingston Levingstone Levingstoun Levingstoune Levington Levinston Levistone Levnstoun Levyngistoun Levyngstoun Levynston Levynstoune Levystone Lewingstoune Lewinston Lewyngstoun Lewynston Lewynstone Lewynstoun Lewynstoune Liuiston Liuistone Livingston Livingstone Livistoun

Lockhart
Clan History: http://electricscotland.com/webclans/htol/lockhart.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=835
Associated Names and Septs (with spelling variations):
Lockhart Lockhartt Lockhead Lockheart Lockhert Lokart Lokarte Lokert Lokhartt Lokkard

Logan
Clan History: http://electricscotland.com/webclans/htol/logan.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=247
Associated Names and Septs (with spelling variations):
Lagan Laggan Logan Logane Loggan Loghane Loghyn Logyn Lopan Lowgane

Lumsden
Clan History: http://electricscotland.com/webclans/htol/lumsden.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=249
Associated Names and Septs (with spelling variations):
Blanerne Lommestone Lumesten Lumisdane Lumisdayn Lumisdeane Lumisden Lumisdeyn Lummdane Lummesdene Lummisdane Lummisden Lummysden Lumsdaine Lumsdean Lumsden Lumysden Oldcambus

Lyon
Clan History: http://electricscotland.com/webclans/htol/lyon.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1066462369
Associated Names and Septs (with spelling variations):
Lion Lione Lioun Lyon

M
MacAlister
Clan History: http://electricscotland.com/webclans/m/macalis.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=252
Associated Names and Septs (with spelling variations):
Aillieson Alaksandu Alanesone Alanesoun Alanson Alansone Alansoun Alasdair Alason Alastair Alaster Alaxandair Aleckander Aleinson Alensone Aleschenor Aleschunder Aleson Alesone Alesoun Alester Alexander Alexanderson Alexshunder Aleynson Aleynsson Aliesone Alinson Alisandre Alison Alisone Alisschonder Alisschoner Alissone Alistair Alister Alizon Allanson Allansone Allansoune Allasdair Allason Allasone Allasoun Allasoune Allasson Allaster Alleson Allesoun Allesoune Allester Allinson Allison Allisone Allistair Allister Allsoun Alschinner Alschioner Alschonder Alschoner Alschunder Alshander Alshenour Alshinder Alshinor Alshioner Alshonar Alshonder Alshoner Alshonir Alshonner Alshumder Alshunder Alsinder Alynson Alysone Alzenher Alzenor Aschenour Ashioner Callister Collister Elchuner Elchyneur Ellis Ellison Elliss Ellisson Elsender Elshenar Elshender Elshener Elshenour Elsher Elshinar Elshioner Elshunder Elzenour MacAlasdair MacAlastair MacAlaster MacAlestar MacAlestare MacAlester MacAlestere MacAlestir MacAlestre MacAlexander MacAlistair MacAlister MacAllaster MacAllestair MacAllestar MacAllester MacAllestyr MacAllister MacAlshonair MacAlshoner MacAlstar MacAlyschandir MacCalister MacCallaster MacCollister MacKalexander MacKallister MacQuhollastar Makalester Makalestyr Makalexander Makallastair Makallestir Makeallyster Sanderis Sanderisone Sanderrissone Sanders Sanderson Sandersone Sandersounn Sandeson Sandesone Sandesoun Sandesoune Sandesounn Sandie Sandiesoune Sandison Sandrison Sandrissoun Sandy Saunders Saunderson


MacAlpine
Clan History: http://electricscotland.com/webclans/m/macalpi.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=254
Associated Names and Septs (with spelling variations):
Ailpin Alphin Alpin Alpine MacAilpein MacAlpain MacAlpie MacAlpin MacAlpine MacAlpy MacAlpyne MacCallpin MacCalpie MacCalpin MacCalppin MacCalpy MacCalpyne MacKalpie MacKalpin MacKelpin Makcalpy Makcalpyn Malcalpyn

MacAulay
Clan History: http://electricscotland.com/webclans/m/macaula.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=260
Associated Names and Septs (with spelling variations):
Aulay Auleth Faslane MacAla MacAlay MacAll MacAllay MacAlley MacAuihlay MacAula MacAulay MacAule MacAuley MacAuliffe MacAull MacAulla MacAullay MacAully MacAwla MacAwlay MacCaell MacCala MacCale MacCalla MacCallay MacCalley MacCallie MacCallow MacCally MacCaul MacCaula MacCaulaw MacCaulay MacCauley MacCaull MacCauly MacCawley MacCorley MacCowley MacGaulay MacGawley MacKail MacKaill MacKale MacKall MacKalla MacKallay MacKaula MacKauley MacKeil MacKell Makalley Makally Makcaill Makcale Makcalla Makcaulay Makkalay

MacBain
Clan History: http://electricscotland.com/webclans/m/macbain.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=265
Associated Names and Septs (with spelling variations):
Bain Baine Baines Bane Bayin Bayn Bayne Baynes Baynne Bean Beanes Beine Bene Bhaine Binney Binnie Binny MacAlbea MacBain MacBaine MacBaith MacBane MacBathe MacBay MacBayne MacBea MacBean MacBeane MacBeath MacBeatha MacBeathy MacBee MacBehan MacBeith MacBen MacBeth MacBetha MacBey MacBheath MacBheatha MacBheathain MacElvain MacElveen MacElwain MacGillebeatha MacGilvane MacGilweane MacHilmane MacIllvain MacIllveyan MacIlmeane MacIlmeine MacIlmeyne MacIlvain MacIlvaine MacIlvane MacIlvayne MacIlvean MacIlveane MacIlveen MacIlvian MacIlwain MacIlwaine MacIlweine MacKbayth MacKelvain MacKilvain MacKilvane MacKilven MacKilwein MacKilweyan MacKilwyan MacKlewain MacLewain MacVain MacVaine MacVane MacVean MacVeane MacWean MacWeane MacYlveine Maelbeth Makgilvane Makilmain Makilmeyn Makilvane Makilvene Makilwene Makilwyane Malbeth Mekilwaine Melbeth Speedie Speedy

MacBeth
Clan History: http://electricscotland.com/webclans/m/macbeth.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=267
Associated Names and Septs (with spelling variations):
Bay Beath Beathune Beathy Beaton Beatoun Beattone Beattoun Belton Bethon Bethune Betoin Beton Betone Betoun Betown Betowne Betton Bettune Beutan Bey Bittoune Leach Leatch Lech Leche Leech Leeche Leetch Leiche Leitch Leitche Leyche Liche Liech Lietch Litch MacBa MacBae MacBaith MacBathe MacBay MacBea MacBeath MacBeatha MacBeathy MacBee MacBeith MacBeth MacBetha MacBey MacBheath MacBheatha MacBheathain MacGillebeatha MacKbayth MacVay MacVeagh MacVeay MacVeigh MacVey Maelbeth Malbeth Melbeth

MacCallum
Clan History: http://electricscotland.com/webclans/m/maccall.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=271
Associated Names and Septs (with spelling variations):
Allum Callam Callum Challum MacAllum MacCalim MacCallome MacCallum MacCalme MacCaluim MacCalume MacColem MacCollom MacCollum MacColum MacCullom MacCullum Makallum Molcallum

MacColl
Clan History: http://electricscotland.com/webclans/m/maccoll.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=276
Associated Names and Septs (with spelling variations):
Cale Coll Collson Colson Coulson MacAll MacAuld MacAull MacCaell MacCail MacCaill MacCale MacCall MacCaul MacCaull MacCeol MacCoal MacCoel MacCole MacColl MacKail MacKaill MacKale MacKall MacKeil MacKell Makcaill Makcale

MacCorquodale
Clan History: http://electricscotland.com/webclans/m/maccorq.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=279
Associated Names and Septs (with spelling variations):
Corquodale Kerkyll MacCorcadail MacCorcadale MacCorcadill MacCordadill MacCorkell MacCorker MacCorkie MacCorkil MacCorkill MacCorkindale MacCorkle MacCorqudill MacCorquell MacCorquhedell MacCorquidall MacCorquidill MacCorquidle MacCorquodale MacCorquodill MacCorquydill MacKorkitill MacKorkyll MacKurkull MacOrkill MacOrquidill MacOrquodale MacQuorcadaill MacQuorquhordell MacQuorquodale MacQuorquordill MacThorcadail MacThorcuill MacThurkill MacTorquedil MacTorquil Makcocadill Makcorcadell Makcorquidill Makcorquydill Mikcorcadill Thorcull Torquil

MacDiarmid
Clan History: http://electricscotland.com/webclans/m/macdiar.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=281
Associated Names and Septs (with spelling variations):
MacDairmid MacDairmint MacDarmid MacDearmid MacDearmont MacDermaid MacDermand MacDerment MacDermid MacDermont MacDermot MacDermott MacDhiarmaid MacDiarmid MacDiarmond MacTarmayt

MacDonald
Clan History: http://electricscotland.com/webclans/m/macdona.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=282
Associated Names and Septs (with spelling variations):
Alaister Alasdair Alastair Alcock Alexanderson Alistair Aschenane Aschennan Aschennane Aschennay Ballach Balloch Balloche Bay Beath Beathune Beathy Beaton Beatoun Beattone Beattoun Bello Belloch Bellocht Bethon Bethune Betoin Beton Betone Betoun Betown Betowne Betton Bettune Beutan Bey Bittoune Bouie Bouwie Boway Bowey Bowie Bowy Bowye Boye Bridison Bridyson Brydeson Brydison Budge Buie Bulloch Bullock Burk Burke Buy Cale Cambridge Canochson Cathal Cathil Ceachairne Cochran Cochrane Coll Collson Colson Comgal Con Cone Congal Conghal Conn Connal Connall Conne Connel Connell Connell Cook Cooke Coull Coulson Cowan Cririe Cromb Crombie Croom Crowder Daniel Daniels Daracht Daroch Darow Darrach Darragh Darrah Darrauch Darraugh Darroch Darroche Darrock Darroicht Darrow Darroycht Darwycht Derroch Donald Donaldson Donaldsoun Donaldsoune Donillson Donnaldsone Donnell Donnellson Donnelson Donnilson Dorrach Dorroche Dorrocht Drain Dunnel Durroch Eachern Enrick Flora Forrest Forrester Galbracht Galbraith Galbreath Gall Galt Garrach Gaul Gauld Gault Gilbreid Gilbride Gilbridge Gilbryde Gilcomgal Gill Gillbride Gillebrid Gillebride Gilleconal Gilleconel Gillevrich Gilliconeill Giothbrith Godfraid Godfrey Goffraidh Gorey Gorre Gorrie Gorry Gothbrith Gove Gow Gowan Gowans Gowen Gowie Gowin Gowrie Grewar Grewer Grewyr Growar Gruar Gruer Guoroor Halthoirne Halthorn Halthorne Hathorn Hathorne Haulthorne Hauthorn Hauthorne Hawthorn Hawthorne Heron Hewison Hewson Hoeson Hotson Houcheon Houestoun Houston Houtton Howat Howchesoun Howe Howie Howieson Howison Hucheoun Huchesoune Huchisone Huchone Huchonson Huchonsone Huchonsoun Huchosone Huchown Huchunson Hudson Hugh Hughson Huisdean Huston Hutcheon Hutcheonson Hutcheoun Hutcheson Hutchesone Hutchieson Hutchin Hutching Hutchinson Hutchison Hutchon Hutchone Hutson Inrick Inrig Isaac Isaacs Isles Jeffrey Johnstone Keegan Keighren Kellaig Kellaigh Kelloch Kellough Kelly Kendrick Kenrick Kingairloch Kinnell Kynell Kynnell Ladron Ladrone Laing Lang Leach Leatch Lech Leche Leech Leeche Leetch Leiche Leitch Leitche Lescott Leyche Liche Liech Lietch Litch MacA'Challies MacAcharn MacAchern MacAcherne MacAffer MacAll MacAlwraith MacArorie MacArory MacArthur MacAsh MacAull MacBaith MacBathe MacBay MacBea MacBeath MacBeatha MacBeathy MacBee MacBeith MacBeth MacBetha MacBey MacBheath MacBheatha MacBheathain MacBraid MacBrayne MacBrid MacBridan MacBride MacBryd MacBryde MacCaa MacCaell MacCaffer MacCaffir MacCaichrane MacCail MacCaill MacCairn MacCaish MacCaishe MacCale MacCall MacCambridge MacCannel MacCannell MacCarron MacCash MacCauchquharn MacCaug MacCaul MacCaull MacCaw MacCay MacCeallaich MacCellaich MacChruimb MacChuthais MacClacharty MacClaffirdy MacClairtick MacClartie MacClarty MacClorty MacCluskie MacCoag MacCoasam MacCoch MacCochran MacCock MacCodruim MacCodrum MacCoiseam MacCole MacColl MacConell MacConil MacConile MacConill MacConl MacConnal MacConnel MacConnell MacConnil MacConnill MacConnyll MacCooish MacCook MacCorrie MacCorron MacCorry MacCory MacCosch MacCosh MacCosham MacCoshan MacCoshen MacCoshim MacCoshin MacCouck MacCoug MacCouk MacCouke MacCowag MacCowan MacCowig MacCowis MacCrain MacCran MacCrane MacCrary MacCravey MacCreary MacCreavie MacCreavy MacCreerie MacCreery MacCreire MacCreirie MacCreory MacCrerie MacCrery MacCrevey MacCrewer MacCrewir MacCrire MacCririck MacCririe MacCriuer MacCrivag MacCriver MacCrom MacCron MacCrone MacCrore MacCrorie MacCrory MacCrouder MacCrouther MacCrowther MacCrum MacCrumb MacCrume MacCrumie MacCuag MacCuaig MacCuail MacCuaill MacCueish MacCug MacCuidhean MacCuig MacCuish MacCuishe MacCuithean MacCuithein MacCuk MacCurchie MacCuthan MacDanel MacDaniel MacDaniell MacDhomhnuill MacDoaniel MacDonald MacDonell MacDonill MacDonnel MacDonnell MacDonnill MacDonnyle MacDonol MacDonoll MacDonyll MacDouny MacDrain MacEacharne MacEachearn MacEacheran MacEachern MacEachran MacEachren MacEchern MacEcherns MacElfresh MacElfrish MacElheran MacElherran MacElrath MacGaa MacGacharne MacGaughrin MacGaw MacGee MacGeoraidh MacGhee MacGilbride MacGill MacGillebeatha MacGillegrum MacGillemartin MacGillemertin MacGillereach MacGillereith MacGillereoch MacGillewriche MacGillibride MacGillirick MacGillreavy MacGillreick MacGilmartine MacGonnal MacGonnel MacGorie MacGorre MacGorrie MacGorry MacGory MacGoun MacGow MacGrader MacGrain MacGrane MacGrevar MacGrewar MacGrewer MacGroary MacGrory MacGrouther MacGrowder MacGrowther MacGruar MacGrudaire MacGrudder MacGruder MacGruer MacGrury MacGruthar MacGruther MacHael MacHieson MacHonel MacHrudder MacHruder MacHucheon MacHucheoun MacHugh MacHuiston MacHuitcheon MacIlaraith MacIlarith MacIlbowie MacIlbreid MacIlbrick MacIlbryd MacIlbuie MacIlchrom MacIlchrum MacIlchrumie MacIlerith MacIllbride MacIllereoch MacIllereoche MacIlleriach MacIllfreish MacIllfrice MacIlliruaidh MacIllreach MacIllreave MacIllrevie MacIllrick MacIllwrick MacIlmartine MacIlmertin MacIlraich MacIlraith MacIlravey MacIlravie MacIlreach MacIlreath MacIlreave MacIlrevie MacIlriach MacIlrith MacIlrivich MacIlroych MacIluraick MacIlurick MacIlvraith MacIlvreed MacIlvride MacIlwhannel MacIlwraith MacIlwraithe MacIlwrathe MacIlwrick MacIlwrith MacIock MacIsh MacJock MacKail MacKaill MacKale MacKall MacKay MacKbayth MacKbrid MacKconil MacKconnell MacKcook MacKcrain MacKcrumb MacKecherane MacKechern MacKechran MacKechrane MacKechren MacKee MacKeil MacKelbride MacKell MacKellachie MacKellaich MacKellaig MacKellaigh MacKelloch MacKelly MacKerron MacKewish MacKey MacKick MacKie MacKiggan MacKillaig MacKillmartine MacKilwraith MacKilwrath MacKindel MacKindle MacKinnel MacKinnell MacKiock MacKlewraith MacKonald MacKonnell MacKreath MacKrory MacKuish MacKush MacKynnell MacLaerigh MacLaerike MacLaertigh MacLaffertie MacLafferty MacLairish MacLairtie MacLardie MacLardy MacLartie MacLarty MacLartych MacLaverty MacLefrish MacLeverty MacLwannell MacLwhannel MacMark MacMarquis MacMarten MacMartin MacMartun MacMartyne MacMertein MacMertene MacMertin MacMhurchaidh MacMordoch MacMoroquhy MacMuiredhaigh MacMuiredhuigh MacMuirigh MacMukrich MacMurachy MacMurchaidh MacMurchie MacMurchou MacMurchy MacMurd MacMurdo MacMurdoch MacMurdon MacMurdy MacMuredig MacMurphy MacMurquhe MacMurquhie MacMurray MacMurtchie MacOdrum MacOneill MacOnele MacOnhale MacOnill MacOseanag MacOsenage MacOsennag MacOsham MacO'Shenag MacOshennag MacO'Shennaig MacOshenog MacOwan MacOwis MacQueen MacQuhannil MacQuhonale MacQuhonyle MacQuilkan MacRain MacRaine MacRaith MacRaurie MacRavey MacRayne MacRearie MacReary MacReirie MacRerie MacRevey MacRevie MacRirick MacRiridh MacRirie MacRither MacRob MacRobb MacRobe MacRoderick MacRoithrich MacRone MacRorie MacRory MacRotherick MacRourie MacRoyre MacRoyree MacRoyri MacRuairidh MacRuar MacRuaraidh MacRuary MacRudder MacRudrie MacRuer MacRuidhri MacRurie MacRurry MacRury MacRyrie MacShannachan MacSherry MacShirie MacShirrie MacSoirle MacSorle MacSorlet MacSorley MacSorlie MacSorll MacSorlle MacSorrill MacSorrle MacSouarl MacSporran MacSwan MacSween MacUish MacUrchie MacUrchy MacVanish MacVannel MacVenish MacVinish MacVorchie MacVurchie MacWhan MacWhaneall MacWhanell MacWhanle MacWhanlie MacWhannall MacWhannel MacWhannell MacWhannil MacWhanrall MacWhonnell MacWorthie MacWurchie MacYnniel Maelbeth Magilraich Magruder Mairtin Makauchern Makcacharne Makcaill Makcale Makconehill Makconeil Makconell Makconnele Makcosshen Makcrire Makcrome Makdonald Makeacharne Makerori Makgacharne Makgilbred Makgillereach Makgillereacht Makgillereoch Makgruder Makilbred Makilreve Maklafferdich Maklewreach Makmartin Makmurche Makmurdie Makmurquhy Makmurthe Makreury Makririe Makrome Makrore Makrudder Malaverty Malavery Malbeth Mapon March Marcus Mark Marke Marquis Martein Martin Martine Martyn Martyne May Meekison Meiklevrick Melbeth Merk Mhurchaidh Micklewrath Miklerock Mordac Mordake Mordik Mordoc Mordok Mordyk Moreduc Morthaich Mourdac Muireadhach Muiredach Murchad Murchadh Murchaidh Murcheson Murchesoun Murchie Murchieson Murchison Murchosone Murchosoun Murchy Murdac Murdak Murdoc Murdoch Murdock Murdosch Murdoson Murdy Murphie Murphy Murquhason Murquhasson Murquhessoun Murquhosoun Murtchie Murthac Murthak Odhrain Odhran O'Drain Odran Omay O'May Omey O'Mey Omeych O'Seanaigh O'Shaig O'Shannachan O'Shannaig O'Shannon Pathillock Patillo Patillok Patten Pattillo Pattillock Pattullo Pattullok Patullo Patullow Peden Pethilloch Petillok Pettillo Pettillok Pettillow Pettullock Petulloch Petullow Philp Pitilloche Pitiloch Pittilloch Pittillock Pittillocke Pittilluo Pittulloch Pitullich Porcel Porcell Purcell Pursel Pursell Pursill Pyttyllok Raich Rainnie Reach Reacht Reaich Reauch Reaucht Reche Reddick Reiach Reoch Reoche Rerike Rethe Reuch Revie Reyth Riach Riauch Riddick Rioch Rioche Ririe Roderick Roeoch Rorie Rorieson Rorison Rorrison Ryrie Sander Serle Shannan Shannon Shennan Shennane Soirlie Somerled Somhairle Sommerled Sorill Sorlet Sorley Sorlie Sorll Sorlle Sorrie Sourle Sporran Sumerled Sumerledi Sumerleht Sumerleith Sumerleth Sumerlethus Summerleith Surlay Surleus Surley Surly Train Tran Trane Trayne Uisdean Uisdeann Uisdinn Vcconull Vccoshem Vcmurrochie Vconeill Whandle Whannel Whannell Wheelan Whellans Whonnell Wilkie Wilkinson

MacDonald Of Ardnamurchan
Clan History: http://electricscotland.com/webclans/m/macdonald/other_glencoe.htm
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=303
Associated Names and Septs (with spelling variations):
Cain Johnesson Johnnessone Johnson Joneson Jonesson Jonessone Jonson Jonsone Jonsoun Kain Kean Keand Keane Keene Kene MacAin MacAne MacCain MacCaine MacCane MacCayne MacDonald MacEan MacEane MacEoin MacIain MacIan MacKain MacKane MacKean MacKeand MacKein Makane Makayn Makcane Makcayne Makean Makkane Makkean

MacDonald Of Boisdale
Clan History: http://electricscotland.com/webclans/m/macdona.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1220
Associated Names and Septs (with spelling variations):
Boisdale

MacDonald Of Clanranald
Clan History: http://electricscotland.com/webclans/m/macdonald/ranald.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=304
Associated Names and Septs (with spelling variations):
Ailen Ailene Ailin Aillieson Alain Alan Alanach Alane Alanesone Alanesoun Alanson Alansone Alansoun Alanus Alason Aleinson Alen Alenach Alene Alensone Aleson Alesone Alesoun Aleyn Aleynson Aleynsson Aliesone Alinson Alison Alisone Alissone Alizon Allan Allanach Allanache Alland Allane Allanock Allanson Allansone Allansoune Allason Allasone Allasoun Allasoune Allasson Allen Allenoch Alleson Allesoun Allesoune Allinson Allison Allisone Allone Allsoun Alnach Alowne Alwyn Alynson Alysone Auchaneson Caitchen Callan Calland Callen Ceachie Clanranald Couric Curie Curray Curre Curri Currie Curry Currye Eachan Eachane Eachen Eachin Eachine Gachen Geachan Geachin Geachy Kaachie Kachie Keachie Keachy Keesack Ketchen Ketchin Kissack Kissick Kissock Lescott MacAchaine MacAchan MacAchane MacAchin MacAchine MacAichan MacAilein MacAilin MacAitchen MacAllan MacAllane MacAuchin MacAychin MacBurie MacCachane MacCachie MacCachin MacCallan MacCallane MacCalloun MacCaughan MacCeachan MacCeachie MacCeasag MacCeasaig MacCheachan MacCheachie MacChrynnell MacCisaig MacCourich MacCrendill MacCrenild MacCrindell MacCrindill MacCrindle MacCrundle MacCrunnell MacCryndill MacCryndle MacCrynell MacCrynill MacCrynnell MacCrynnill MacCurich MacCurie MacCurrach MacCurragh MacCurrich MacCurrie MacCurry MacCusack MacDonald MacEachain MacEachainn MacEachan MacEachane MacEacharin MacEachen MacEachin MacEachine MacEachnie MacEachny MacEchan MacEcheny MacEchnie MacEsayg MacEuchine MacFuirigh MacGachan MacGachand MacGachen MacGachyn MacGaghen MacGaichan MacGaithan MacGauchan MacGauchane MacGauchin MacGaugie MacGaukie MacGaychin MacGeachan MacGeachen MacGeachie MacGeachin MacGeachy MacGeaghy MacGeak MacGechan MacGechie MacGeechan MacGeuchie MacGrindal MacGrundle MacIkin MacIosaig MacIsaac MacIsaak MacIsack MacIsaick MacIsak MacIseik MacIssac MacKallan MacKeachan MacKeachie MacKeachy MacKechnie MacKeech MacKeechan MacKeekine MacKeesick MacKeich MacKeihan MacKeissik MacKeithan MacKeithen MacKeochan MacKesek MacKesk MacKessack MacKessick MacKessock MacKessog MacKessogg MacKethan MacKeyoche MacKiachan MacKichan MacKiech MacKiehan MacKirchan MacKisack MacKiseck MacKissack MacKissek MacKissick MacKissoch MacKissock MacKistock MacKithan MacKouchane MacKrenald MacKrenele MacKukan MacKurrich MacKury MacKusick MacKussack MacKyrnele MacMhourich MacMhuireadhaigh MacMhuirich MacMhuirrich MacMurich MacMurrich MacMurriche MacMurrycht MacOurich MacQuithean MacQuitheane MacQuithen MacRanal MacRanald MacRandal MacRandall MacRandell MacRanich MacRanie MacRannal MacRannald MacRenald MacRenold MacReynald MacReynold MacReynolds MacRindle MacRinnell MacRinnyl MacRonald MacRonall MacRynald MacRynall MacRyndill MacRynell MacRynild MacUirigh MacUrich MacVarish MacVarraich MacVarrais MacVarrich MacVarrish MacVarrist MacVeirrich MacVirrich MacVirriche MacVirrist MacVoerich MacVoreis MacVoreiss MacVoreist MacVorich MacVoriche MacVoris MacVorish MacVorist MacVorrich MacVourich MacVurich MacVurie MacVurirch MacVuririch MacVurist MacVurrich MacVurriche MacVurrish MacWarish MacWirrich MacWirriche MacWithean MacWithy MacWurie MacYsaac MacYsac Makachyn Makallane Makcachane Makcrunnell Makcurrie Makesaig Makessaig Makgachane Makgachyn Makgechine Makkessake Makmurriche Makrinnyl Makrunnell Makrynnild Makrynyll Makvirriche Makysaac Mecachin Muireach Murreich Park Raghnall Ranald Ranaldson Ronald Ronaldson Ronnald

MacDonald Of Glencoe
Clan History: http://electricscotland.com/webclans/m/macdonald/other_glencoe.htm
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=306
Associated Names and Septs (with spelling variations):
Cain Eanrig Eanruig Henderson Hendersone Hendersonne Hendersoun Hendersoune Hendery Hendirsone Hendirsoune Hendrie Hendrisoune Hendry Henersoun Hennersoune Hennryson Henresoun Henreysoun Henriesoun Henrison Henrisone Henrisoun Henrisoune Henry Henryesson Henryson Henrysoun Johnesson Johnnessone Johnson Joneson Jonesson Jonessone Jonson Jonsone Jonsoun Kain Kean Keand Keane Keene Kene MacAin MacAne MacCain MacCaine MacCane MacCanrig MacCanrik MacCayne MacDonald MacEan MacEane MacEanruig MacEnrick MacEoin MacHendric MacHendrie MacHendry MacHenrie MacHenrik MacHenry MacIain MacIan MacKain MacKane MacKanrig MacKean MacKeand MacKein MacKenabry MacKendric MacKendrich MacKendrick MacKendrie MacKendrig MacKendry MacKenrick Makane Makanry Makayn Makcane Makcayne Makean Makhenry Makkane Makkean

MacDonald Of Kingsburgh
Clan History: http://electricscotland.com/webclans/m/macdona.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1198
Associated Names and Septs (with spelling variations):
Kingsburgh

MacDonald Of Sleat
Clan History: http://electricscotland.com/webclans/m/macdonald/middle.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=307
Associated Names and Septs (with spelling variations):
Cook Cooke Hewison Hewson Hoeson Hotson Houcheon Houestoun Houston Houtton Howchesoun Howieson Howison Hucheoun Huchesoune Huchisone Huchone Huchonson Huchonsone Huchonsoun Huchosone Huchown Huchunson Hudson Hugh Hughson Huisdean Huston Hutcheon Hutcheonson Hutcheoun Hutcheson Hutchesone Hutchieson Hutchin Hutching Hutchinson Hutchison Hutchon Hutchone Hutson MacCucheon MacCuistan MacCuisten MacCuistion MacCuiston MacCutchan MacCutchen MacCutcheon MacCutchion MacCutheon MacDonald MacGuistan MacHouston MacHoutton MacHucheon MacHucheoun MacHugh MacHuiston MacHuitcheon MacHutchen MacHutcheon MacHutchin MacHutchison MacHutchon MacHutchoun MacOisein MacQueiston MacQuesten MacQueston MacQuistan MacQuisten MacQuistin MacQuiston MacUiston MacWhiston Makhuchone Sleat Uisdean Uisdeann Uisdinn

MacDonald Of Staffa
Clan History: http://electricscotland.com/webclans/m/macdonald/addinfojpw.htm
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1164
Associated Names and Septs (with spelling variations):
Staffa

MacDonell Of Glengarry
Clan History: http://electricscotland.com/webclans/m/macdonn.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=711
Associated Names and Septs (with spelling variations):
Alaksandu Alaxandair Aleckander Aleschenor Aleschunder Alexander Alexshunder Alisandre Alisschonder Alisschoner Alschinner Alschioner Alschonder Alschoner Alschunder Alshander Alshenour Alshinder Alshinor Alshioner Alshonar Alshonder Alshoner Alshonir Alshonner Alshumder Alshunder Alsinder Alzenher Alzenor Aschenour Ashioner Elchuner Elchyneur Elsender Elshenar Elshender Elshener Elshenour Elsher Elshinar Elshioner Elshunder Elzenour MacAlistair MacAlister MacDonald MacDonell Sanders Sanderson Sandeson Sandesone Sandesoun Sandesoune Sandesounn Sandie Sandiesoune Sandison Sandy

MacDonell Of Keppoch
Clan History: http://electricscotland.com/webclans/m/macdonald/other_keppoch.htm
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=313
Associated Names and Septs (with spelling variations):
Keppach Keppoch MacChrynnell MacCrendill MacCrenild MacCrindell MacCrindill MacCrindle MacCrundle MacCrunnell MacCryndill MacCryndle MacCrynell MacCrynill MacCrynnell MacCrynnill MacDonald MacDonell MacGillip MacGillivantic MacGilliveide MacGillop MacGilp MacGlasrich MacGlasserig MacGlassrich MacGrindal MacGrundle MacKillib MacKillip MacKillop MacKrenald MacKrenele MacKyrnele MacMeachie MacMichie MacPhilib MacPhilip MacPhilipps MacPilips MacRanal MacRanald MacRandal MacRandall MacRandell MacRanich MacRanie MacRannal MacRannald MacRenald MacRenold MacReynald MacReynold MacReynolds MacRindle MacRinnell MacRinnyl MacRonald MacRonall MacRynald MacRynall MacRyndill MacRynell MacRynild Makcrunnell Makellop Makillip Makillop Makphilp Makrinnyl Makrunnell Makrynnild Makrynyll Mechie Meechie Mekie Michie Michieson Philip Philips Philipson Philipsone Phillip Phillips Phillipson Phillipsone Raghnall Rainnie Ranald Ranaldson Rennie Ronald Ronaldson Ronnald

MacDougall
Clan History: http://electricscotland.com/webclans/m/macdoug.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=314
Associated Names and Septs (with spelling variations):
Carmechele Carmichael Carmichaill Carmichel Carmichell Carmigell Carmighell Carmitely Carmychale Carmychall Carmychel Carmychell Cayrmichel Cayrmichell Coles Conachar Conacher Concher Connachar Connacher Coule Coull Cowan Cowen Cowill Cowl Cowle Culloch Cuwill Dhoil Dill Doil Dool Dougal Dougald Dougale Dougall Doul Doule Doull Dowal Dowall Doweill Dowele Dowell Dowgal Dowgall Dowill Dubgaill Dubgall Dubhgall Dufgal Dugal Dugald Dugall Duggall Dughall Duill Dyle Dyll Eunson Gugan Gulloch Howell Howells Kermychell Killichoan Leavack Leavock Levack Levingestoune Levingestun Levingston Levingstone Levingstoun Levingstoune Levington Levinston Levistone Levnstoun Levyngistoun Levyngstoun Levynston Levynstoune Levystone Lewingstoune Lewinston Lewyngstoun Lewynston Lewynstone Lewynstoun Lewynstoune Liuiston Liuistone Livingston Livingstone Livistoun Louk Louke Lucas Luches Luck Luckie Luckieson Luik Luke MacAichan MacAlach MacChullach MacClintock MacClucas MacClugash MacClugass MacClugeis MacClullich MacCoan MacColloch MacColly MacConacher MacConcher MacConnacher MacConquhar MacCool MacCouil MacCoul MacCoulach MacCoulagh MacCoulaghe MacCoule MacCoull MacCouyll MacCowan MacCowell MacCowen MacCowil MacCowl MacCowlach MacCowle MacCowne MacCoyle MacCuile MacCuley MacCullach MacCullagh MacCullaghe MacCullaigh MacCullauch MacCullie MacCullo MacCulloch MacCullocht MacCullogh MacCulloh MacCullough MacCully MacDhugal MacDhughaill MacDill MacDogall MacDole MacDoll MacDool MacDoual MacDouall MacDouell MacDougal MacDougald MacDougall MacDoughal MacDougle MacDoul MacDouwille MacDouyl MacDovall MacDovele MacDoville MacDovylle MacDowal MacDowale MacDowall MacDowalle MacDowele MacDowell MacDowelle MacDowile MacDowille MacDowilt MacDowll MacDowylle MacDoyle MacDual MacDuall MacDuel MacDugal MacDugald MacDuhile MacDule MacDull MacDulothe MacDuoel MacDuwell MacDuwyl MacGillecoan MacGillequhoan MacGillequhoane MacGillichoan MacGillichoane MacGillochoaine MacGlugas MacGougan MacGuckin MacGugan MacGuigan MacGuoga MacHoul MacHoule MacHowell MacHulagh MacHullie MacIlchoan MacIlchoane MacIlchoen MacIlchomhghain MacIllichoan MacKcoul MacKculloch MacKdowall MacKeech MacKeich MacKeith MacKeyoche MacKiachan MacKichan MacKiech MacKillichoan MacKilquhone MacKirchan MacKoull MacKowean MacKowen MacKowie MacKowin MacKowle MacKowloch MacKowloche MacKowne MacKownne MacKowyne MacKulagh MacKullie MacKulloch MacKullouch MacLaugas MacLehoan MacLeougas MacLockie MacLokie MacLougas MacLowkas MacLucais MacLucas MacLucase MacLuckie MacLucky MacLugaish MacLugas MacLugash MacLugeis MacLugers MacLugish MacLuguis MacLuke MacLulaghe MacLulaich MacLulich MacLulli MacLullich MacLullick MacNamaoile MacNamell MacNamil MacNamill MacNomiolle MacNomoille MacOloghe MacOual MacOul MacOulie MacOull MacOwan MacOwen MacOwl MacOwlache MacQuhoull MacUlagh MacUlaghe MacUllie MacUlloch Madole Makawllauch Makcoulach Makcoule Makcowl Makcowllach Makcowloch Makcullo Makculloch Makcullocht Makdoval Makdovele Makdowale Makdowelle Makdugl Makdull Makgillechoan Makgillichoan Makhulagh Makillichoan Makilquhone Maklucas Malcowlach Maydole O'Cocoher Oconchar Oconicher Oconochar Oconocher Pathillock Patillo Patillok Pattillo Pattillock Pattullo Pattullok Patullo Patullow Pethilloch Petillok Pettillo Pettillok Pettillow Pettullock Petulloch Petullow Pitilloche Pitiloch Pittilloch Pittillock Pittillocke Pittilluo Pittulloch Pitullich Pyttyllok

MacDuff
Clan History: http://electricscotland.com/webclans/m/macduff.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=324
Associated Names and Septs (with spelling variations):
Abbernetti Abernathie Abernathy Aberneathy Abernethi Abernethie Abernethny Abernethy Abernyte Abernythe Abirnethie Abirnethny Abirnethy Abirnyte Abirnythy Abrenythie Aburnethe Doff Duf Duff Duif Habernethi Lang Lange Laynge MacDuff Makduf Wemes Wemeth Wemis Wemise Wemyes Wemys Wemyss Wemysse

MacEachan
Clan History: http://electricscotland.com/webclans/m/maceachain.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=713
Associated Names and Septs (with spelling variations):
Auchaneson Geachan Geachin Geachy Kaachie Kachie Keachie Keachy MacAchaine MacAchan MacAchane MacAchin MacAchine MacAichan MacAitchen MacAuchin MacAychin MacCachane MacCachie MacCachin MacCaughan MacCeachan MacCeachie MacCheachan MacCheachie MacEachain MacEachainn MacEachan MacEachane MacEachen MacEachin MacEachine MacEachnie MacEachny MacEchan MacEcheny MacEchnie MacEuchine MacGachan MacGachand MacGachen MacGachyn MacGaghen MacGaichan MacGaithan MacGauchan MacGauchane MacGauchin MacGaugie MacGaukie MacGaychin MacGeachan MacGeachen MacGeachie MacGeachin MacGeachy MacGeaghy MacGeak MacGechan MacGechie MacGeechan MacGeuchie MacIkin MacKeachan MacKeachie MacKeachy MacKechnie MacKeechan MacKeekine MacKeihan MacKeithan MacKeithen MacKeochan MacKethan MacKiehan MacKithan MacKouchane MacKukan Makachyn Makcachane Makgachane Makgachyn Makgechine Mecachin

MacEwan
Clan History: http://electricscotland.com/webclans/m/macewan.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=331
Associated Names and Septs (with spelling variations):
Eogan Eogann Eoghan Eoghann Eugene Eunson Eunsone Evan Evanson Evinson Ewain Ewan Ewen Ewenson Ewin Ewinesone Ewing Ewinn Ewinson Ewinsoun Ewisone Ewnesoune Ewynson Ewynsone Ewynsoun Keown MacCoun MacCuinn MacCune MacCunn MacCwne MacEogan MacEoghainn MacEoghann MacEuen MacEun MacEvan MacEven MacEvin MacEvine MacEwan MacEwen MacEwin MacEwine MacEwing MacEwingstoun MacEwn MacKeon MacKeowan MacKeown MacKevin MacKewan MacKewin MacKewn MacKewnie MacKewyne MacKoen MacKone MacKuen MacKuenn MacKuinn MacKune MacQuckian MacQuikan MacUne MacYewin MacYowin MacYwene Makcune Makcvne Makewn Yewnsoun

MacFadyen
Clan History: http://electricscotland.com/webclans/m/macfady.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=334
Associated Names and Septs (with spelling variations):
MacFadden MacFaden MacFadin MacFadion MacFadwyn MacFadyean MacFadyen MacFadyon MacFadzan MacFadzean MacFadzein MacFadzeon MacFattin MacFayden MacFedden MacFeyden MacFydeane MacPadane MacPaden MacPhadan MacPhadden MacPhaddion MacPhadein MacPhaden MacPhadzen MacPhaidein MacPhaiden MacPhaidin MacPhyden Makfadzane

MacFarlane
Clan History: http://electricscotland.com/webclans/m/macfarl.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=335
Associated Names and Septs (with spelling variations):
Ailen Ailene Ailin Aillieson Alain Alan Alanach Alane Alanesone Alanesoun Alanson Alansone Alansoun Alanus Alason Aleinson Alen Alenach Alene Alensone Aleson Alesone Alesoun Aleyn Aleynson Aleynsson Aliesone Alinson Alison Alisone Alissone Alizon Allan Allanach Allanache Alland Allane Allanock Allanson Allansone Allansoune Allason Allasone Allasoun Allasoune Allasson Allen Allenoch Alleson Allesoun Allesoune Allinson Allison Allisone Allone Allsoun Alnach Alowne Alwyn Alynson Alysone Arral Arrel Arrell Arrol Arroll Baitie Baittie Baitty Bartelmew Bartholomew Bartilmew Bateson Batieson Batteson Battie Battison Batty Baty Beatie Beatson Beattie Beatty Beaty Bertholmew Bertholomei Bertillmew Bryce Callan Calland Callen Cannison Caw Clay Conlay Conley Cunieson Cunison Cunnison Cunyson Cunysoun Cwnyson Donleavy Donlevy Dunleavy Dunslef Farlan Farlane Gracey Gracie Gracy Graisich Grasich Grass Grasse Grasseich Grassiche Grassichsone Grassick Grassie Grasycht Graysich Greasaighe Greasich Grecie Greishich Greoschich Greoshich Greshach Gresich Gressiche Greusach Greusaich Grevsach Griasaich Griesck Gruamach Kenison Kennison Kinnieson Kinnison Kunnison Lennox Lenox MacAilein MacAilin MacAindra MacAllan MacAllane MacAnally MacAnnally MacAnstalcair MacAnstalkair MacAves MacAvis MacAvish MacAw MacAwis MacAwishe MacBarron MacCa MacCaa MacCallan MacCallane MacCalloun MacCannally MacCaueis MacCauish MacCause MacCavis MacCavish MacCavss MacCaw MacCawe MacCaweis MacCawis MacCaws MacClae MacClay MacCleay MacClew MacCollea MacColly MacCondie MacCondy MacConlea MacDimslea MacDonleavy MacDonnslae MacFarlan MacFarland MacFarlane MacFarlen MacFarlin MacFarling MacFerlane MacGaa MacGaw MacGeoch MacGeouch MacGooch MacGrasaych MacGrassych MacGrassycht MacGrasycht MacGrayych MacGreische MacGreish MacGresche MacGresich MacGressich MacGressiche MacGreusach MacGreusaich MacGreusich MacHamish MacHenish MacInair MacInally MacInayr MacInnuer MacInnuier MacInnyeir MacInstalker MacInstokir MacInstucker MacInuair MacInuar MacInuire MacInuyer MacIock MacIstalkir MacJames MacJamis MacJock MacKa MacKaa MacKallan MacKames MacKau MacKaw MacKawe MacKawes MacKeamish MacKeandla MacKfarlen MacKindlay MacKinla MacKinlay MacKinley MacKiock MacKjames MacKnaer MacKnair MacKnaire MacKnedar MacKynnair MacKynnayr MacLae MacLay MacLea MacLeay MacLey MacNair MacNally MacNar MacNare MacNayair MacNayer MacNayr MacNayre MacNeadair MacNear MacNedair MacNedar MacNedyr MacNeer MacNeir MacNettar MacNeur MacNewer MacNidder MacNider MacNiter MacNoder MacNoyar MacNoyare MacNoyiar MacNuer MacNuir MacNuire MacNure MacNuyer MacNvyr MacOnlay MacParlan MacParland MacParlane MacParlin MacPharheline MacPharlain MacPharlane MacQualter MacQuater MacQuatter MacQuhalter MacRob MacRobb MacRobe MacStaker MacStalker MacStokker MacTaevis MacTamhais MacTause MacTaveis MacTavish MacTawisch MacTawys MacThamais MacThamhais MacThavish MacUaltair MacVater MacWalter MacWaltir MacWater MacWatter MacWattir MacYnstalker Makallane Makavhis Makaw Makawis Makca Makcaus Makcaw Makcawe Makcawis Makcaws Makcawys Makcoe Makfarland Makfarlane Makferlan Makferlande Makgeouch Makinstalker Makkaw Makley Maknair Maknare Maknayr Makneddar Maknewar Maknoyar Makrob Makstalkare Makstoker Makwatter Makynnair Melir Mill Millan Millar Millare Millen Miller Millin Millman Milln Mills Miln Milne Milner Milnes Monach Monech Munnoch Munnock Munoch Mylar Mylen Myllair Myllar Myllare Myln Naiper Napare Napeir Naper Napier Napper Neaper Nepare Neper Parlan Parlane Rob Robb Spreuile Spreuill Spreul Spreule Spreull Sprewell Sprewile Sprewill Sprewl Sprewle Sprewyle Sproul Sproule Sproull Staiker Stalcare Stalkair Stalkar Stalker Vair Veir Vere Veyre Wair Ware Wayre Wear Weare Weaver Weer Weir Weire Were Werr Weyir Weyr Whier Wier Wir Wire

MacGill
Clan History: http://electricscotland.com/webclans/m/mcgil.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=345
Associated Names and Septs (with spelling variations):
MacCill MacGal MacGall MacGeil MacGhoill MacGile MacGill MacGille MacGuill MacGyll MacKgil MacKill MacKille Makgill Makkill

MacGillivray
Clan History: http://electricscotland.com/webclans/m/macgill.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=346
Associated Names and Septs (with spelling variations):
Gilderoy Gilray Gilroy Gilry Gilrye Gilvray MacElroy MacGillavary MacGillavery MacGillavrach MacGillevary MacGillevoray MacGillevorie MacGillevray MacGillewra MacGillewray MacGillivary MacGillivoor MacGillivraid MacGillivray MacGillivrie MacGillivry MacGillowray MacGillvary MacGillveray MacGillvery MacGillvra MacGillvray MacGilrey MacGilroy MacGilroye MacGilvary MacGilvery MacGilvory MacGilvra MacGilvray MacGilwrey MacGuilvery MacIlbraie MacIliwray MacIllevorie MacIllory MacIllvra MacIloray MacIlra MacIlray MacIlrie MacIlroy MacIluray MacIlveerie MacIlvery MacIlvora MacIlvoray MacIlvory MacIlvra MacIlvrach MacIlvrae MacIlvray MacIlwra MacIlwray MacKelrae MacKilrae MacKilrea MacKilroy MacKleroy MacLeroy MacLroy MacOulroy MacYlory MacYlroy MacYlroye Makgilroy Makillewray Makilrow Makkilrow Meikleroy Micklroy Milroy Vcgillevorie

MacGregor
Clan History: http://electricscotland.com/webclans/m/macgreg.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=349
Associated Names and Septs (with spelling variations):
Adamson Adamsone Ademson Ademsoun Ademsoune Argyl Arrowsmith Balquhidder Barrowman Begland Blac Black Blacke Blackie Blaick Blaik Blaike Blaikey Blaikie Blak Blake Blayk Bowers Bowmaker Brewer Brewester Brewster Brostar Broster Broustar Broustare Brouster Broustir Browistar Browstare Browster Caird Callendar Card Ceard Combry Comerie Comri Comrie Connochie Connoquhie Conochie Cormie Craigdallie Crerar Crowder Crowther Cumre Cumry Dennison Denson Dochard Dochart Docherty Douie Dowie Dowy Evanson Evinson Fischar Fischear Fischer Fisher Fisser Flechyr Fledger Fleger Fleschar Flescher Fleschor Fleschour Flesher Flesser Flessher Flesshour Flessor Fletcheour Fletcher Fuccatour Fuckater Fugater Fugatour Fuggatour Fuktor Fuktour Futtor Gair Gildawie Gildowie Gilduff Gilfeather Gilfedder Gilledow Gilleduff Gillegowie Giric Girig Goodsir Gragson Greer Greg Gregg Gregor Gregorie Gregorson Gregory Gregson Greig Greigory Grewar Grewer Grewyr Grier Grierson Grige Grigg Grigor Growar Gruar Gruer Gudger Guinness Kaird Keeard Keerd Kerd Kerde King Kyng Kynge Laikie Laiky Leckie Lecky Lecque Lekky MacAdaim MacAdam MacAdame MacAddam MacAddame MacAinish MacAinsh MacAldowie MacAldowrie MacAldowy MacAlduie MacAnce MacAngus MacAnish MacAnsh MacAonghus MacAra MacAree MacArra MacArray MacCadam MacCadame MacCaddam MacCaddame MacCaddim MacCainsh MacCance MacCanch MacCanish MacCaniss MacCans MacCanse MacCansh MacCants MacCara MacCarra MacCarres MacCary MacChoiter MacChonachy MacClester MacConachie MacConachy MacConaghy MacConche MacConchie MacConchy MacCondach MacCondachie MacCondachy MacCondie MacCondochie MacCondoquhy MacConechie MacConechy MacConiquhy MacConkey MacConnachie MacConnaghy MacConnchye MacConnechie MacConnechy MacConnichie MacConnochie MacConnoquhy MacConnquhy MacConochey MacConochie MacConoughey MacConquhie MacConquhy MacConquy MacCrewer MacCrewir MacCrouder MacCrouther MacCrowther MacCruar MacCuail MacCuaill MacDhonnachie MacElduff MacFaktur MacFleger MacFuktor MacFuktur MacGildhui MacGilduff MacGildui MacGilevie MacGilewe MacGiliver MacGilladubh MacGilldowie MacGilledow MacGilleduf MacGilleduibh MacGillefedder MacGillegowie MacGillewe MacGillewey MacGillewie MacGillewy MacGillewye MacGilliduffi MacGilliewie MacGilligowie MacGilligowy MacGilliue MacGilliver MacGilliwie MacGillogowy MacGilvie MacGrader MacGregare MacGregor MacGregur MacGreigor MacGrevar MacGrewar MacGrewer MacGriger MacGrigor MacGrigour MacGrouther MacGrowder MacGrowther MacGruar MacGrudaire MacGrudder MacGruder MacGruer MacGruthar MacGruther MacHilliegowie MacHoiter MacHonichy MacHrudder MacHruder MacIlday MacIldeu MacIldeus MacIldew MacIldoui MacIldowie MacIldowy MacIldue MacIlduf MacIlduff MacIlduy MacIleur MacIlewe MacIlghuie MacIlguie MacIlguy MacIllephedder MacIllepheder MacIllewe MacIllewie MacIllhuy MacIlliduy MacIlnaey MacIlpedder MacIncaird MacInechy MacInkaird MacInkeard MacInleaster MacInleister MacInlester MacInlister MacInnocater MacInnowcater MacInnowcatter MacInnugatour MacInocader MacInstalker MacInstokir MacInstucker MacInuctar MacInucter MacInvalloch MacIstalkir MacKadam MacKadem MacKchonchie MacKeardie MacKeldey MacKeldowie MacKhonachy MacKildaiye MacKilday MacKinish MacKinshe MacKnae MacKne MacKneach MacKnee MacKneis MacKneische MacKneishe MacKness MacKnie MacKnish MacKnockater MacKnocker MacKnockiter MacKnokaird MacKondachy MacKonochie MacKunuchie MacLavor MacLeaver MacLeever MacLeister MacLiver MacMalduff MacMigatour MacMuckater MacMuncater MacMuncatter MacMungatour MacNae MacNakaird MacNaois MacNaoise MacNaucater MacNay MacNea MacNecaird MacNee MacNees MacNeice MacNeigh MacNeis MacNeische MacNeish MacNeiss MacNekard MacNesche MacNess MacNey MacNie MacNikord MacNische MacNish MacNoaise MacNocaird MacNokaird MacNokard MacNokerd MacNokord MacNorcard MacNougard MacNowcater MacNowcatter MacNucadair MacNucater MacNucator MacNucatter MacNuctar MacNuicator MacNysche MacOnachie MacOnachy MacOnchie MacOndochie MacOndoquhy MacOnechy MacOnee MacOnochie MacOnohie MacPatre MacPeeters MacPeter MacPetir MacPetre MacPetri MacPetrie MacPhater MacPheadair MacPhedar MacPheddair MacRither MacRuar MacRudder MacRudrie MacRuer Magruder Makadam Makadame Makadem Makangus Makcaddam Makchonachy Makconchie Makconoch Makfleger Makgillevye Makgillewe Makgillewie Makgruder Makinlestar Makinnocater Maknae Maknee Makneis Makneisch Makneische Makneiss Makneissche Maknes Maknish Makonoquhy Makrudder Mallet Malloch Malloche Mallock Maloch Maloche Malyoch Maylloch Mickellduff Migrigar Mkkadam Mulloche Naische Naish Naos Neasch Neis Neische Neish Nes Nesche Ness Nies Niesh Nish Nucator Paitrie Patre Patrie Patry Peaddie Peat Peatrie Peattie Peddie Peddy Pedy Peit Peiter Peitt Pete Peter Petre Petree Petrie Petrye Petyr Rob Roy Valker Vconchie Waker Walcair Walcar Walcare Walcer Walkar Walker Walkster Waulcar White Whyte Whytt Whytte

MacGregor Of Glen Straye
Clan History: http://electricscotland.com/webclans/m/macgreg.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1025
Associated Names and Septs (with spelling variations):
Glenstrae

MacHardy
Clan History: http://electricscotland.com/webclans/m/machard.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=358
Associated Names and Septs (with spelling variations):
Hairdy Hardie Hardy Hardye MacArdie MacArdy MacBardie MacCarday MacCardie MacCardney MacCardy MacChardaidh MacChardy MacHarday MacHardie MacHardy MacKardie MacKhardie MacQhardies

MacInnes
Clan History: http://electricscotland.com/webclans/m/macinne.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=362
Associated Names and Septs (with spelling variations):
Aengus Ainas Anegos Anegous Anegus Angas Anggues Angous Anguis Angus Anguss Aonas Aonghas Aonghus Canch Keanish Kenish Kenneis Kennish Kinnes Kinnis MacAinish MacAinsh MacAnce MacAngus MacAnish MacAnsh MacAonghus MacCainsh MacCance MacCanch MacCanish MacCaniss MacCans MacCanse MacCansh MacCants MacHinch MacIlnaey MacInas MacInnes MacInnesh MacInness MacInnis MacInnisch MacInnish MacKance MacKants MacKanyss MacKinish MacKinnes MacKinness MacKinnis MacKinshe MacKmaster MacMagister MacMaster MacNeish MacQuinnes MacYnwiss Maistersone Maistertoun Maistertoune Maistertown Makangus Makanys Masterson Masterton Mastertone Naische Naish Naos Neasch Neis Neische Neish Nes Nesche Ness Nies Niesh Nish

MacInroy
Clan History: http://electricscotland.com/webclans/m/macinro.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=367
Associated Names and Septs (with spelling variations):
MacInroy Makeanroy

MacIntyre
Clan History: http://electricscotland.com/webclans/m/macinty.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=368
Associated Names and Septs (with spelling variations):
MacCosham MacCoshim MacEntyre MacInteer MacIntire MacIntyir MacIntyr MacIntyre MacKentyre MacKintyre MacOisein MacTear MacTeer MacTeir MacTer MacTere MacTeyr MacTier MacTire MacTyr MacTyre MacYntyre Makintare Makteir Makter Maktyre Mteir Ryght Tire Tyre Wiricht Wirrycht Wirryht Wirycht Wrecht Wreicht Wreight Wright

MacIver
Clan History: http://electricscotland.com/webclans/m/maciver.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=370
Associated Names and Septs (with spelling variations):
Euer Evar Evir Ewar Ewer Ewers Horie Hurray Hurrie Hurry Ivar Iver Iverach Iverson Ivirach Ivor Ivory Iwur MacAver MacCowir MacCuir MacCur MacCure MacEiver MacEuer MacEuir MacEur MacEure MacEvar MacEver MacEwer MacEwir MacEwyre MacGeever MacGiver MacGlasrich MacGlasserig MacGlassrich MacIvar MacIver MacIverach MacIvirach MacIvor MacKeaver MacKeever MacKeevor MacKeiver MacKeur MacKever MacKevor MacKevors MacKewer MacKewyr MacKiver MacKivers MacKivirrich MacKuir MacKure MacQuay MacQue MacQuee MacQuie MacUir MacUre MacWade MacWha MacWhae MacYuir Makcure Makewer Makiver Orr Orre Oure Ure Urie Urri Urrie Urry Yvar Yvir Ywar

MacKay
Clan History: http://electricscotland.com/webclans/m/mackay.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=375
Associated Names and Septs (with spelling variations):
Aue Ave Ay Aye Bain Baine Baines Bane Bayin Bayn Bayne Baynes Baynne Bean Beanes Beine Bene Bhaine Caw Coid Fail Fall Heth MacAllan MacAllane MacAoidh MacAth MacAw MacAy MacCa MacCaa MacCaidh MacCaoidh MacCaw MacCawe MacCay MacCey MacCoid MacCoy MacCue MacEda MacEth MacEthe MacFaell MacFail MacFal MacFale MacFall MacFaul MacFauld MacFaull MacFayle MacFoill MacFyall MacGaa MacGaw MacHeth MacIye MacKa MacKaa MacKaay MacKai MacKau MacKaw MacKawe MacKay MacKe MacKeay MacKee MacKeiy MacKew MacKey MacKie MacKphaill MacKy MacKye MacPaill MacPaul MacPhael MacPhaell MacPhail MacPhaile MacPhaill MacPhale MacPhaul MacPhaull MacPhayll MacPhell MacPhial MacPhiel MacQha MacQua MacQuade MacQuaid MacQuey MacQuhae MacQuid MacQuiod MacVail MacVale MacWhaugh MacWhaw MacWhey MacWhy MacYe Makaw Makay Makca Makcaw Makcawe Makcoe Makfaill Makfale Makfele Makie Makkaw Makkcae Makke Makkee Makkey Makkie Makphaile Maky Morgan Morgund Murgan Neelson Neillsone Neilson Neilsone Neilsoun Neilsoune Neleson Nelesoun Nelson Nelsone Nelsonne Nelsoun Neylsone Nickphaile Nielson Nilson Nilsone Nilsoune Nylson Pal Paul Paule Paull Paulson Paulsoun Poilson Poilsone Poilsoun Pol Pole Poleson Pollsoun Polson Polsone Polsoun Polsun Polyson Polysoun Poulson Quaid Quay Quoid Reay Strathnaver Vail

MacKeane
Clan History: http://electricscotland.com/webclans/m/mackean.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1207
Associated Names and Septs (with spelling variations):
MacKeane

MacKellar
Clan History: http://electricscotland.com/webclans/m/mackell.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=380
Associated Names and Septs (with spelling variations):
Ellar Kellar Keller MacAlar MacAllar MacCallar MacCellair MacCeller MacEalair MacEllar MacEllere MacKalar MacKelar MacKellar MacKellayr MacKeller MacKellor MacKillor Makallar Makelar Makkellar

MacKenzie
Clan History: http://electricscotland.com/webclans/m/mackenz.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=381
Associated Names and Septs (with spelling variations):
Cainnech Charleson Coinndech Coinneach Coinnidh Cromartie Cromarty Cromate Crumbacy Crumbathy Crummartie Euer Evar Evir Ewar Ewer Ewers Ivar Iver Iverson Ivirach Ivor Ivory Iwur Kennach Kennachtsoun Kennagh Kennauch Kenndochson Kenneochson Kenneth Kennethson Kennochsen Kineth Kyneth Kynnoch Kynoch MacArlich MacArliche MacAver MacBeolain MacCairlich MacCairlie MacCairly MacCarlach MacCarlich MacCarliche MacCarlie MacCarlycht MacCenzie MacCharles MacCharlie MacCherlich MacCoinnich MacConich MacConnach MacCowir MacCoynich MacCuir MacCur MacCurchie MacCure MacEinzie MacEiver MacEnzie MacEuer MacEuir MacEur MacEure MacEvar MacEver MacEwer MacEwir MacEwyre MacGeever MacGiver MacHerlick MacHerloch MacHinzie MacIvar MacIver MacIverach MacIvirach MacIvor MacKainzie MacKairlie MacKairly MacKanze MacKarlich MacKeanzie MacKearlie MacKearly MacKeaver MacKeever MacKeevor MacKeinezie MacKeinzie MacKeiver MacKenezie MacKenich MacKenyee MacKenyie MacKenzie MacKenzy MacKerley MacKerlich MacKerliche MacKerlie MacKerloch MacKeur MacKever MacKevor MacKevors MacKewer MacKewyr MacKinnoch MacKinyie MacKinze MacKinzie MacKiver MacKivers MacKivirrich MacKuir MacKure MacKwhinney MacKynich MacMhurchaidh MacMoroquhy MacMurachy MacMurchaidh MacMurchie MacMurchou MacMurchy MacMurd MacMurdo MacMurdoch MacMurdy MacMuredig MacMurphy MacMurquhe MacMurquhie MacMurtchie MacQuhenzie MacQuhine MacQuhinny MacQuhinze MacQuhynze MacTarlach MacTarlich MacTerlach MacThearlaich MacUir MacUrchie MacUrchy MacUre MacVanish MacVenish MacVennie MacVinie MacVinish MacVinnie MacVorchie MacVurchie MacWeeny MacWhinney MacWhinnie MacWhunye MacWhynie MacWinney MacWorthie MacWurchie MacYuir Makarlich Makcainze Makcanze Makcure Makeinny Makeinzie Makenze Makerliche Makewer Makiver Makkanze Makkennych Makkeny Makkenych Makkenze Makkinze Makkynnay Makmurche Makmurquhy Makquhinze Makquhynze Makvanis Mewhinney Mhurchaidh Mkenzi Murchad Murchadh Murchaidh Murcheson Murchesoun Murchie Murchieson Murchison Murchosone Murchosoun Murchy Murquhason Murquhasson Murquhessoun Murquhosoun Murtchie Orr Orre Oure Ure Urie Urri Urrie Urry Vcmurrochie Yvar Yvir Ywar

MacKerrel
Clan History: http://electricscotland.com/webclans/m/mackerr.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1403
Associated Names and Septs (with spelling variations):
MacKerral MacKerrel

MacKillop
Clan History: http://electricscotland.com/webclans/m/mackill.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=389
Associated Names and Septs (with spelling variations):
MacGillip MacGillop MacGilp MacKillib MacKillip MacKillop MacPhilib MacPhilip MacPhilipps MacPilips Makellop Makillip Makillop

MacKinlay
Clan History: http://electricscotland.com/webclans/m/mackinl.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=390
Associated Names and Septs (with spelling variations):
Clay Conlay Conley Donleavy Donlevy Dunleavy Dunslef MacAnally MacAnnally MacCannally MacClae MacClay MacCleay MacClew MacCollea MacConlea MacDimslea MacDonleavy MacDonnslae MacDunlane MacDunleavy MacDunlewe MacDunslea MacInally MacKeandla MacKindlay MacKinla MacKinlay MacKinley MacLae MacLay MacLea MacLeay MacLey MacNally MacOnlay Makdunlane Makdunlaue Makley

MacKinnon
Clan History: http://electricscotland.com/webclans/m/mackinn.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=392
Associated Names and Septs (with spelling variations):
Kinney Kinnie Kinnon Love MacCannan MacCannon MacFingan MacFingon MacFingone MacFinnan MacFinnen MacFinnon MacFyngoun MacInnon MacInvine MacKeenan MacKena MacKenen MacKeney MacKenie MacKenna MacKennah MacKennan MacKennane MacKennay MacKenney MacKinin MacKinna MacKinnay MacKinnen MacKinney MacKinnie MacKinning MacKinnon MacKinoun MacKinven MacKiynnan MacKmorran MacKynnay MacKynnie MacMoran MacMorane MacMoren MacMorin MacMorine MacMorran MacMorrane MacMorrin MacMoryn MacMoryne MacMurrin MacPhingone MacSherry MacShirie MacShirrie Makenone Makfingane Makfingoun Makkynine Makkynnon Makmorane Morin Morran Morren Morrin Murren

MacKintosh
Clan History: http://electricscotland.com/webclans/m/mackint.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=397
Associated Names and Septs (with spelling variations):
Adamson Adamsone Ademson Ademsoun Ademsoune Aesone Aison Aissone Aissoun Aissoune Ason Asone Asson Assone Aue Ave Ay Aye Ayesone Ayesoun Ayson Aysone Aysoun Ayssoun Chombeich Chombich Claerk Clark Clarke Clarkson Clarksone Clearkson Cleary Clerach Clerc Clerck Clercsone Cleric Clerie Clerk Clerke Clerkson Clerksone Clerksoun Clerksson Combach Combich Crarer Crear Creer Crerar Crerer Criathrar Dallas Dallass Dallyas Dolace Dolas Dolasse Dolays Doles Doleys Dollace Dolles Eason Easone Easson Eldar Eldare Elder Esson Galashan Glashan Glashen Glashin Glene Gleney Glenn Glennay Glennie Glenny Gleny Golane Golin Gollan Golland Gollane Gollin Gollon Hairdy Hardie Hardy Hardye Heagie Heagy Heegie Heggie Hegie Hegy Higgie Hosack Hosak Hosick Hossack Hossok Hossoke Ison Isone Kellas Kelles Knevan Leary MacAindreis MacAleerie MacAndrew MacAndrie MacAndro MacAndy MacArdie MacArdy MacAy MacBardie MacCagy MacCarday MacCardie MacCardney MacCardy MacChardaidh MacChardy MacChlerich MacChlery MacChombeich MacChombich MacChomich MacClachan MacClachane MacClathan MacClearey MacCleary MacClerich MacCleriche MacClerie MacClery MacClirie MacClurich MacCombich MacComiche MacComick MacComtosh MacConche MacConchie MacConchy MacCondach MacCondachie MacCondachy MacCondie MacCondochie MacCondoquhy MacConnchye MacConquhy MacConquy MacCreitche MacCulican MacCuligan MacCuligin MacCulikan MacCuliken MacEgie MacEleary MacGiligan MacGilleglash MacGillican MacGilligain MacGilligan MacGilligin MacGlashan MacGlashen MacGlashin MacGlassan MacGlassin MacGlasson MacGulican MacHarday MacHardie MacHardy MacHay MacHee MacHyntoys MacIlchomich MacIlleglass MacInclerich MacInclerie MacInclerycht MacInthosse MacIntioch MacIntoch MacIntoschecht MacIntoschie MacIntoschye MacIntosh MacKaggie MacKandrew MacKantoiss MacKardie MacKeggie MacKelecan MacKelegan MacKelican MacKentase MacKglesson MacKhardie MacKilican MacKilikin MacKillican MacKillicane MacKillichane MacKilligan MacKilligane MacKilligin MacKiltosche MacKintishie MacKintoch MacKintoche MacKintoisch MacKintorss MacKintosh MacKleiry MacKreiche MacKritchy MacKulican MacKuntosche MacKynioyss MacKyntoich MacKyntossche MacKyntoys MacLear MacLeary MacLerich MacLerie MacLglesson MacNaoimhin MacNeiving MacNevin MacNivaine MacNiven MacNoble MacOnchie MacQhardies MacReekie MacReiche MacRiche MacRichie MacRikie MacRitchey MacRitchie MacRitchy MacRyche MacThom MacThomaidh MacThomais MacThomas MacThome MacThomie MacToiche MacToschy MacToshy MacYnthosche MacYnthose MacYntoch MacYntoisch Makandro Makconchie Makintoch Makintoiche Makkintoische Maklearie Makryche Maktoiche Makulikin Makyntoische Makyntosh McIntosh Naomhin Neiven Neivin Nevane Nevein Neveine Nevene Nevin Nevins Nevinus Nevison Nevyn Nevyne Nevyng Newein Newin Newing Nifin Nivein Niven Niveson Nivine Niving Nivison Nobil Nobile Nobill Noble Rechie Rechtie Rechy Riche Richie Ritchie Rychy Rychze Rytchie Saythe Scaith Scayth Schau Schaw Schawe Scheoch Scheok Schiach Schioch Schioche Seah Seath Seith Seth Sha Shau Shaw Shawe Shay Sheach Sheath Sheehan Sheoch Shiach Siache Sith Sithach Sithech Sithig Skaith Sythach Sythag Sythock Tarall Taroll Tarrel Tarrell Tarrill Terale Terrel Terrell Terroll Toash Toische Toschach Tosche Toscheach Toscheoch Tosh Toshach Toshak Tosoch Tossoche Vconchie

MacKirdy
Clan History: http://electricscotland.com/webclans/m/mckirdy.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=405
Associated Names and Septs (with spelling variations):
Curdie MacCurdie MacCurdy MacCurthy MacKerdie MacKirdie MacKirdy MacKuerdy MacKurerdy MacKwarrathy MacMurtery MacMurtie MacMurtrie MacMutrie MacQuartie MacQuheritie MacQuhirertie MacQuhirirtie MacVarthie MacWerarthe MacWerarthie Makmurrarty Makwararthe Makwarartie Makwarrarty Makwerarty Makwrarty Makwrerdy

MacLachlan
Clan History: http://electricscotland.com/webclans/m/maclach.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=406
Associated Names and Septs (with spelling variations):
Cogann Eogan Eogann Eoghan Eoghann Eugene Eunson Eunsone Evan Evanson Evinson Ewain Ewan Ewen Ewenson Ewin Ewinesone Ewing Ewinn Ewinson Ewinsoun Ewisone Ewnesoune Ewynson Ewynsone Ewynsoun Gilchrist Gilcrist Gilcriste Gilcristes Gilcryst Gillchrist Gillechrist Gillecrist Gillecryst Keown Killecrist Lachaidh Lachann Lachie Lachillan Lachlainn Lachlan Lachlane Lachlann Lachlanson Lachlin Lachy Lauchlan Lauchland Lauchlanesone Lauchlein Laughlan Laughland Laughlin Lochlain Lochlan Lochlane Lochlann Loghlan Lohlan Louchelan MacClachlane MacClachlene MacClaichlane MacClauchlan MacClauchlane MacClauchlin MacCoun MacCuinn MacCune MacCunn MacCwne MacGilchrist MacGilcreist MacGilcrist MacGlauchlin MacGlauflin MacHlachlan MacIlchreist MacIlcrist MacKlawchlane MacKlawklane MacKlechreist MacLachan MacLachie MacLachlainn MacLachlan MacLachlane MacLachlin MacLackie MacLaghlan MacLauchan MacLauchlan MacLauchlane MacLauchleine MacLauchlen MacLauchlin MacLaughlan MacLaughland MacLaughlane MacLaughlin MacLawchtlane MacLlauchland MacLochlainn MacLochlin MacLoghlin MacLouchlan MacLoughlin MacQuckian MacQuikan MacUne MacYllecrist Makclachlane Makclauchlane Maklawchlane Vclauchlane Vclauchlayne

MacLaine Of Lochbuie
Clan History: http://electricscotland.com/webclans/m/maclain.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=412
Associated Names and Septs (with spelling variations):
Cormac Cormack Cormag Cormick Gilvray Lochbuie MacArmick MacCarmick MacCarmike MacChormaig MacClaine MacClan MacClane MacClayne MacComok MacCormack MacCormaic MacCormaig MacCormick MacCormock MacCormok MacCornick MacCornock MacCornok MacFadden MacFaden MacFadin MacFadion MacFadwyn MacFadyean MacFadyen MacFadyon MacFadzan MacFadzean MacFadzein MacFadzeon MacFattin MacFayden MacFedden MacFeyden MacFydeane MacGillane MacGillavary MacGillayne MacGillevary MacGillevoray MacGillevorie MacGillevray MacGillewra MacGillewray MacGillivary MacGillivoor MacGillivraid MacGillivray MacGillivrie MacGillivry MacGillowray MacGillvary MacGillveray MacGillvery MacGillvra MacGillvray MacGillyane MacGilvary MacGilvery MacGilvory MacGilvra MacGilvray MacGilwrey MacGormick MacGormock MacGuilvery MacIlaine MacIlbraie MacIliwray MacIllaine MacIllayn MacIlleain MacIllvra MacIloray MacIlra MacIluray MacIlveerie MacIlvery MacIlvora MacIlvory MacIlvra MacIlvrach MacIlvrae MacIlvray MacIlwra MacIlwray MacKelrae MacKermick MacKernock MacKlain MacKlan MacKlane MacKornock MacKornok MacLain MacLaine MacLane MacLayne MacOlaine MacOrmack MacPadane MacPaden MacPhadan MacPhadden MacPhaddion MacPhadein MacPhaden MacPhadzen MacPhaidein MacPhaiden MacPhaidin MacPhyden MacYlory Makarmik Makclane Makclayne Makcormok Makfadzane Makgillane Makillewray Makkilrow Maklane Maklayne Vcgillevorie

MacLaren
Clan History: http://electricscotland.com/webclans/m/maclare.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=413
Associated Names and Septs (with spelling variations):
Cririe Fade Faed Faid Fead Feid Fetridge Fied Gilfeather Gilfedder Giothbrith Godfraid Godfrey Goffraidh Gorey Gorre Gorrie Gorry Gothbrith Gowrie Guoroor Larrie Laurence Laurie Laurri Laury Lawrance Lawrence Lawrie Lawry Lowrey Lowrie MacArorie MacArory MacClaran MacClaren MacClarence MacClarene MacClarens MacClaring MacClarren MacClarron MacClawrane MacClearen MacCleron MacCorrie MacCorry MacCory MacCrary MacCreary MacCreerie MacCreery MacCreire MacCreirie MacCreory MacCrerie MacCrery MacCrire MacCririck MacCririe MacCriuer MacCrore MacCrorie MacCrory MacFaddrik MacFade MacFadrick MacFaid MacFait MacFaitt MacFate MacFater MacFather MacFatridge MacFead MacFeat MacFeate MacFeaters MacFederan MacFedran MacFeeters MacFetridge MacGilfatrick MacGilfatrik MacGillefatrik MacGillefedder MacGillepartik MacGillepatrick MacGillepatrik MacGillephadrick MacGillephadruig MacGillifudricke MacGilliphatrick MacGillphatrik MacGilparick MacGilphadrick MacGilpharick MacGorie MacGorre MacGorrie MacGorry MacGory MacGroary MacGrory MacGrury MacGyllepatric MacHpatrick MacIlfadrich MacIlfatrik MacIliphadrick MacIllepatrick MacIllephadrick MacIllephedder MacIllepheder MacIllephudrick MacIllfatrick MacIlliruaidh MacIlpadrick MacIlpatrick MacIlpedder MacKilpatrick MacKlarain MacKrory MacLabhrain MacLabhruinn MacLairen MacLaran MacLaren MacLarin MacLaring MacLauren MacLaurent MacLaurin MacLaurine MacLawhorn MacLawran MacLawrin MacLawrine MacLeran MacLern MacLeron MacLorn MacOlphatrick MacPaid MacPartick MacPatrick MacPeeters MacPhade MacPhadraig MacPhadrick MacPhadrig MacPhadrik MacPhadruck MacPhadruig MacPhadryk MacPhaid MacPhaide MacPhait MacPharick MacPhate MacPhater MacPhatrick MacPhatricke MacPhatryk MacPheadair MacPheadarain MacPheat MacPhedar MacPheddair MacPheddrin MacPhedearain MacPhederan MacPhedran MacPhedrein MacPhedron MacPheidearain MacPheidiran MacPheidran MacPheidron MacPhete MacPhoid MacRaurie MacRearie MacReary MacReirie MacRerie MacRiridh MacRirie MacRorie MacRory MacRourie MacRoyre MacRoyree MacRoyri MacRuairidh MacRuaraidh MacRuary MacRuidhri MacRurie MacRurry MacRury MacRyrie Makcrire Makerori Makfatrick Maklaurene Makpatrik Makreury Makririe Makrore Malpatric Meiklefatrick Meiklfatrick Padair Padan Padesone Padison Padon Padraig Padruig Padson Padyn Padyne Pait Paitt Paruig Patair Pate Patein Paten Paterson Patersone Patersoun Patersoune Patesone Patheson Pathruig Patieson Patirsone Patirsoun Patison Patisone Patisoune Paton Patone Patonson Patonsoun Patoun Patoune Patowne Patric Patrick Patrickson Patricksone Patricson Patrikson Patrison Patrisone Patrisoun Patrykson Patten Patterson Pattie Pattinson Pattison Pattisoune Patton Pattone Pattoun Pattoune Pattounsoun Pattowsone Paty Patynson Patyrson Pautoun Pawton Pawtonsoun Pawtoun Pawtoune Peathine Pedair Pedan Pedden Peden Pedin Petensen Pethein Pethin Petirsoun Phadair Ririe Rorie Rorison Rorrison Ryrie Vclaurent

MacLean
Clan History: http://electricscotland.com/webclans/m/maclean.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=421
Associated Names and Septs (with spelling variations):
Bay Beath Beathune Beathy Beaton Beatoun Beattone Beattoun Bethon Bethune Betoin Beton Betone Betoun Betown Betowne Betton Bettune Beutan Bey Bittoune Blac Black Blacke Blackie Blaick Blaik Blaike Blaikey Blaikie Blak Blake Blayk Clanachan Clanahan Clannachan Clanochan Clean Clenachan Clenaghan Clenochan Douie Dowie Dowy Duart Gildawie Gildowie Gilduff Gillan Gillean Gilledow Gilleduff Gillegowie Gilleon Gillian Gilyean Gilzean Gilzeane Leach Lean Leatch Lech Leche Leech Leeche Leetch Leiche Leitch Leitche Leyche Liche Liech Lietch Litch MacAldowie MacAldowrie MacAldowy MacAlduie MacBa MacBae MacBaith MacBathe MacBay MacBea MacBeath MacBeatha MacBeathy MacBee MacBeith MacBeth MacBetha MacBey MacBheath MacBheatha MacBheathain MacClan MacClane MacClean MacCleane MacClen MacCraing MacElduff MacGildhui MacGilduff MacGildui MacGilevie MacGilewe MacGilladubh MacGilldowie MacGilleathain MacGillebeatha MacGilledow MacGilleduf MacGilleduibh MacGillegowie MacGilleoin MacGilleon MacGilleone MacGilleoun MacGilleoune MacGillewe MacGillewey MacGillewie MacGillewy MacGillewye MacGilliduffi MacGilliewie MacGilligowie MacGilligowy MacGilliue MacGilliwie MacGillogowy MacGillon MacGilloyne MacGilvie MacGleane MacHilliegowie MacIlday MacIldeu MacIldeus MacIldew MacIldoui MacIldowie MacIldowy MacIldue MacIlduf MacIlduff MacIlduy MacIlergan MacIlewe MacIlghuie MacIlguie MacIlguy MacIllergin MacIllewe MacIllewie MacIllhuy MacIlliduy MacIllon MacKbayth MacKcline MacKeldey MacKeldowie MacKelein MacKildaiye MacKilday MacKilleane MacKlen MacKlin MacLean MacLeand MacLeane MacLein MacLen MacLene MacLergain MacLergan MacLin MacLyn MacMalduff MacOleane MacRaing MacRankein MacRankin MacRankine MacRanking MacRankyne MacTarlach MacTarlich MacTerlach MacThearlaich MacVanish MacVay MacVeagh MacVeay MacVeigh MacVenish MacVey MacVinish Maelbeth Makclean Makcleane Makclen Makgilleoin Makgilleon Makgilleone Makgilleoun Makgillevye Makgillewe Makgillewie Malbeth Melbeth Mickellduff Padan Padon Padyne Patein Paten Paton Patone Patonson Patonsoun Patoun Patoune Patowne Patton Pattone Pattoun Pattoune Pautoun Pawton Pawtoun Pawtoune Raincin Ramkein Ranequin Rankeine Ranken Rankene Rankesoun Rankin Rankine Ranking Rankinge Rankins Rankinson Rankyn Rankyne Rankynson Renkine Renkyn Rinking

MacLean Of Dochgarroch
Clan History: http://electricscotland.com/webclans/m/maclean.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=726
Associated Names and Septs (with spelling variations):
Gellion Gillon

MacLellan
Clan History: http://electricscotland.com/webclans/m/maclell.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=426
Associated Names and Septs (with spelling variations):
Bombie Cliland Gilelin Gilfalyn Gilfelan Gilfillan Gilfillane Gilfillian Gilfolan Gilfulain Gilfulan Gilland Gillefalyn Gillefillane Gillefillian Gillefolan Gilleland Gillephillane Gillifelan Gillilan Gilliland Gillphillan Gilphillan Guileland Guililand Guilliland Guliland Gulliland MacCulican MacCuligan MacCuligin MacCulikan MacCuliken MacGillelan MacGillelane MacGillfhaolain MacGillolane MacIlelan MacIleollan MacIlleland MacLalan MacLalland MacLallen MacLelan MacLeland MacLelane MacLelann MacLelen MacLellan MacLelland MacLellane MacLolan MacLolane Makellane Maklellan Maklellane Maklolayn

MacLennan
Clan History: http://electricscotland.com/webclans/m/maclenn.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=430
Associated Names and Septs (with spelling variations):
Clanachan Clenachan Clenaghan Clenden Clendon Clennan Clennen Clennin Clennon Clenochan Gilfinan Giliene Gilladamnan Gillefinan Gillenan Gillenen Gilligan Lagan Laggan Lenane Lennan Lennon Leonard Linden Loban Lobane Lobban Lobbans Lobein Lobon Logan Logane Loggan Loghane Loghyn Logyn Lopan Lowbane Lowgane MacAlinden MacAlinton MacAlonan MacClanachan MacClanaghan MacClanahan MacClanan MacClanaquhen MacClandon MacClannachan MacClannochan MacClannochane MacClannoquhen MacClanochan MacClanochane MacClanohan MacClanoquhen MacClenachan MacClenaghan MacClenaghen MacClenahan MacClenane MacClenden MacClendon MacCleneghan MacClenighan MacClennaghan MacClennan MacClennochan MacClennoquhan MacClennoquhen MacClenoquhan MacClinighan MacClonachan MacClunochen MacClynyne MacFingan MacFingon MacFingone MacFinnan MacFinnen MacFinnon MacGilelan MacGilfinan MacGiligan MacGillalane MacGilleanan MacGillenan MacGillican MacGilligain MacGilligan MacGilligin MacGillinnein MacGlenaghan MacGlenan MacGlennon MacGulican MacIllenane MacKelecan MacKelegan MacKelican MacKilican MacKilikin MacKillenane MacKillican MacKillicane MacKillichane MacKilligan MacKilligane MacKilligin MacKlanachen MacKlanan MacKlannan MacKlenden MacKlendon MacKlinnan MacKulican MacLanachan MacLanaghan MacLanaghen MacLannachen MacLanochen MacLanoquhen MacLeannaghain MacLenaghan MacLenane MacLenden MacLendon MacLenechen MacLennan MacLenochan MacLinein MacLinnen MacLonachin MacLyndon Makclennand Makulikin Winan Winning

MacLeod
Clan History: http://electricscotland.com/webclans/m/macleod.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=434
Associated Names and Septs (with spelling variations):
Bay Beath Beathune Beathy Beaton Beatoun Beattone Beattoun Bethon Bethune Betoin Beton Betone Betoun Betown Betowne Betton Bettune Beutan Bey Bittoune Caig Caskey Caskie Casskie Kaskie Leach Leatch Lech Leche Leech Leeche Leetch Leiche Leitch Leitche Leyche Liche Liech Lietch Litch MacAig MacAige MacAiskill MacAsgaill MacAsgill MacAsguill MacAskel MacAskie MacAskill MacAskin MacAskle MacCabe MacCaibe MacCaig MacCaige MacCasgill MacCasguill MacCaskall MacCaskel MacCaskell MacCaskie MacCaskil MacCaskill MacCaskin MacCaskle MacCaskull MacChrummen MacCleod MacCleoyd MacCleud MacCloaud MacCloid MacCloide MacCloor MacCloud MacClour MacCloyd MacCluir MacCluire MacClure MacCoag MacCoage MacCoaig MacCrimmon MacCruimein MacCrumen MacCuaig MacCuiag MacCuthaig MacGaskell MacGaskill MacGlade MacGrimen MacGrimmon MacGuaig MacHarold MacHarrold MacIloure MacKaig MacKaige MacKaigh MacKaiscal MacKaiskill MacKascal MacKaskil MacKaskill MacKaskin MacKcaige MacKeag MacKeeg MacKegg MacKeig MacKigg MacKleod MacKluire MacLeoad MacLeod MacLeoid MacLeot MacLeud MacLeur MacLewd MacLode MacLoed MacLoid MacLoir MacLoor MacLoud MacLoyde MacLude MacLuir MacLur MacLure MacRaild MacRaill MacRailt MacRalte MacRimmon Makcloid Makcluir Makeeg Makhaig Makkloud Maklure

MacLeod Of Assynt
Clan History: http://electricscotland.com/webclans/m/macleod.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1203
Associated Names and Septs (with spelling variations):
Assynt MacLeod

MacLeod Of Gesto
Clan History: http://electricscotland.com/webclans/m/macleod.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=891
Associated Names and Septs (with spelling variations):
Gesto MacLeod

MacLeod Of Lewis & Raasay
Clan History: http://electricscotland.com/webclans/m/macleod.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=439
Associated Names and Septs (with spelling variations):
Aulay Auleth Callam Callum Challum Corquodale Kerkyll MacAla MacAlay MacAliece MacAllay MacAlley MacAllum MacAuihlay MacAula MacAulay MacAule MacAuley MacAuliffe MacAulla MacAullay MacAully MacAwla MacAwlay MacCala MacCalla MacCallay MacCalley MacCallie MacCallome MacCallow MacCallum MacCally MacCalme MacCaluim MacCalume MacCaula MacCaulaw MacCaulay MacCauley MacCauly MacCawley MacCleod MacCleoyd MacCleud MacCloaud MacCloid MacCloide MacCloud MacCloyd MacColem MacCollom MacCollum MacColum MacCorcadail MacCorcadale MacCorcadill MacCordadill MacCoren MacCorkell MacCorker MacCorkil MacCorkill MacCorkindale MacCorkle MacCorley MacCorqudill MacCorquell MacCorquhedell MacCorquidall MacCorquidill MacCorquidle MacCorquodale MacCorquodill MacCorquydill MacCowley MacCullom MacCullum MacGawley MacGilcallum MacGillechallum MacGillechaluim MacGillichalloum MacIllechallum MacKalla MacKallay MacKaula MacKauley MacKleod MacKlowis MacKorkitill MacKorkyll MacKurkull MacLeoad MacLeod MacLeoid MacLeot MacLeud MacLewd MacLewis MacLode MacLoed MacLoid MacLoud MacLoyde MacLude MacOrkill MacOrquidill MacOrquodale MacQuorcadaill MacQuorquhordell MacQuorquodale MacQuorquordill MacThorcadail MacThorcuill MacThurkill MacTorquedil Makalley Makallum Makally Makcalla Makcaulay Makcloid Makcocadill Makcorcadell Makcorquidill Makcorquydill Makkalay Makkloud Mikcorcadill Molcallum Thorcull Tolmach Tolme Tolmi Tolmie Torquil

MacLeod Of Macleod
Clan History: http://electricscotland.com/webclans/m/macleod.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=440
Associated Names and Septs (with spelling variations):
MacLeod

MacLeod Of Raasay
Clan History: http://electricscotland.com/webclans/m/macleod.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1109
Associated Names and Septs (with spelling variations):
Raasay

MacLintock
Clan History: http://electricscotland.com/webclans/m/maclint.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=441
Associated Names and Septs (with spelling variations):
MacClintoch MacClintock MacGhillefhiondaig MacGilliondaig MacIlandick MacIllandick MacInlaintaig MacLentick MacLintoch MacLintock

MacMillan
Clan History: http://electricscotland.com/webclans/m/macmill.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=442
Associated Names and Septs (with spelling variations):
Bacster Baker Bakster Baxstair Baxstar Baxstare Baxster Baxtar Baxter Bel Bele Bell Belle Bleu Blue Braun Bron Brouin Broun Broune Brown Browne Browyn Brun Brune Brwne Fuccatour Fuckater Fugater Fugatour Fuggatour Fuktor Fuktour Futtor MacBaxtar MacBaxter MacFaktur MacFuktor MacFuktur MacGhilleghuirm MacGilleghuirm MacGilliegorm MacIlvail MacIngvale MacInnocater MacInnowcater MacInnowcatter MacInnugatour MacInocader MacInuctar MacInucter MacInvaille MacInvale MacInville MacKmillan MacKnockater MacKnocker MacKnockiter MacMhaolain MacMigatour MacMilane MacMillan MacMilland MacMillen MacMillin MacMillon MacMolan MacMolane MacMolland MacMuckater MacMulan MacMulane MacMullan MacMullen MacMullin MacMullon MacMuncater MacMuncatter MacMungatour MacMylan MacMyllan MacMyllane MacNamaoile MacNamell MacNamil MacNamill MacNaucater MacNomiolle MacNomoille MacNowcater MacNowcatter MacNucadair MacNucater MacNucator MacNucatter MacNuctar MacNuicator MacVaxter Makbaxstar Makinnocater Makmilane Makmillem Makmulane Makmullane Makmylan Makmyllan Makmyllane Makmyllen Nucator Valker Waker Walcair Walcar Walcare Walcer Walkar Walker Waulcar

MacNab
Clan History: http://electricscotland.com/webclans/m/macnab.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=443
Associated Names and Septs (with spelling variations):
Abarcrumbie Abarcrumby Abbot Abbotson Abbott Abbottson Abercrombie Abercromby Abercrombye Abercrummye Abircromby Abircromme Abircromy Abircromye Abircrumby Abircrumbye Abircrummy Abircrumy Dewar Deware Dewere Dochard Dochart Gilelin Gilfalyn Gilfelan Gilfillan Gilfillane Gilfillian Gilfolan Gilfulain Gilfulan Gilland Gillefalyn Gillefillane Gillefillian Gillefolan Gilleland Gillephillane Gillifelan Gillilan Gilliland Gillphillan Gilphillan Guileland Guililand Guilliland Guliland Gulliland Jore MacAnaba MacAndeoir MacGeorge MacIndeoir MacIndeor MacIndoer MacJore MacKnabe MacNab MacNabb MacNap Makinnab Maknabe Milnab

MacNaughton
Clan History: http://electricscotland.com/webclans/m/macnach.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=447
Associated Names and Septs (with spelling variations):
Eanrig Eanruig Enrick Henderson Hendersone Hendersonne Hendersoun Hendersoune Hendery Hendirsone Hendirsoune Hendrie Hendrisoune Hendry Henersoun Hennersoune Hennryson Henresoun Henreysoun Henriesoun Henrison Henrisone Henrisoun Henrisoune Henry Henryesson Henryson Henrysoun Inrick Inrig Kendrick Kenrick Knevan MacBrain MacBraine MacBrayan MacBrayne MacBreyane MacBreyne MacCanrig MacCanrik MacCans MacCanse MacCansh MacCants MacCeol MacCoal MacCoel MacCraccan MacCrachan MacCrachen MacCrackan MacCracken MacCraikane MacCraken MacCrekan MacCrekane MacCrokane MacEanruig MacEnrick MacEol MacHendric MacHendrie MacHendry MacHenrie MacHenrik MacHenry MacHnight MacInair MacInayr MacInnuer MacInnuier MacInnyeir MacInuair MacInuar MacInuire MacInuyer MacKanrig MacKendric MacKendrich MacKendrick MacKendrie MacKendrig MacKendry MacKenrick MacKeracken MacKnach MacKnacht MacKnaer MacKnaight MacKnair MacKnaire MacKnaught MacKnaughtane MacKnawcht MacKnaycht MacKnayt MacKneicht MacKnicht MacKnight MacKnitt MacKrachin MacKraken MacKrekane MacKynnair MacKynnayr MacNachdan MacNacht MacNachtan MacNachtane MacNachtin MacNachton MacNaght MacNaghtane MacNaghten MacNaicht MacNaichtane MacNaight MacNail MacNair MacNait MacNaoimhin MacNar MacNare MacNatt MacNauch MacNauche MacNauchtan MacNauchtane MacNauchton MacNaught MacNaughtan MacNaughten MacNaughton MacNauth MacNauton MacNayair MacNayer MacNayr MacNayre MacNeacain MacNeacden MacNeachdainn MacNeachden MacNear MacNeer MacNeid MacNeight MacNeir MacNeit MacNeiving MacNett MacNeur MacNevin MacNewer MacNicht MacNight MacNitt MacNivaine MacNiven MacNorton MacNoyar MacNoyare MacNoyiar MacNuer MacNuir MacNuire MacNure MacNutt MacNuyer MacNvyr MacQuaker MacQwaker MacVicar MacVicker MacWiccar Makanry Makbrehin Makcrakan Makcrakane Makcraken Makenaght Makfikar Makhenry Makknacht Makknaicht Maknacht Maknachtan Maknair Maknare Maknath Maknauch Maknaucht Maknayr Maknech Maknewar Maknoyar Makwicar Makynnair Naomhin Naughton Neiven Neivin Nevane Nevein Neveine Nevene Nevin Nevins Nevinus Nevison Nevyn Nevyne Nevyng Newein Newin Newing Nifin Nivein Niven Niveson Nivine Niving Nivison Portair Portar Porter Vair Veir Vere Veyre Vicarson Wair Ware Wayre Wear Weare Weer Weir Weire Were Werr Weyir Weyr Whier Wier Wir Wire

MacNeil Of Barra
Clan History: http://electricscotland.com/webclans/m/macneil.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=463
Associated Names and Septs (with spelling variations):
Gugan MacGougan MacGrail MacGreal MacGreil MacGreill MacGuckin MacGugan MacGuigan MacGuoga MacKneale MacKnilie MacKnily MacNail MacNaill MacNale MacNeal MacNeale MacNeall MacNeel MacNeelie MacNeil MacNeill MacNeille MacNeillie MacNeilly MacNele MacNelly MacNely MacNeyll MacNial MacNiel MacNielie MacNillie MacNily MacReil MacReill MacReull Magneill Magreill Makneill Maknely Makneyll Maknill Nail Neal Neale Neil Neill Neilly Niall Niel Roderick

MacNeil Of Colonsay
Clan History: http://electricscotland.com/webclans/m/macneil.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=867
Associated Names and Septs (with spelling variations):
Colonsay

MacNicol
Clan History: http://electricscotland.com/webclans/m/macnico.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=467
Associated Names and Septs (with spelling variations):
MacNeacail MacNicail MacNiccoll MacNichol MacNichole MacNicholl MacNickle MacNicol MacNicoll MacNychol MacNychole MacNycholl Maknichol Maknicoll Maknychol Maknycholl Neclason Neclasson Necolson Nichol Nicholay Nichole Nicholl Nicholson Nicholsone Nicholsoun Nickle Niclasson Nicol Nicole Nicoll Nicollsoun Nicolson Nuccol Nucholl Nuckall Nuckle Nucolson Nycholay Nycholl Nycholson Nycholsoun

MacNiven
Clan History: http://electricscotland.com/webclans/scotsirish/navin.htm
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=779
Associated Names and Septs (with spelling variations):
Neiven Neivin Nevane Nevein Neveine Nevene Nevin Nevins Nevinus Nevison Nevyn Nevyne Nevyng Newein Newin Newing Nifin Nivein Niven Niveson Nivine Niving Nivison

MacPhail
Clan History: http://electricscotland.com/webclans/m/macphai.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=470
Associated Names and Septs (with spelling variations):
Fail Faill Fall MacFaell MacFail MacFal MacFale MacFall MacFaul MacFauld MacFaull MacFayle MacFoill MacFyall MacKphaill MacPaill MacPaul MacPaule MacPawle MacPhael MacPhaell MacPhail MacPhaile MacPhaill MacPhale MacPhaul MacPhaull MacPhayll MacPhell MacPhial MacPhiel MacVail MacVale Makfaill Makfale Makfele Makphaile Nickphaile Pal Paul Paule Paull Pol Pole Vail

MacPherson
Clan History: http://electricscotland.com/webclans/m/macpher.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=473
Associated Names and Septs (with spelling variations):
Alees Aleese Caidh Cananaich Carson Catan Catanach Catanache Catanoch Cate Cathan Catnach Cattan Cattanach Cattanoch Cattenach Cattenoch Ceiteach Claerk Clark Clarke Clarkson Clarksone Clearkson Cleary Clerach Clerc Clerck Clercsone Cleric Clerie Clerk Clerke Clerkson Clerksone Clerksoun Clerksson Clunie Clunnie Cluny Clwny Clwnye Couric Curie Curray Curre Curri Currie Curry Currye Feresoun Fersen Ferson Galeaspe Gellas Ghillaspic Gilasp Gilaspy Gilhaspy Gilhespy Gilies Gilise Gilispie Gillas Gillaspik Gillaspy Gilleis Gilles Gillespey Gillespie Gillice Gillie Gillies Gilliosa Gillis Gillise Gilliss Gove Gow Gowan Gowans Gowen Gowie Gowin Gylis Gyllis Kayt Keathe Keht Keith Ket Keth Kethe Keyth Keythe Keytht Kite Leary Lees Lios MacAleerie MacAlees MacAliece MacA'Phearsain MacA'Phearsoin MacAppersone MacBurie MacChananaich MacChlerich MacChlery MacClearey MacCleary MacCleche MacClees MacCleiche MacCleisch MacCleish MacCleishe MacCleisich MacClerich MacCleriche MacClerie MacClery MacClese MacCleys MacCliesh MacClirie MacClurich MacColeis MacColleis MacCourich MacCurich MacCurie MacCurrach MacCurragh MacCurrich MacCurrie MacCurry MacEleary MacElpersoun MacFarsane MacFarsne MacFarson MacFerson MacFersoune MacForsoun MacFuirigh MacGabhawn MacGhobhainn MacGhowin MacGillas MacGilleis MacGillese MacGillies MacGillis MacGillish MacGleish MacGouan MacGoun MacGoune MacGovin MacGow MacGowan MacGowen MacGown MacGowne MacGowy MacHillies MacIlees MacIleish MacIlishe MacIllees MacIlleese MacIlleish MacInclerich MacInclerie MacInclerycht MacInferson MacKeith MacKethe MacKilferson MacKinfarsoun MacKleiry MacKperson MacKpharsone MacKurrich MacKury MacLear MacLeary MacLeash MacLeerie MacLees MacLeesh MacLeich MacLeish MacLerich MacLerie MacLese MacLess MacLise MacLish MacLiss MacMhourich MacMhuireadhaigh MacMhuirich MacMhuirrich MacMordoch MacMuiredhaigh MacMuiredhuigh MacMuirigh MacMurich MacMurrich MacMurriche MacMurrycht MacOurich MacPearson MacPerson MacPersone MacPersonn MacPharson MacPhearson MacPhersen MacPherson MacPhersone MacUirigh MacUrich MacVarraich MacVarrich MacVeirrich MacVirrich MacVirriche MacVoerich MacVorich MacVoriche MacVorrich MacVourich MacVurich MacVurie MacVurirch MacVuririch MacVurrich MacVurriche MacWirrich MacWirriche MacWurie Makcurrie Makfarson Makfassane Makfersan Makfersone Makfersoun Makferssoun Makghobhainn Makgowane Makgowin Makimpersone Maklearie Makleis Makmurdie Makmurriche Makmurthe Makphersone Makvirriche Makynparsone Mordac Mordake Mordik Mordoc Mordok Mordyk Moreduc Morthaich Mourdac Muireach Muireadhach Muiredach Murdac Murdak Murdoc Murdoch Murdock Murdoson Murdy Murreich Murthac Murthak Pairsone Pearsain Pearson Pearsone Peirson Peirsond Peirsonde Peirsone Peirsoun Peirsound Peirsounde Peresone Perison Perisone Person Persone Persoun Peryson Perysoun Peyrson Peyrsoune Pieresone Pierson Pirieson Piriesoun Smeayth Smith Smyith Smyithe Smyth Smythe Versen

MacPhie
Clan History: http://electricscotland.com/webclans/m/macfie.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=483
Associated Names and Septs (with spelling variations):
Cathay Cathey Cathie Cathy Duffie Duffy Fee MacAfee MacAffie MacAphie MacCaffe MacCaffie MacCathay MacCathie MacCathy MacChaffie MacCuffie MacDuffee MacDuffie MacDuffy MacDuphe MacDuthie MacFee MacFey MacFeye MacFie MacGuffey MacGuffie MacGuffoc MacGuffock MacGuffog MacHaffey MacHaffie MacHaffine MacIlhaffie MacIphie MacKilhaffy MacKuffie MacPhee MacPhie MacVee MacVie Mahaffey Mahaffie Mahalfie Makcathie Milhaffie

MacQuarrie
Clan History: http://electricscotland.com/webclans/m/macquar.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=939488455
Associated Names and Septs (with spelling variations):
Giothbrith Godfraid Godfrey Goffraidh Gorey Gorre Gorrie Gorry Gothbrith Guoroor MacCoirry MacCorrie MacCorry MacCory MacGorie MacGorre MacGorrie MacGorry MacGory MacGuaran MacGuarie MacGuarrie MacGuire MacGuire MacOuhir MacQuaire MacQuarie MacQuarrane MacQuarrey MacQuarrie MacQueir MacQueir MacQuharrie MacQuharry MacQuhir MacQuhir MacQuhirr MacQuhirr MacQuhirrie MacQuhoire MacQuhore MacQuhorie MacQuhorre MacQuire MacQuire MacQuore MacQuorie MacQuorrie MacQurrie MacQuyre MacQuyre MacUidhir MacUidhir MacWarie MacWharrie MacWheir MacWheir MacWhir MacWhire MacWhire MacWhirr MacWhirrie Maguire Maguire Makcorry Makcory Makquharie Makquharry Makquhary Makquhory Makquoyrie Makquyre Makquyre Makwir Quarrie Quarry Quharrie Quharry Quherrie Wharrie

MacQuarrie
Clan History: http://electricscotland.com/webclans/m/macquar.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=488
Associated Names and Septs (with spelling variations):
Giothbrith Godfraid Godfrey Goffraidh Gorey Gorre Gorrie Gorry Gothbrith Guoroor MacCoirry MacCorrie MacCorry MacCory MacGorie MacGorre MacGorrie MacGorry MacGory MacGuaran MacGuarie MacGuarrie MacGuire MacGuire MacOuhir MacQuaire MacQuarie MacQuarrane MacQuarrey MacQuarrie MacQueir MacQueir MacQuharrie MacQuharry MacQuhir MacQuhir MacQuhirr MacQuhirr MacQuhirrie MacQuhoire MacQuhore MacQuhorie MacQuhorre MacQuire MacQuire MacQuore MacQuorie MacQuorrie MacQurrie MacQuyre MacQuyre MacUidhir MacUidhir MacWarie MacWharrie MacWheir MacWheir MacWhir MacWhire MacWhire MacWhirr MacWhirrie Maguire Maguire Makcorry Makcory Makquharie Makquharry Makquhary Makquhory Makquoyrie Makquyre Makquyre Makwir Quarrie Quarry Quharrie Quharry Quherrie Wharrie

MacQueen
Clan History: http://electricscotland.com/webclans/m/macquee.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=491
Associated Names and Septs (with spelling variations):
MacCuidhean MacCuinn MacCuithean MacCuithein MacCune MacCunn MacCuthan MacCwne MacGuin MacHquan MacHquhan MacHuin MacKqueane MacKquyne MacQuain MacQuan MacQuaynes MacQuean MacQueane MacQueen MacQueeney MacQueenie MacQuein MacQueine MacQuen MacQuene MacQueyn MacQueyne MacQuhan MacQuheen MacQuhen MacQuhenn MacQuhenne MacQuheyne MacQuhyn MacQuhyne MacQuien MacQuin MacQuine MacQuinne MacSayde MacSeveney MacShuibhne MacSuain MacSuin MacSwain MacSwaine MacSwan MacSwane MacSween MacSwen MacSweyne MacSwyde MacSwyne MacUne MacWhan MacWhanne MacWhin MacWhinn Makquean Makquene Makquhan Makquhane Makquhen Makquhon Maquhon Quin Quinn Revan Revans Suain Svan Sveinn Swain Swan Swane Swann Swayne Sween Swein Sweing Swen Sweyn Sweyne Swyde Swyn Swyne

MacRae
Clan History: http://electricscotland.com/webclans/m/macrae.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=498
Associated Names and Septs (with spelling variations):
Crae MacAra MacAree MacArra MacCara MacCarra MacCarres MacCary MacChray MacCra MacCrae MacCraie MacCraith MacCrath MacCraw MacCray MacCrea MacCreath MacCree MacCreich MacCreiff MacCreith MacCrie MacCrow MacCroy MacGra MacGrae MacGrath MacGraw MacGreagh MacHray MacKcrae MacKcrow MacKra MacKrae MacKraith MacKray MacKrayth MacKree MacKrie MacRa MacRach MacRad MacRae MacRah MacRaht MacRaith MacRath MacRau MacRaw MacRay MacRe MacRea MacReath MacReay MacRee MacReith MacReth MacRey MacRie MacRoe MacRow MacRoy MacWray Magrath Makcra Makcreith Makcrie Makerathe Makra Makraa Makrath Makreith Rae Raith Ray Rea Reath Reay Ree Reith Reithe Rethe Reyth Wrae Wray

MacRae Of Conchra
Clan History: http://electricscotland.com/webclans/m/macrae.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1029
Associated Names and Septs (with spelling variations):
Conchra

MacRae Of Inverinate
Clan History: http://electricscotland.com/webclans/m/macrae.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1299
Associated Names and Septs (with spelling variations):
Inverinate

MacSporran
Clan History: http://electricscotland.com/webclans/m/macspor.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=509
Associated Names and Septs (with spelling variations):
MacSporran Porcel Porcell Purcell Pursel Pursell Pursill Sporran

MacTaggart
Clan History: http://electricscotland.com/webclans/m/mactagg.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=510
Associated Names and Septs (with spelling variations):
MacIntagart MacIntagerit MacIntargart MacKinsagart MacKintaggart MacKyntagart MacKyntaggart MacSagart MacTagart MacTaggard MacTaggart MacTaggate MacTaggert MacTaggit Makintalgart Myketagart Tagart Taggart Taggert Tegart Teggart

MacTavish
Clan History: http://electricscotland.com/webclans/m/mactavi.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=511
Associated Names and Septs (with spelling variations):
Hawes Haws Hawson Hawsone MacAves MacAvis MacAvish MacAwis MacAwishe MacAws MacCaueis MacCauish MacCause MacCavis MacCavish MacCavss MacCaweis MacCawis MacCaws MacGilchois MacGilhosche MacGillhois MacIlhaos MacIlhois MacIlhoise MacIlhose MacIlhouse MacIllhois MacIllhos MacIllhose MacKawes MacKilhoise MacKillhose MacKlehois MacLehose MacTaevis MacTamhais MacTause MacTaveis MacTavish MacTawisch MacTawys MacThamais MacThamhais MacThavish Makavhis Makawis Makcaus Makcawis Makcaws Makcawys Makgilhois Makgilhoise Micklehose Mucklehose Taes Tais Taise Taish Taiss Tam Tameson Tamesone Tamson Tamsone Taus Taweson Tawesson Tawis Taws Tawse Tawseon Tawseson Tawson Tawst Tawus Thomason Thomasson Thomassone Thomassoun Thomessone Thompson Thomson Thomsone Thomsoun Thomsoune Thomsson Tomson Tomsone

MacThomas
Clan History: http://electricscotland.com/webclans/m/macthom.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=513
Associated Names and Septs (with spelling variations):
Chombeich Chombich Chombie Comb Combach Combe Combich Combie MacChomay MacChombeich MacChombich MacChomich MacColm MacColme MacColmie MacColmy MacComaidh MacComais MacComas MacComash MacComb MacCombe MacCombich MacCombie MacCombs MacCome MacComes MacComey MacComiche MacComick MacComie MacComish MacComy MacHomas MacHomash MacHomie MacIlchombie MacIlchomich MacIlchomie MacIlchomy MacKomash MacKomie MacKommie MacKomy MacOmie MacOmish MacThom MacThomaidh MacThomais MacThomas MacThome MacThomie MacTomais Makcome Makcomius Makthome Makthomy Tam Tameson Tamesone Tamson Tamsone Thom Thomas Thomason Thomasson Thomassone Thomassoun Thome Thomessone Thompson Thoms Thomson Thomsone Thomsoun Thomsoune Thomsson Thowmis Thowms Tomson Tomsone

MacWhirter
Clan History: http://electricscotland.com/webclans/m/mcwhirt.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=515
Associated Names and Septs (with spelling variations):
MacChritter MacChruitar MacChruiter MacChruter MacChruytor MacChrytor MacChurteer MacClarsair MacCrotter MacHrurter MacHruter MacInchruter MacQharter MacQherter MacQuarter MacQuhartoune MacQuhirtir MacQuhirtour MacQuhirtoure MacQuhorter MacQuhriter MacQuirter MacRuter MacWhirter MacWhirtour MacWhorter MacWhrurter MacWhyrter MacWirter Makrutour Makrutur Mewhirter Whirter

MacWilliam
Clan History: http://electricscotland.com/webclans/m/macwilliam.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=516
Associated Names and Septs (with spelling variations):
MacCuilam MacCulliam MacCullie MacCulzian MacKilliam MacKwilliam MacQuilliam MacUilam MacUilleim MacVillie MacWilliam MacWilliame MacWilliams MacWillie MacWyllie Makwilliam Makwillie Wiley Willameson Willeamsoun Williamson Williamsone Willie Willyamsone Wily Wilyamson Wilyemsoun Wylie Wyllie Wylly Wyllyamson Wyly Wylye

Maguire
Clan History: http://electricscotland.com/webclans/scotsirish/maguire.htm
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1218
Associated Names and Septs (with spelling variations):
Maguire

Maitland
Clan History: http://electricscotland.com/webclans/m/maitlan.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=517
Associated Names and Septs (with spelling variations):
Lauderdale Maitland Maltland Mateland Matelande Matheland Matilland Matillande Matlain Matland Mauteland Mautelande Mautelent Mautlent Metellan Metlan Mettlin

Malcolm
Clan History: http://electricscotland.com/webclans/m/maccall.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=518
Associated Names and Septs (with spelling variations):
Callam Callum Challum MacAllum MacCalim MacCallome MacCallum MacCalme MacCaluim MacCalume MacColem MacCollom MacCollum MacColum MacCullom MacCullum Makallum Malcolm Malcolmson Molcallum

Mar
Clan History: http://electricscotland.com/webclans/m/mar.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=519
Associated Names and Septs (with spelling variations):
Alanach Alenach Allanach Allanache Allanock Allenoch Aricari Auchterarne Bartill Bonach Cunach Durrat Eggo Ego Egoson Ergo Ferrar Garioch Garrioch Gerrie Gerry Haraldson Ledigan MacGaraidh Mar Marr Skaid Sked Sleaster Tais Taise Taiss

Marshall
Clan History: http://electricscotland.com/webclans/m/marshall.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=520
Associated Names and Septs (with spelling variations):
Marchael Marchall Marchell Marschal Marschale Marschel Marschell Marshall Merchel Merchell Merschaell Merschale Merschell Mershael Mershell

Martin
Clan History: http://electricscotland.com/webclans/m/martin.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1409
Associated Names and Septs (with spelling variations):
MacMartin Martin

Matheson
Clan History: http://electricscotland.com/webclans/m/matheso.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=521
Associated Names and Septs (with spelling variations):
Bairnson MacBirnie MacBurnie MacMahon MacMath MacMathon MacMhathain Massey Matheson Mathewson Mathie Mathieson Mathison Mathyson Matthews Matthewson Moannach

Maxwell
Clan History: http://electricscotland.com/webclans/m/maxwell.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=523
Associated Names and Septs (with spelling variations):
Adair Blackstock Dinwiddie Dinwoodie Dunwoodie Edgar Egarr Halldykes Herries Kirk Kirkdale Kirkhaugh Kirkland Kirko MacEtterick MacEttrick MacGetrick MacGetrick MacGettrich MacGettrick MacGhittich MacHethrick MacIttrick MacKeswal MacKethrick MacKetterick MacKitterick MacKitterick MacKittrick MacSata MacSetree Makiswel Makiswell Makkiswell Maxey Maxon Maxton Maxuel Maxvall Maxvile Maxwaile Maxwale Maxweel Maxwell Monreith Moss Paulk Peacock Poak Pogue Poke Polk Polk Pollock Pollok Sturgeon Wardlaw

Melville
Clan History: http://electricscotland.com/webclans/m/melvill.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=524
Associated Names and Septs (with spelling variations):
Mailueil Mailuil Mailuile Mailuill Mailuille Mailvene Mailveyne Mailvil Mailvile Mailvin Mailvyll Mailvyne Mailwill Mailwyn Mailwyne Maleuile Maleuyll Malevil Malevyle Malevyn Malevyne Malewile Maling Malling Mallwill Maluel Maluile Maluill Maluiyll Malveyn Malvil Malvile Malvyle Malvyn Malvyne Malwill Malwyle Malwyn Malwyne Meiluill Mellen Mellon Mellwell Meluile Meluill Melven Melville Melvin Melving Melvyne Melwene Melwill Melwin Melwing Melwyn Melwyne

Menzies
Clan History: http://electricscotland.com/webclans/m/menzies.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=526
Associated Names and Septs (with spelling variations):
Dewar Deware Dewere Jore MacAndeoir MacIndeoir MacIndeor MacIndoer MacJore MacKmunish MacMean MacMeans MacMein MacMeinn MacMen MacMenzies MacMin MacMina MacMine MacMinn MacMinne MacMinnies MacMinnis MacMonies MacMonnies MacMyn MacMyne MacMynneis Mainzies Makmunish Makmynnes Manzie Manzies Maynhers Mean Meanie Meanies Means Megnies Meignees Meigneis Meigners Meignerys Meignes Meignez Mein Meine Meineris Meingnes Meingzeis Meingzes Meinn Meinyeis Meinyies Meinzeis Meinzies Menees Mengues Mengyeis Mengzeis Mengzes Mengzies Mennes Mennie Menyas Menyeis Menyheis Menyhes Menzas Menzeis Menzes Menzeys Menzheis Menzhers Menzies Menzis Meygners Meygnes Meyneiss Meyner Meyneris Meyners Meyness Miners Minn Minnis Minnish Minnus Monsie Monzie Munnies

Mercer
Clan History: http://electricscotland.com/webclans/m/mercer.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1165
Associated Names and Septs (with spelling variations):
Anderson Kinnedier

Middleton
Clan History: http://electricscotland.com/webclans/m/middlet.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=531
Associated Names and Septs (with spelling variations):
Mediltoune Middleton Mideltowne Midilton Midiltoun Midtoun Myddiltoun Myddiltoune Mydilton

Milne
Clan History: http://electricscotland.com/webclans/m/milne.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1411
Associated Names and Septs (with spelling variations):
Milne

Mitchell
Clan History: http://electricscotland.com/webclans/m/mitchel.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=532
Associated Names and Septs (with spelling variations):
Mechel Meitchel Michell Michill Mitchell Mitchol Mitschael Mitsschal Mittchel Mychell Mytchell

Moffat
Clan History: http://electricscotland.com/webclans/m/moffat.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=533
Associated Names and Septs (with spelling variations):
Maffat Maffatt Maffet Maffett Maffit Maffitt Meffat Meffet Moffat Moffatt Moffet Moffett Moffit Moffitt Moffot Moffut Morphatt Morphet Morphett Morphit Morphitt Muffat Muffatt Muffet Muffett Offut Offutt

Moncrieff
Clan History: http://electricscotland.com/webclans/m/moncrei.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=534
Associated Names and Septs (with spelling variations):
Monchryf Moncref Moncrefe Moncreife Moncreiff Moncreiffe Moncrief Moncriefe Moncrieff Moncrieffe Moncrif Moncrife Moncriffe Monkreff Monkreth Montcreffe Montcrief Montcrif Mouncref Muncrefe Muncreff Muncreif Muncreiffe Muncreyfe Muncrif Muncrife Munkrethe

Montgomery
Clan History: http://electricscotland.com/webclans/m/montgom.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=536
Associated Names and Septs (with spelling variations):
Eglington Eglinton Eglintoun Eglunstone Eglynton Eglyntone Eglyntoun Eglyntoune Gaemory Garmory Garmurie Garmury Germory Germurie MacCuimrid MacGarmorie MacGarmory MacGermorie MacGomerie MacGomery MacGumeraitt Makgarmory Mongumre Mongumrie Montegomorry Montegoumeri Montgomerie Montgomery Montgomrie Montgomry Montgumery Montgumre Montgumrie Montgumry Montgumrye Montgurie Monthgumry Mountgomrie Mundgumbry Mundgumri Mungumbry Mungumre Mungumri Mungumry Muntgomery

Morgan
Clan History: http://electricscotland.com/webclans/m/morgan.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=537
Associated Names and Septs (with spelling variations):
Monorgund Morgan Morgund Murgan

Morrison
Clan History: http://electricscotland.com/webclans/m/morriso.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=538
Associated Names and Septs (with spelling variations):
Breive Brieve Gillamor Gillemoire Gillemor Gillemore Gillemur Gillemure Gilmer Gilmoir Gilmor Gilmore Gilmour Gilmoure Gilmur Gilmure Gylmor MacBreive MacBrieve MacGilmor MacIllimhier Morison Morrieson Morrison Murieson Murison Murrison

Mow
Clan History: http://electricscotland.com/webclans/m/mow.htm
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1283
Associated Names and Septs (with spelling variations):
Mollans

Mowat
Clan History: http://electricscotland.com/webclans/m/mowat.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=539
Associated Names and Septs (with spelling variations):
Meuatt Mohuat Mouat Mouatt Mout Movat Mowait Mowaite Mowat Mowatt Mowet Mowit

Mowbray
Clan History: http://electricscotland.com/webclans/m/mowbray.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=540
Associated Names and Septs (with spelling variations):
Mobray Moubray Mowbray

Muir
Clan History: http://electricscotland.com/webclans/m/muir.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=541
Associated Names and Septs (with spelling variations):
Moar Moare Moer Moir Moire Moor Moore More Moure Muir Muire Mur Mure Myre

Munro
Clan History: http://electricscotland.com/webclans/m/munro.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=543
Associated Names and Septs (with spelling variations):
Culloch Dinguel Dingvaile Dingvaille Dingval Dingvale Dingvall Dingvell Dingwall Dingwell Dungwail Dyngvale Dyngwaile Dyngwale Faulis Fawlis Follis Foules Fouleys Foulis Foulles Foulls Foulys Fowlis Fowliss Fowlls Gulloch MacAlach MacChullach MacClullich MacColloch MacColly MacCoulach MacCoulagh MacCoulaghe MacCowlach MacCuley MacCullach MacCullagh MacCullaghe MacCullaigh MacCullauch MacCullie MacCullo MacCulloch MacCullocht MacCullogh MacCulloh MacCullough MacCully MacHulagh MacHullie MacKculloch MacKowloch MacKowloche MacKulagh MacKullie MacKulloch MacKullouch MacLulaghe MacLulaich MacLulich MacLulli MacLullich MacLullick MacOloghe MacOulie MacOwlache MacUlagh MacUlaghe MacUllie MacUlloch Makawllauch Makcoulach Makcowllach Makcowloch Makcullo Makculloch Makcullocht Makhulagh Malcowlach Manro Monro Monroe Monroo Munro Munroe Munroy Pathillock Patillo Patillok Pattillo Pattillock Pattullo Pattullok Patullo Patullow Pethilloch Petillok Pettillo Pettillok Pettillow Pettullock Petulloch Petullow Pitilloche Pitiloch Pittilloch Pittillock Pittillocke Pittilluo Pittulloch Pitullich Pyttyllok Vas Vase Vass Vassie Vaus Vauss Vaux Vaws Wais Was Wass Waus Wause Wauss Waux

Murray
Clan History: http://electricscotland.com/webclans/m/murray.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=544
Associated Names and Septs (with spelling variations):
Abercairnie Abercairny Athol Atholl Balneaves Buttar Butter Butters Flamanc Flamang Flamench Flamyng Fleeman Fleeming Flemen Fleming Flemmynge Flemyn Flemyne Flemyng Flemynge Fleymen Fleyming Fliming Flymen Flymyng MacKinnoch MacKmurrie MacMurray MacMurre MacMurree MacMurrie MacMurry MacMurrye MacMury Mirrey Monchryf Moncref Moncrefe Moncreife Moncreiff Moncreiffe Moncrief Moncriefe Moncrieff Moncrieffe Moncrif Moncrife Moncriffe Monkreff Monkreth Montcreffe Montcrief Montcrif Moray Morray Mouncref Mowray Mulmurray Mulmury Muncrefe Muncreff Muncreif Muncreiffe Muncreyfe Muncrif Muncrife Munkrethe Muray Murra Murrai Murraue Murray Murrie Murry Mury Neaves Pepper Phylemen Piper Pyper Ratray Ratre Ratteray Rattray Retrey Rettra Rettray Rotray Smail Smaill Smal Smale Small Smalle Smaw Smeal Smeall Spaden Spadine Spaldene Spaldeng Spalding Spaldyn Spaldyng Spaldynge

Murray Of Elibank
Clan History: http://electricscotland.com/webclans/m/murray.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=771
Associated Names and Septs (with spelling variations):
Elibank MacKmurrie MacMurray MacMurre MacMurree MacMurrie MacMurry MacMurrye MacMury Mirrey Moray Morray Mowray Mulmurray Mulmury Muray Murra Murrai Murraue Murray Murrie Murry Mury

Murray Of Tullibardine
Clan History: http://electricscotland.com/webclans/m/murray.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=700
Associated Names and Septs (with spelling variations):
MacKmurrie MacMurray MacMurre MacMurree MacMurrie MacMurry MacMurrye MacMury Mirrey Moray Morray Mowray Mulmurray Mulmury Muray Murra Murrai Murraue Murray Murrie Murry Mury Tullibardine

N
Nairn
Clan History: http://electricscotland.com/webclans/ntor/nairn.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=557
Associated Names and Septs (with spelling variations):
Nairn Nairne


Napier
Clan History: http://electricscotland.com/webclans/ntor/napier.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=558
Associated Names and Septs (with spelling variations):
MacAlowne Naiper Napare Napeir Naper Napier Napper Neaper Nepare Neper

Nesbit
Clan History: http://electricscotland.com/webclans/ntor/nisbet.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=559
Associated Names and Septs (with spelling variations):
Nechisbet Neisbayt Neisbit Neisbitt Nesbeit Nesbet Nesbeth Nesbit Nesbite Nesbitt Nesbut Nesbuth Nesbyt Nesbyte Nesbyth Nesebeht Nesebite Nesebith Nezebet Nezebeth Nisbert Nisbet Nisbett Nisbite Nizbet Nysbet Nysbit Nyzbet

Newlands
Clan History: http://electricscotland.com/webclans/ntor/newlands.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=855
Associated Names and Septs (with spelling variations):
Newlands

O
O'Farrell
Clan History: http://electricscotland.com/webclans/scotsirish/farrell.htm
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1269
Associated Names and Septs (with spelling variations):
O'Farrell


O'Farrell
Clan History: http://electricscotland.com/webclans/scotsirish/farrell.htm
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1532394941
Associated Names and Septs (with spelling variations):
O'Farrell

Ogilvie
Clan History: http://electricscotland.com/webclans/ntor/ogilvy.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=561
Associated Names and Septs (with spelling variations):
Airlie Airly Findlater Finlater Finlator Fothe Fothy Futhie Fynleter Fynletir Gilchrist Gilcrist Gilcriste Gilcristes Gilcryst Gillchrist Gillechrist Gillecrist Gillecryst Innerarity Inverarity Killecrist MacGilchrist MacGilcreist MacGilcrist MacIlchreist MacIlcrist MacKlechreist MacYllecrist Mill Millan Millen Millin Milln Mills Miln Milne Milner Milnes Mylen Myln Ogelvie Ogelvy Ogilbe Ogilbie Ogilby Ogilve Ogilvie Ogilvy Ogilwe Ogilwie Ogilwye Oglevy Ogylbe Ogyllwe Ogylvi Ogylvy Ogylwe Ogylwye

O'Keefe
Clan History: http://electricscotland.com/webclans/scotsirish/okeefe.htm
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=945284665
Associated Names and Septs (with spelling variations):
O'Keefe

O'Keefe
Clan History: http://electricscotland.com/webclans/scotsirish/okeefe.htm
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1111
Associated Names and Septs (with spelling variations):
O'Keefe

Oliphant
Clan History: http://electricscotland.com/webclans/ntor/oliphan.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=562
Associated Names and Septs (with spelling variations):
Eliphant Gask Olephant Olifant Olifard Olifart Olifarth Olifat Olifaunt Oliphand Oliphant Olyfant Olyfard Olyfart Olyfat Olyfaunt Olyfawnt Olyphaint Olyphand Olyphard

Oliver
Clan History: http://electricscotland.com/webclans/ntor/oliver.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=565
Associated Names and Septs (with spelling variations):
Holifarth Holyfarth Olaver Oleveir Olifeir Olifer Oliphar Olipheir Olipher Oliphir Oliver Olivier Olliver Olover Oluer Olyar Olyer Olyphere Olyver Olywer

O'Neill
Clan History: http://electricscotland.com/webclans/scotsirish/oneill.htm
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1638093282
Associated Names and Septs (with spelling variations):
O'Neill

O'Neill
Clan History: http://electricscotland.com/webclans/scotsirish/oneill.htm
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1259
Associated Names and Septs (with spelling variations):
O'Neill

O'Sullivan
Clan History: http://electricscotland.com/webclans/scotsirish/osullivan.htm
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=947937061
Associated Names and Septs (with spelling variations):
O'Sullivan

O'Sullivan
Clan History: http://electricscotland.com/webclans/scotsirish/osullivan.htm
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1369
Associated Names and Septs (with spelling variations):
O'Sullivan

P
Patterson
Clan History: http://electricscotland.com/webclans/ntor/paterson.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=809
Associated Names and Septs (with spelling variations):
Glen Lyon Paterson Patersone Patterson


Pollock
Clan History: http://electricscotland.com/webclans/ntor/pollock.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1420
Associated Names and Septs (with spelling variations):
Pollock Pollok

Porteous
Clan History: http://electricscotland.com/webclans/ntor/porteou.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=569
Associated Names and Septs (with spelling variations):
Porteous Porteouse Portews Portows Portuis Portuiss

Pringle
Clan History: http://electricscotland.com/webclans/ntor/pringle.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1313
Associated Names and Septs (with spelling variations):
Pringel Pringell Pringle

R
Ramsay
Clan History: http://electricscotland.com/webclans/ntor/ramsay.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=573
Associated Names and Septs (with spelling variations):
Dalhousie Ramesay Ramesey Rameseye Ramesia Ramesie Ramessay Ramissay Rammeseye Ramsay Ramsey Remesey


Rankin
Clan History: http://electricscotland.com/webclans/ntor/rankine.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=574
Associated Names and Septs (with spelling variations):
MacCraing MacRaing MacRankein MacRankin MacRankine MacRanking MacRankyne Raincin Ramkein Ranequin Rankeine Ranken Rankene Rankesoun Rankin Rankine Ranking Rankinge Rankins Rankinson Rankyn Rankyne Rankynson Renkine Renkyn Rinking

Rattray
Clan History: http://electricscotland.com/webclans/ntor/rattray.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=575
Associated Names and Septs (with spelling variations):
Drimmie Lude Ratray Ratre Ratteray Rattray Retrey Rettra Rettray Rotray

Riddell
Clan History: http://electricscotland.com/webclans/ntor/riddell.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=577
Associated Names and Septs (with spelling variations):
Riddall Riddel Riddell Riddil Riddill Riddle

Robertson
Clan History: http://electricscotland.com/webclans/ntor/roberts.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=579
Associated Names and Septs (with spelling variations):
Coalyear Coilzear Colliar Collier Collyar Colyear Colyeer Colyer Colzear Conachar Conacher Concher Connachar Connacher Connochie Connoquhie Conochie Coolyear Donachie Donaghy Donnachie Donnchad Donnchadh Donnchaidh Duncan Duncane Duncaneson Duncanson Duncanus Dunchad Dunckane Dunckiesone Dundas Dundass Dunecan Dunecanus Dunkan Dunkane Dunkanson Dunkansoun Dunkeson Dunkesone Dunkesoun Dunkinssone Dunkysoun Dunnachie Euer Evar Evir Ewar Ewer Ewers Farlastone Galashan Glashan Glashen Glashin Inches Ivar Iver Iverson Ivirach Ivor Ivory Iwur Kindeace MacAver MacChonachy MacClachan MacClachane MacClagan MacClagane MacClagnan MacClathan MacClaugan MacConacher MacConachie MacConachy MacConaghy MacConche MacConcher MacConchie MacConchy MacCondach MacCondachie MacCondachy MacCondochie MacCondoquhy MacConechie MacConechy MacConiquhy MacConkey MacConnacher MacConnachie MacConnaghy MacConnchye MacConnechie MacConnechy MacConnichie MacConnochie MacConnoquhy MacConnquhy MacConochey MacConochie MacConoughey MacConquhar MacConquhie MacConquhy MacConquy MacCowir MacCrobert MacCrobie MacCuir MacCuoch MacCur MacCure MacDhonchaidh MacDhonnachie MacDonach MacDonachie MacDonachy MacDonagh MacDonchy MacDonnach MacDonnchaidh MacDonochie MacDonough MacDonquhy MacDouagh MacDuncan MacEiver MacEuer MacEuir MacEur MacEure MacEvar MacEver MacEwer MacEwir MacEwyre MacGeever MacGilleglash MacGiver MacGlagan MacGlashan MacGlashen MacGlashin MacGlassan MacGlassin MacGlasson MacHamish MacHenish MacHonichy MacIlglegane MacIlleglass MacInechy MacInroy MacIvar MacIver MacIverach MacIvirach MacIvor MacJames MacJamis MacKames MacKchonchie MacKeamish MacKeaver MacKeever MacKeevor MacKeiver MacKeur MacKever MacKevor MacKevors MacKewer MacKewyr MacKglesson MacKhonachy MacKiver MacKivers MacKivirrich MacKjames MacKlagan MacKondachy MacKonochie MacKuir MacKunuchie MacKure MacLachan MacLagain MacLagan MacLagane MacLagen MacLaggan MacLaggen MacLagine MacLaglan MacLaglen MacLagone MacLaughan MacLglesson MacLugane MacOnachie MacOnachy MacOnchie MacOndochie MacOndoquhy MacOnechy MacOnochie MacOnohie MacRob MacRobb MacRobbie MacRobe MacRobert MacRoberts MacRobi MacRobie MacRobin MacRypert MacUir MacUre MacYuir Makchonachy Makclaggan Makconchie Makconoch Makcure Makeanroy Makewer Makiver Makonoquhy Makrob Makrobert Makroby Matthews Orr Orre Oure Rabbe Read Reade Red Rede Reed Reede Reid Reide Reyd Rid Ride Rob Robb Robbie Robe Roberson Robertson Robeson Robesoun Robie Robison Robisone Robson Robsone Roby Robye Roy Roye Ruadh Stark Starke Sterk Stirk Struan Tonnoch Tonnochy Ure Urie Urri Urrie Urry Vconchie Yvar Yvir Ywar

Rollo
Clan History: http://electricscotland.com/webclans/ntor/rollo.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=586
Associated Names and Septs (with spelling variations):
Rogge Rogue Rolla Rollo Rollock Rollok Rollow Rook Rouk Ruke

Rose
Clan History: http://electricscotland.com/webclans/ntor/rose.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=588
Associated Names and Septs (with spelling variations):
Geddas Geddeis Geddes Geddess Geddis Gedes Rose

Ross
Clan History: http://electricscotland.com/webclans/ntor/ross.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=589
Associated Names and Septs (with spelling variations):
Aindrea Anderson Andersone Andersonne Andersoun Andersoune Anderston Andesoune Andie Andirsoone Andirsoune Andison Andree Andreson Andresoun Andrew Andrewes Andrews Andrewson Andro Androe Androson Androsone Androsoun Androsoune Androw Andrson Andy Andyrson Anndra Connan Connen Connon Corbart Corbat Corbatt Corbet Corbeth Corbett Culloch Dinguel Dingvaile Dingvaille Dingval Dingvale Dingvall Dingvell Dingwall Dingwell Dungwail Duthe Duthie Dyngvale Dyngwaile Dyngwale Enderson Endherson Endirsone Fearn Fearne Fearns Fern Ferne Gallanders Gaudie Gilanders Gilandres Gilandrias Gillaindreis Gillanders Gillandres Gillandris Gilleanndrais Gilleanris Gillenders Gillendrias Gulloch Hagart Haggart MacAlach MacChullach MacClullich MacColloch MacColly MacCoulach MacCoulagh MacCoulaghe MacCowlach MacCuley MacCullach MacCullagh MacCullaghe MacCullaigh MacCullauch MacCullie MacCullo MacCulloch MacCullocht MacCullogh MacCulloh MacCullough MacCully MacGillanders MacGillandras MacGillandrew MacGillandrish MacHulagh MacHullie MacIlendrish MacIllandarish MacIntagart MacIntagerit MacIntargart MacKculloch MacKildash MacKinsagart MacKintaggart MacKowloch MacKowloche MacKulagh MacKullie MacKulloch MacKullouch MacKyntagart MacKyntaggart MacLulaghe MacLulaich MacLulich MacLulli MacLullich MacLullick MacOloghe MacOulie MacOwlache MacSagart MacTagart MacTaggard MacTaggart MacTaggate MacTaggert MacTaggit MacTear MacTeer MacTeir MacTer MacTere MacTeyr MacTier MacTire MacTyr MacTyre MacUlagh MacUlaghe MacUllie MacUlloch Makawllauch Makcoulach Makcowllach Makcowloch Makcullo Makculloch Makcullocht Makhulagh Makintalgart Makteir Makter Malcowlach Mteir Myketagart Pathillock Patillo Patillok Pattillo Pattillock Pattullo Pattullok Patullo Patullow Pethilloch Petillok Pettillo Pettillok Pettillow Pettullock Petulloch Petullow Pitilloche Pitiloch Pittilloch Pittillock Pittillocke Pittilluo Pittulloch Pitullich Pyttyllok Ros Ross Rosse Tagart Taggart Taggert Tegart Teggart Tolach Tulach Tulache Tullach Tullauch Tullawch Tullo Tulloch Tullocht Tulloich Tulloicht Tullow Tulloycht Vas Vase Vass Vassie Vaus Vauss Vaux Vaws Wais Was Wass Waus Wause Wauss Waux

Russell
Clan History: http://electricscotland.com/webclans/ntor/russell.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=595
Associated Names and Septs (with spelling variations):
Rossel Rossell Rous Rozel Rusel Russale Russall Russaule Russel Russell Russelle

Ruthven
Clan History: http://electricscotland.com/webclans/ntor/ruthven.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=596
Associated Names and Septs (with spelling variations):
Gowrie Rothven Rothveyn Rothwen Ruffin Ruthen Ruthfen Ruthven Ruthwein Ruthyn Rythven

S
Scott
Clan History: http://electricscotland.com/webclans/stoz/scott.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=597
Associated Names and Septs (with spelling variations):
Escot Escott Geddas Geddeis Geddes Geddess Geddis Gedes Giddes Harden Laidlaw Langland Langlands Napier Scoit Scoitt Scot Scott Scotte Scotus Scoyt


Scrymgeour
Clan History: http://electricscotland.com/webclans/stoz/scrymge.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=598
Associated Names and Septs (with spelling variations):
Crymgeour Scremgeour Scremger Scrimgeour Scrimgeoure Scrimger Scrimigeor Scrimzeor Scrirmechour Scrymezour Scrymgeor Scrymgeour Scrymgeoure Scrymger Skrimagour Skrimchur Skrimechour Skrimgeour Skrymchur Skrymechour Skrymechur Skrymezoure Skrymgeour Skrymgeoure Skrymger Skrymshire Skryngior

Sempill
Clan History: http://electricscotland.com/webclans/stoz/semple.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=-1500079505
Associated Names and Septs (with spelling variations):
Sempill Semple

Seton
Clan History: http://electricscotland.com/webclans/stoz/seton.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=599
Associated Names and Septs (with spelling variations):
Ceatoun Ceton Cetone Seaton Seatonne Seatown Seitone Seitoune Sethun Seton Setone Setoun Setoune Setowun Setton Settone Settoun Setun Seytoun Seytoune

Shaw
Clan History: http://electricscotland.com/webclans/stoz/shaw.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=600
Associated Names and Septs (with spelling variations):
Adamson Adamsone Ademson Ademsoun Ademsoune Aesone Aison Aissone Aissoun Aissoune Asson Assone Aue Ave Ay Aye Ayesone Ayson Aysone Aysoun Ayssoun Eason Easone Easson Esson Ison Isone MacAy Saythe Scaith Scayth Schau Schaw Schawe Scheoch Scheok Schiach Schioch Schioche Seah Seath Seith Seth Sha Shau Shaw Shawe Shay Sheach Sheath Sheehan Sheoch Shiach Siache Sith Sithach Sithech Sithig Skaith Sythach Sythag Sythock

Shaw Of Tordarroch
Clan History: http://electricscotland.com/webclans/stoz/shaw.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=895
Associated Names and Septs (with spelling variations):
Tordarroch

Sinclair
Clan History: http://electricscotland.com/webclans/stoz/sinclai.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=605
Associated Names and Septs (with spelling variations):
Bairnson Barnie Barnieson Blank Bowar Bower Brims Broch Brotchie Budge Caird Caithens Caithness Caittins Card Cathnes Ceard Clinkclatter Clisten Clistoun Cloustan Cloustane Clouston Cloustone Cloustoun Clustane Clyn Clyne Corriegal Corrigall Corrigill Duffus Gailey Galdie Galie Gallach Gallaich Gallie Galloch Gally Galy Gauldie Gelie Gely Gills Gollach Groat Kaird Keeard Keerd Keldie Kerd Kerde Linckletter Linklater Linklet Linkletter Linklittar Loch Garth Lynclater Lynkclet MacIncaird MacInkaird MacInkeard MacKeardie MacKnokaird MacNakaird MacNecaird MacNekard MacNikord MacNocaird MacNokaird MacNokard MacNokerd MacNokord MacNorcard MacNougard Maison Maissone Maissoun Mason Masone Masoun Masoune Masson Massoun Mayssone Meason Measone Measoun Measoune Meassone Sanclar Santclar Santclere Sincklair Sincklar Sincklare Sinckler Sinclair Sinclaire Sincler Singkler Sinkaller Sinkclair Sinklare St Clair Synclare Syncleir Syncler Synclere Synklair Synklar Wick Wicke Wycks

Skene
Clan History: http://electricscotland.com/webclans/stoz/skene.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=612
Associated Names and Septs (with spelling variations):
Cariston Dis Diss Dyas Dyce Dyes Dys Dyse Dyss Hall Hallyard Sceyn Schene Skeen Skeene Skein Skeine Sken Skene Skeyn Skeyne Skin Skine Skyen Skyne

Smith
Clan History: http://electricscotland.com/webclans/stoz/smith.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=613
Associated Names and Septs (with spelling variations):
Gove Gow Gowan Gowans Gowen Gowie Gowin Smeayth Smith Smyith Smyithe Smyth Smythe

Snodgrass
Clan History: http://electricscotland.com/webclans/stoz/snodgra.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=614
Associated Names and Septs (with spelling variations):
Snodgers Snodgerss Snodgrase Snodgrass Snodgrasse Snodgress

Somerville
Clan History: http://electricscotland.com/webclans/stoz/somervi.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=615
Associated Names and Septs (with spelling variations):
Semervaile Simerwell Someruell Someruyle Somervail Somervaill Somervell Somerviel Somervile Somerville Somervol Somerwale Somerwele Somerwell Sommeruill Sommerveale Sommervell Sommerville Sommerwall Sommerweil Sommerwell Somyruille Somyruyle Somyrville Sumeruilla Sumervilla Summervail Summyrvil Summyrville Summyrwil Symmervaill Symmervell Symmerwell

Spens
Clan History: http://electricscotland.com/webclans/stoz/spens.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=616
Associated Names and Septs (with spelling variations):
Despens Spence Spens Spense Spenss

Stevenson
Clan History: http://electricscotland.com/webclans/stoz/stevens.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=617
Associated Names and Septs (with spelling variations):
MacSteven Stains Steen Steens Steenson Stein Steinson Stephen Stephens Stephenson Stevenson Stiven

Stewart
Clan History: http://electricscotland.com/webclans/stoz/stewart.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=619
Associated Names and Septs (with spelling variations):
Bhoid Bod Bodha Boed Boht Boid Boyd Boyde Boyt Dennison Denniston Dennistoun Dog Doig France Garro Garroch Garrow Gerrow Glay Gley Lennox Lenox MacGaraidh Mentayth Menteath Menteith Mentheth Monteath Montecht Monteith Munteith Muntethe Mynteith Mynteth Myntethe Phinney Prince Charles Edw Sprall Spreall Spreuile Spreuill Spreul Spreule Spreull Sprewell Sprewile Sprewill Sprewl Sprewle Sprewyle Sproul Sproule Sproull Sprowl Spruell Spruill Spruyle Spruylle Steuarde Steuart Steuarte Steward Stewart Stiuard Stiubhard Stiward Stuard Stuarde Stuart Stuerd Stuward Victoria

Stewart Of Appin
Clan History: http://electricscotland.com/webclans/stoz/appin_stewarts.htm
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=624
Associated Names and Septs (with spelling variations):
Appin Cachoune Cahoon Cahoun Cahoune Cahun Cahund Cahune Calhoon Calhoun Calquhoun Calquhoune Calwhone Carmechele Carmichael Carmichaill Carmichel Carmichell Carmigell Carmighell Carmitely Carmychale Carmychall Carmychel Carmychell Cayrmichel Cayrmichell Chombeich Chombich Choquoyn Clay Cohune Colchoun Colechon Colfune Colhoun Colhoune Collquhone Colqhoun Colqhuen Colquhone Colquhoun Colquhoune Colquhowne Colquhyn Colqwhone Colwhone Colwhoun Combach Combich Conlay Conley Cowquhowne Culchon Culchone Culchoun Culquhone Culquhoun Culquhoune Culqwhone Culqwon Culqwone Culwone Donleavy Donlevy Dunleavy Dunslef Fuccatour Fuckater Fugater Fugatour Fuggatour Fuktor Fuktour Futtor Kelquon Kermychell Kilwhone Kulwoon Kulwoun Kylkone Leavack Leavock Levack Levingestoune Levingstone Levingstoune Levistone Levynstoune Levystone Lewingstoune Liuistone Livingstone Mac-A-Chounich Mac-A-Chonnick Mac-A-Chounich MacAnally MacAnnally MacCannally MacChombeich MacChombich MacChomich MacClae MacClay MacCleay MacClew MacCole MacColl MacCollea MacCombich MacComiche MacComick MacConlea MacDimslea MacDonleavy MacDonnslae MacFaktur MacFuktor MacFuktur MacGillemhicheil MacGillemichael MacGillemichel MacGillemitchell MacGillemithel MacGillenan MacGillimichael MacGillmichell MacGillmitchell MacGilmichal MacGilmichel MacIlchomich MacIlmichael MacIlmichaell MacIlmichall MacIlmichell MacInally MacInnocater MacInnowcater MacInnowcatter MacInnugatour MacInocader MacInuctar MacInucter MacKeandla MacKillimichael MacKillmichaell MacKilmichael MacKilmichel MacKindlay MacKinla MacKinlay MacKinley MacKnockater MacKnocker MacKnockiter MacLae MacLay MacLea MacLeay MacLey MacMichael MacMicheil MacMichell MacMigatour MacMitchel MacMitchell MacMuckater MacMuncater MacMuncatter MacMungatour MacMychel MacMychele MacNally MacNaucater MacNowcater MacNowcatter MacNucadair MacNucater MacNucator MacNucatter MacNuctar MacNuicator MacOlmichaell MacOnlay MacRob MacRobb Makgillemichell Makgilmichel Makinnocater Makley Makmychell Nucator Steuarde Steuart Steuarte Steward Stewart Stiuard Stiubhard Stiward Stuard Stuarde Stuart Stuerd Stuward Valker Waker Walcair Walcar Walcare Walcer Walkar Walker Waulcar

Stewart Of Ardshiel
Clan History: http://electricscotland.com/webclans/stoz/stewart.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=832
Associated Names and Septs (with spelling variations):
Ardshiel

Stewart Of Atholl
Clan History: http://electricscotland.com/webclans/stoz/stewart.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=626
Associated Names and Septs (with spelling variations):
Athol Atholl Camach Camacha Conachar Conacher Concher Connachar Connacher Duilach Dulach Dullach Galashan Glas Glashan Glashen Glashin Glass Glasse Gray Grey MacClachan MacClachane MacClathan MacGilleglash MacGlashan MacGlashen MacGlashin MacGlassan MacGlassin MacGlasson MacIlleglass MacKglesson MacLglesson Steuarde Steuart Steuarte Steward Stewart Stiuard Stiubhard Stiward Stuard Stuarde Stuart Stuerd Stuward

Stewart Of Galloway
Clan History: http://electricscotland.com/webclans/stoz/stewart.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=627
Associated Names and Septs (with spelling variations):
Carmechele Carmichael Carmichaill Carmichel Carmichell Carmigell Carmighell Carmitely Carmychale Carmychall Carmychel Carmychell Cayrmichel Cayrmichell Cree Gallaway Gallouay Galloway Gallowaye Gallowey Galoway Galowey Kermychell MacGillemhicheil MacGillemichael MacGillemichel MacGillemitchell MacGillemithel MacGillimichael MacGillmichell MacGillmitchell MacGilmichal MacGilmichel MacIlmichael MacIlmichaell MacIlmichall MacIlmichell MacKillimichael MacKillmichaell MacKilmichael MacKilmichel MacMichael MacMicheil MacMichell MacMitchel MacMitchell MacMychel MacMychele MacOlmichaell Makgillemichell Makgilmichel Makmychell Steuarde Steuart Steuarte Steward Stewart Stiuard Stiubhard Stiward Stuard Stuarde Stuart Stuerd Stuward

Stewart Of Garth
Clan History: http://electricscotland.com/webclans/stoz/stewart.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=628
Associated Names and Septs (with spelling variations):
Crewschank Crewshank Crokeshank Crokeshanks Crookschank Crookshank Crookshanks Croukschank Cruckshank Cruckshanke Crucshank Cruickshank Cruikank Cruiksank Cruikschank Cruikshank Cruikshanks Cruischank Crukeschank Cruksank Crukschank Crukschanke Crukshaink Crukshank Crukshanke Crushank Cruxschank

Stewart Of Urrard
Clan History: http://electricscotland.com/webclans/stoz/stewart.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1030
Associated Names and Septs (with spelling variations):
Urrard

Stirling District
Clan History: http://electricscotland.com/webclans/stoz/stirling.htm
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=1428
Associated Names and Septs (with spelling variations):
Boag Brash Burnside Denny Goodlet Loch Lomond Mungall Stirling

Strachan
Clan History: http://electricscotland.com/webclans/stoz/strachan.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=262
Associated Names and Septs (with spelling variations):
Strachan Strachen Straughen Strichen

Stuart Of Bute
Clan History: http://electricscotland.com/webclans/stoz/stuart_bute.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=630
Associated Names and Septs (with spelling variations):
Ballantyne Banaghtyn Banauchtyn Banauthyn Bannachty Bannachtyn Bannantyne Bannatine Bannatyne Bannochtyne Benauty Bennachtyne Bennothine Benothyne Bhoid Bod Bodha Boed Boht Boid Boyd Boyde Boyt Brandane Callan Callen Caw Curdie Folartoun Folertoun Foularton Foulartoun Foulartoune Foulerton Foulertoune Foullarton Foullertoune Fowillertoun Fowlarton Fowlerton Fowlertoun Fulareton Fulertoun Fullarton Fullarttown Fullerton Fullertowne Glas Glass Glasse Hunter Jameson Jamesone Jamesoune Jamieson Jamison Jamisone Jamyson Jamysone Jemison Lewis Loy MacAmelyne MacAmlain MacAomlin MacAw MacCa MacCaa MacCame MacCamey MacCamie MacCamiey MacCammie MacCaw MacCawe MacCloy MacClue MacCluie MacCurdie MacCurdy MacCurthy MacElheran MacElherran MacEmlinn MacFun MacFunie MacFunn MacGaa MacGaw MacIlfun MacIlheran MacIlherran MacIlmoun MacIlmune MacIlmunn MacKa MacKaa MacKame MacKau MacKaw MacKawe MacKerdie MacKern MacKerrin MacKerron MacKilmine MacKilmon MacKilmoun MacKilmun MacKilmune MacKirdie MacKirdy MacKlowis MacKurerdy MacKwarrathy MacLewis MacLouis MacLow MacLowe MacLoy MacMowtrie MacMune MacMunn MacMurtery MacMurtie MacMurtrie MacMutrie MacOmelyne MacPhun MacPhune MacPhuney MacPhunie MacPhunn MacPhuny MacQuartie MacQuheritie MacQuhirertie MacQuhirirtie MacVararthy MacVararty MacVarthie MacVerrathie MacVurarthie MacVurarthy MacWerarthe MacWerarthie MacWrarthie MacWrerdie Makaw Makca Makcaw Makcawe Makcloye Makcoe Makilmone Makilmun Makilmune Makkamy Makkaw Makmmurtye Makmun Makmurrarty Makvirrartie Makwararthe Makwarartie Makwarrarty Makwerarty Makwrarty Makwrerdy Malloy Milloy Mund Munn Neilson Shairp Sharp Sharpe Steuarde Steuart Steuarte Steward Stewart Stiuard Stiubhard Stiward Stuard Stuarde Stuart Stuerd Stuward

Sturrock
Clan History: http://electricscotland.com/webclans/stoz/sturroc.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=631
Associated Names and Septs (with spelling variations):
Starrack Stirrick Stirrock Storach Storek Storrack Storrock Storrok Sturrack Sturrock Sturrok

Sutherland
Clan History: http://electricscotland.com/webclans/stoz/sutherl.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=632
Associated Names and Septs (with spelling variations):
Caidh Cate Ceiteach Chaney Chayne Cheen Chein Cheine Chene Cheney Chesne Cheyne Cheyney Chiene Chisnie Chyine Chyne Clyne Duffus Federeth Federith Fedreth Fedrey Fetherith Gray Grey Kayt Keathe Keht Keith Ket Keth Kethe Keyth Keythe Keytht Kite Meuatt Mohuat Mouat Mouatt Mout Movat Mowait Mowaite Mowat Mowatt Mowet Mowit Murray Scheyne Sotherland Sothyrland Southerland Suderland Sutherlan Sutherland Sutherlande Suthirland Suthirlande

Swinton
Clan History: http://electricscotland.com/webclans/stoz/swinton.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=-59630762
Associated Names and Septs (with spelling variations):
Swinton

T
Taylor
Clan History: http://electricscotland.com/webclans/stoz/taylor.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=634
Associated Names and Septs (with spelling variations):
MacEantailyeour MacIntailyeour MacIntayleor MacIntaylor MacIntyller MacIntylor MacKintaylzeor MacKyntalyhur MacTaldrach MacTaldridge MacTaldroch MacTalzyr Makintailzour Makintalyour Makyntailzour Tailer Tailleur Tailliour Taillor Taillur Taillyer Taillzier Tailyeour Tailzer Tailzieor Tailzieour Talyeor Talyhour Talzeor Talzior Talzour Tayler Tayleur Tayliour Tayllur Taylor Taylowre Taylyhour Taylyour Telyour Tyllour


Tennant
Clan History: http://electricscotland.com/webclans/stoz/tennant.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=635
Associated Names and Septs (with spelling variations):
Tenand Tenant Tenaunt Tenende Tenent Tennand Tennant Tennend Tennent

Thomson
Clan History: http://electricscotland.com/webclans/stoz/thomson.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=637
Associated Names and Septs (with spelling variations):
Taes Tais Taise Taish Taiss Tam Tameson Tamesone Tamson Tamsone Taus Taweson Tawesson Tawis Taws Tawse Tawseon Tawseson Tawson Tawst Tawus Thomason Thomasson Thomassone Thomassoun Thomessone Thompson Thomson Thomsone Thomsoun Thomsoune Thomsson Tomson Tomsone

Tribe Of Mar
Clan History: http://electricscotland.com/webclans/m/mar.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=638
Associated Names and Septs (with spelling variations):
Strachan Strachen Straughen

Trotter
Clan History: http://electricscotland.com/webclans/stoz/trotter.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=-1944186337
Associated Names and Septs (with spelling variations):
Trotter

Turnbull
Clan History: http://electricscotland.com/webclans/stoz/turnbul.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=639
Associated Names and Septs (with spelling variations):
Tornebole Tornebule Tournebulle Trimbill Trimble Trimbulle Trombel Trombill Tromboul Troumbull Trumbell Trumbil Trumbill Trumble Trumbul Trumbyll Trymbille Turmbill Turmpbill Turnbill Turnble Turnbol Turnbul Turnbull Turnebile Turneble Turnebule Turnebulle Turnibul

U
Urquhart
Clan History: http://electricscotland.com/webclans/stoz/urquhar.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=642
Associated Names and Septs (with spelling variations):
Orcutt Urcharde Urchart Urghad Urquart Urquhart Urquhat


V
Vipont
Clan History: http://electricscotland.com/webclans/stoz/vipont.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=643
Associated Names and Septs (with spelling variations):
Veepount Vepont Veupont Veupount Vieupont Vieuxpont Vipond Vipont Vypont Vypunt Weepunt Wippunde Wypponde


W
Walker
Clan History: http://electricscotland.com/webclans/stoz/walker.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=644
Associated Names and Septs (with spelling variations):
Fuccatour Fuckater Fugater Fugatour Fuggatour Fuktor Fuktour Futtor MacFaktur MacFuktor MacFuktur MacInnocater MacInnowcater MacInnowcatter MacInnugatour MacInocader MacInuctar MacInucter MacKnockater MacKnocker MacKnockiter MacMigatour MacMuckater MacMuncater MacMuncatter MacMungatour MacNaucater MacNowcater MacNowcatter MacNucadair MacNucater MacNucator MacNucatter MacNuctar MacNuicator Makinnocater Nucator Valker Waker Walcair Walcar Walcare Walcer Walkar Walker Walkster Waulcar


Wallace
Clan History: http://electricscotland.com/webclans/stoz/wallace.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=645
Associated Names and Septs (with spelling variations):
Galeis Galeius Gales Galeys Galleins Galleius Galles Uallas Valace Valensis Vallace Vallas Valles Valleyis Walace Walais Walans Walas Walays Waleis Walency Waleng Walenis Walens Walense Walensen Walensi Walensis Wales Waless Waleys Waleyss Wallace Wallang Wallas Wallass Wallayis Wallays Walleis Wallensis Walles Walleyis Walleys Wallis Walls Wallyis Wallys Walois Walys Weles

Wardlaw
Clan History: http://electricscotland.com/webclans/stoz/wardlaw.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=811
Associated Names and Septs (with spelling variations):
Wardlaw

Watson
Clan History: http://electricscotland.com/webclans/stoz/watson.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=647
Associated Names and Septs (with spelling variations):
Vatsone Vatsoun Vatt Wason Wasson Wat Wateson Watson Watsone Watsoun Watsoune Watt Wattsone

Wedderburn
Clan History: http://electricscotland.com/webclans/stoz/wedderburn.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=884
Associated Names and Septs (with spelling variations):
Wedderburn

Weir
Clan History: http://electricscotland.com/webclans/stoz/weir.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=648
Associated Names and Septs (with spelling variations):
Vair Veir Vere Veyre Wair Ware Wayre Wear Weare Weer Weir Weire Were Werr Weyir Weyr Whier Wier Wir Wire

Wemyss
Clan History: http://electricscotland.com/webclans/stoz/wemyss.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=650
Associated Names and Septs (with spelling variations):
Elcho Vemis Vemys Vemyss Veymis Weemes Weems Weemyss Weimes Weimis Weims Weimys Wemes Wemeth Wemis Wemise Wemyes Wemys Wemyss Wemysse Weymes Weymis Weyms Wymes Wymess

Wilson
Clan History: http://electricscotland.com/webclans/stoz/wilson.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=652
Associated Names and Septs (with spelling variations):
Villsone Vilsone Vilsoun Vylsone Wiley Willesoun Willie Willson Willsone Willsoun Wilsoine Wilson Wilsone Wilsoun Wilsoune Wilsowne Wily Wolson Wolsoun Wulson Wulsone Wyleson Wylie Wyllie Wylly Wylson Wylsoune Wyly Wylye

Wishart
Clan History: http://electricscotland.com/webclans/stoz/wishart.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=653
Associated Names and Septs (with spelling variations):
Butcher Visart Vishart Vishert Wischard Wischart Wishart Wisheart Wishert

Wood
Clan History: http://electricscotland.com/webclans/stoz/wood.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=9
Associated Names and Septs (with spelling variations):
Vod Voud Wod Wode Wood Woode Woods Yod

Y
Young
Clan History: http://electricscotland.com/webclans/stoz/young.html
Clan Tartans: http://houseoftartan.com/scottish/dir2.asp?secid=77&subsecid=655
Associated Names and Septs (with spelling variations):
Yonge Young



Return to our Clans page





