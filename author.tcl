#
# Copyright (c) 2005 Richard Cameron, CiteULike.org
# All rights reserved.
#
# This code is derived from software contributed to CiteULike.org
# by
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. All advertising materials mentioning features or use of this software
#    must display the following acknowledgement:
#        This product includes software developed by
#		 CiteULike <http://www.citeulike.org> and its
#		 contributors.
# 4. Neither the name of CiteULike nor the names of its
#    contributors may be used to endorse or promote products derived
#    from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY CITEULIKE.ORG AND CONTRIBUTORS
# ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
# TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE FOUNDATION OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#


#
# Functions to parse plain text author names from references
#
# This a poor man's version of Perl's Lingua::EN:NameParse
# I use (some) of its regular expressions, but don't use its full
# power as I don't have a RecDescent parser.
# For now, this will probably do.


namespace eval author {
	# Try to define some of the tokens in the "grammar" as simple regexps.
	# These are influences from Lingua::EN::NameParse
	set TITLE_JUNK {(?:His (?:Excellency|Honou?r)\s+|Her (?:Excellency|Honou?r)\s+|The Right Honou?rable\s+|The Honou?rable\s+|Right Honou?rable\s+|The Rt\.? Hon\.?\s+|The Hon\.?\s+|Rt\.? Hon\.?\s+|Mr\.?\s+|Ms\.?\s+|M\/s\.?\s+|Mrs\.?\s+|Miss\.?\s+|Dr\.?\s+|Sir\s+|Dame\s+|Prof\.?\s+|Professor\s+|Doctor\s+|Mister\s+|Mme\.?\s+|Mast(?:\.|er)?\s+|Lord\s+|Lady\s+|Madam(?:e)?\s+|Priv\.-Doz\.\s+)+}
	set TRAILING_JUNK {,?\s+(?:Esq(?:\.|uire)?|Sn?r\.?|Jn?r\.?|[Ee]t [Aa]l\.?)} ; # The Indiana Jones school of naming your children..
	set TRAILING_JUNK_2 {,?\s*(?:II|III|IV)} ; # The Indiana Jones school of naming your children..
	set NAME_2 {(?:[^ \t\n\r\f\v,.]{2,}|[^ \t\n\r\f\v,.;]{2,}\-[^ \t\n\r\f\v,.;]{2,})}
	set INITIALS_4  {(?:(?:[A-Z]\.\s){1,4})|(?:(?:[A-Z]\.\s){1,3}[A-Z]\s)|(?:[A-Z]{1,4}\s)|(?:(?:[A-Z]\.-?){1,4}\s)|(?:(?:[A-Z]\.-?){1,3}[A-Z]\s)|(?:(?:[A-Z]-){1,3}[A-Z]\s)|(?:(?:[A-Z]\s){1,4})|(?:(?:[A-Z] ){1,3}[A-Z]\.\s)|(?:[A-Z]-(?:[A-Z]\.){1,3}\s)}
	set PREFIX {Dell(?:[a|e])?\s|Dalle\s|D[a|e]ll\'\s|Dela\s|Del\s|[Dd]e (?:La |Los )?\s|Mc|[Dd]e\s|[Dd][a|i|u]\s|L[a|e|o]\s|[D|L|O]\'|St\.?\s|San\s|[Dd]en\s|[Vv]on\s(?:[Dd]er\s)?|(?:[Ll][ea] )?[Vv]an\s(?:[Dd]e(?:n|r)?\s)?}
	set PREFIX2 {^(dell([ae])?|d[aiue]|l[aeio]|v[oa]n|san|de[rn])$}
	set SURNAME [subst {(?:$PREFIX){0,2}(?:$NAME_2)}]
	set SURNAMES [subst {${SURNAME}(?: $SURNAME)*}]
	set EMAIL {(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)}

	array set SPECIAL {}
	# list nicked from http://snippets.dzone.com/posts/show/2010
	# Permission granted by John Cardinal to use 7/Sep/2009
	# The long list of Mac names is generated my scottish.pl
	# but there are some inconsistencies, e.g., Maclean/MacLean.  Later names
	# overwrite earlier ones, so here we will have "Maclean".
	set S {
		"Mac-A-Chonnick", "Mac-A-Chounich", "MacA'Challies", "MacA'Phearsain",
		"MacA'Phearsoin", "MacAbin", "MacAbsolon", "MacAchaine", "MacAchan",
		"MacAchane", "MacAcharn", "MacAchern", "MacAcherne", "MacAchin",
		"MacAchine", "MacAda", "MacAdaidh", "MacAdaim", "MacAdam", "MacAdame",
		"MacAddam", "MacAddame", "MacAddie", "MacAde", "MacAdie", "MacAfee",
		"MacAffer", "MacAffie", "MacAichan", "MacAid", "MacAig", "MacAige",
		"MacAilein", "MacAilin", "MacAilpein", "MacAin", "MacAindra", "MacAindreis",
		"MacAinish", "MacAinsh", "MacAiskill", "MacAitchen", "MacAla", "MacAlach",
		"MacAlar", "MacAlasdair", "MacAlastair", "MacAlaster", "MacAlay",
		"MacAlbea", "MacAldonich", "MacAldowie", "MacAldowrie", "MacAldowy",
		"MacAlduie", "MacAlear", "MacAleerie", "MacAlees", "MacAlestar",
		"MacAlestare", "MacAlester", "MacAlestere", "MacAlestir", "MacAlestre",
		"MacAlexander", "MacAliece", "MacAlinden", "MacAlinton", "MacAlistair",
		"MacAlister", "MacAll", "MacAllan", "MacAllane", "MacAllar", "MacAllaster",
		"MacAllay", "MacAllestair", "MacAllestar", "MacAllester", "MacAllestyr",
		"MacAlley", "MacAllister", "MacAllum", "MacAlman", "MacAlmant", "MacAlmont",
		"MacAlonan", "MacAloney", "MacAlonie", "MacAlowne", "MacAlpain", "MacAlpie",
		"MacAlpin", "MacAlpine", "MacAlpy", "MacAlpyne", "MacAlshonair",
		"MacAlshoner", "MacAlstar", "MacAlwraith", "MacAlyschandir", "MacAmelyne",
		"MacAmhaoir", "MacAmlain", "MacAnaba", "MacAnally", "MacAnce", "MacAndeoir",
		"MacAndlish", "MacAndrew", "MacAndrie", "MacAndro", "MacAndy", "MacAne",
		"MacAngus", "MacAnish", "MacAnn", "MacAnnally", "MacAnsh", "MacAnstalcair",
		"MacAnstalkair", "MacAoidh", "MacAomlin", "MacAonghus", "MacAphie",
		"MacAppersone", "MacAra", "MacArdie", "MacArdy", "MacAree", "MacArlich",
		"MacArliche", "MacArmick", "MacArorie", "MacArory", "MacArquhar", "MacArra",
		"MacArray", "MacArthur", "MacArtnay", "MacArtney", "MacAsgaill",
		"MacAsgill", "MacAsguill", "MacAsh", "MacAskel", "MacAskie", "MacAskill",
		"MacAskin", "MacAskle", "MacAslan", "MacAsland", "MacAslen", "MacAslin",
		"MacAth", "MacAuchin", "MacAughtrie", "MacAughtry", "MacAuihlay", "MacAula",
		"MacAulay", "MacAuld", "MacAule", "MacAuley", "MacAuliffe", "MacAull",
		"MacAulla", "MacAullay", "MacAully", "MacAuselan", "MacAuslan",
		"MacAusland", "MacAuslane", "MacAuslin", "MacAver", "MacAvery", "MacAves",
		"MacAvis", "MacAvish", "MacAvoy", "MacAw", "MacAwis", "MacAwishe",
		"MacAwla", "MacAwlay", "MacAws", "MacAy", "MacAychin", "MacBa", "MacBae",
		"MacBain", "MacBaine", "MacBaith", "MacBane", "MacBard", "MacBardie",
		"MacBarron", "MacBartny", "MacBathe", "MacBaxtar", "MacBaxter", "MacBay",
		"MacBayne", "MacBea", "MacBean", "MacBeane", "MacBeath", "MacBeatha",
		"MacBeathy", "MacBee", "MacBehan", "MacBeith", "MacBen", "MacBeolain",
		"MacBerkny", "MacBertny", "MacBeth", "MacBetha", "MacBey", "MacBheath",
		"MacBheatha", "MacBheathain", "MacBirney", "MacBirnie", "MacBirtny",
		"MacBlain", "MacBlair", "MacBlane", "MacBraid", "MacBrain", "MacBraine",
		"MacBrair", "MacBraire", "MacBraten", "MacBratney", "MacBratnie",
		"MacBrayan", "MacBrayne", "MacBreck", "MacBreive", "MacBrennan",
		"MacBretnach", "MacBretney", "MacBretnie", "MacBretny", "MacBreyane",
		"MacBreyne", "MacBriar", "MacBrid", "MacBridan", "MacBride", "MacBrieve",
		"MacBroom", "MacBryd", "MacBryde", "MacBryne", "MacBurie", "MacBurney",
		"MacBurnie", "MacByrne", "MacCa", "MacCaa", "MacCabe", "MacCachane",
		"MacCachie", "MacCachin", "MacCadam", "MacCadame", "MacCaddam",
		"MacCaddame", "MacCaddim", "MacCadie", "MacCadu", "MacCaell", "MacCaffe",
		"MacCaffer", "MacCaffie", "MacCaffir", "MacCagy", "MacCaibe",
		"MacCaichrane", "MacCaidh", "MacCaig", "MacCaige", "MacCail", "MacCaill",
		"MacCain", "MacCaine", "MacCainsh", "MacCairlich", "MacCairlie",
		"MacCairly", "MacCairn", "MacCaish", "MacCaishe", "MacCala", "MacCale",
		"MacCalim", "MacCalister", "MacCall", "MacCalla", "MacCallan", "MacCallane",
		"MacCallar", "MacCallaster", "MacCallay", "MacCalley", "MacCallie",
		"MacCallien", "MacCallion", "MacCallman", "MacCallome", "MacCalloun",
		"MacCallow", "MacCallpin", "MacCallum", "MacCally", "MacCalmain",
		"MacCalman", "MacCalme", "MacCalmin", "MacCalmon", "MacCalmont",
		"MacCalpie", "MacCalpin", "MacCalppin", "MacCalpy", "MacCalpyne",
		"MacCaluim", "MacCalume", "MacCalvine", "MacCalvyn", "MacCalzean",
		"MacCamant", "MacCambil", "MacCambridge", "MacCame", "MacCamey", "MacCamie",
		"MacCamiey", "MacCammell", "MacCammie", "MacCammon", "MacCammond",
		"MacCamon", "MacCance", "MacCanch", "MacCanchie", "MacCandlish", "MacCane",
		"MacCanish", "MacCaniss", "MacCannally", "MacCannan", "MacCannel",
		"MacCannell", "MacCannon", "MacCanrig", "MacCanrik", "MacCans", "MacCanse",
		"MacCansh", "MacCants", "MacCaoidh", "MacCara", "MacCarday", "MacCardie",
		"MacCardney", "MacCardy", "MacCargo", "MacCarlach", "MacCarlich",
		"MacCarliche", "MacCarlie", "MacCarlycht", "MacCarmick", "MacCarmike",
		"MacCarnochan", "MacCarquhar", "MacCarra", "MacCarracher", "MacCarres",
		"MacCarron", "MacCarson", "MacCartnay", "MacCartney", "MacCary",
		"MacCasgill", "MacCasguill", "MacCash", "MacCaskall", "MacCaskel",
		"MacCaskell", "MacCaskie", "MacCaskil", "MacCaskill", "MacCaskin",
		"MacCaskle", "MacCaskull", "MacCaslan", "MacCasland", "MacCaslane",
		"MacCaslen", "MacCaslin", "MacCasline", "MacCathail", "MacCathay",
		"MacCathie", "MacCathy", "MacCauchquharn", "MacCaueis", "MacCaug",
		"MacCaughan", "MacCaughtrie", "MacCaughtry", "MacCauish", "MacCaul",
		"MacCaula", "MacCaulaw", "MacCaulay", "MacCauley", "MacCaull", "MacCauly",
		"MacCause", "MacCausland", "MacCavat", "MacCavell", "MacCavis", "MacCavish",
		"MacCavss", "MacCaw", "MacCawe", "MacCaweis", "MacCawis", "MacCawley",
		"MacCaws", "MacCay", "MacCayne", "MacCeachan", "MacCeachie", "MacCeallaich",
		"MacCeasag", "MacCeasaig", "MacCellaich", "MacCellair", "MacCeller",
		"MacCenzie", "MacCeol", "MacCersie", "MacCey", "MacChaddy", "MacChaffie",
		"MacChananaich", "MacChardaidh", "MacChardy", "MacCharles", "MacCharlie",
		"MacCheachan", "MacCheachie", "MacCherlich", "MacChesney", "MacCheyne",
		"MacChlerich", "MacChlery", "MacChoiter", "MacChomay", "MacChombeich",
		"MacChombich", "MacChomich", "MacChonachy", "MacChord", "MacChormaig",
		"MacChray", "MacChristian", "MacChristie", "MacChristy", "MacChritter",
		"MacChruimb", "MacChruitar", "MacChruiter", "MacChrummen", "MacChruter",
		"MacChruytor", "MacChrynnell", "MacChrystal", "MacChrytor", "MacChullach",
		"MacChurteer", "MacChuthais", "MacCill", "MacCisaig", "MacClachan",
		"MacClachane", "MacClacharty", "MacClacherty", "MacClachlane",
		"MacClachlene", "MacClae", "MacClaffirdy", "MacClagan", "MacClagane",
		"MacClagnan", "MacClaichlane", "MacClaine", "MacClairtick", "MacClallane",
		"MacClaman", "MacClamon", "MacClamroch", "MacClan", "MacClanachan",
		"MacClanaghan", "MacClanahan", "MacClanan", "MacClanaquhen", "MacClandon",
		"MacClane", "MacClannachan", "MacClannochan", "MacClannochane",
		"MacClannoquhen", "MacClanochan", "MacClanochane", "MacClanohan",
		"MacClanoquhen", "MacClansburgh", "MacClaran", "MacClaren", "MacClarence",
		"MacClarene", "MacClarens", "MacClaring", "MacClarren", "MacClarron",
		"MacClarsair", "MacClartie", "MacClarty", "MacClatchie", "MacClatchy",
		"MacClathan", "MacClauchlan", "MacClauchlane", "MacClauchlin", "MacClaugan",
		"MacClave", "MacClawrane", "MacClay", "MacClayne", "MacCleallane",
		"MacClean", "MacCleane", "MacClearen", "MacClearey", "MacCleary",
		"MacCleave", "MacCleay", "MacCleche", "MacClees", "MacCleiche",
		"MacCleilane", "MacCleisch", "MacCleish", "MacCleishe", "MacCleisich",
		"MacClelan", "MacClellan", "MacClelland", "MacClement", "MacClements",
		"MacClemont", "MacClen", "MacClenachan", "MacClenaghan", "MacClenaghen",
		"MacClenahan", "MacClenane", "MacClenden", "MacClendon", "MacCleneghan",
		"MacClenighan", "MacClennaghan", "MacClennan", "MacClennochan",
		"MacClennoquhan", "MacClennoquhen", "MacClenoquhan", "MacCleod",
		"MacCleoyd", "MacClerich", "MacCleriche", "MacClerie", "MacCleron",
		"MacClery", "MacClese", "MacClester", "MacCleud", "MacCleve", "MacClew",
		"MacCleys", "MacCliesh", "MacCliments", "MacClimont", "MacClingan",
		"MacClinie", "MacClinighan", "MacClinnie", "MacClintoch", "MacClintock",
		"MacClinton", "MacClirie", "MacCloaud", "MacCloid", "MacCloide",
		"MacClonachan", "MacClone", "MacCloo", "MacCloor", "MacClorty", "MacClory",
		"MacCloskey", "MacCloud", "MacClour", "MacCloy", "MacCloyd", "MacClucas",
		"MacClue", "MacClugash", "MacClugass", "MacClugeis", "MacCluie", "MacCluir",
		"MacCluire", "MacClullich", "MacClumpha", "MacClung", "MacClunochen",
		"MacClure", "MacClurich", "MacCluskey", "MacCluskie", "MacClusky",
		"MacClymond", "MacClymont", "MacClynyne", "MacCoag", "MacCoage", "MacCoaig",
		"MacCoal", "MacCoan", "MacCoard", "MacCoasam", "MacCoch", "MacCochran",
		"MacCock", "MacCodruim", "MacCodrum", "MacCoel", "MacCoid", "MacCoinnich",
		"MacCoirry", "MacCoiseam", "MacCole", "MacColeis", "MacColem", "MacColeman",
		"MacColl", "MacCollea", "MacColleis", "MacCollister", "MacColloch",
		"MacCollom", "MacCollum", "MacColly", "MacColm", "MacColmain", "MacColman",
		"MacColme", "MacColmie", "MacColmy", "MacColum", "MacComaidh", "MacComais",
		"MacComas", "MacComash", "MacComb", "MacCombe", "MacCombich", "MacCombie",
		"MacCombs", "MacCome", "MacComes", "MacComey", "MacComiche", "MacComick",
		"MacComie", "MacComish", "MacComiskey", "MacComok", "MacComtosh", "MacComy",
		"MacConacher", "MacConachie", "MacConachy", "MacConaghy", "MacConche",
		"MacConcher", "MacConchie", "MacConchy", "MacCondach", "MacCondachie",
		"MacCondachy", "MacCondie", "MacCondochie", "MacCondoquhy", "MacCondy",
		"MacConechie", "MacConechy", "MacConell", "MacConich", "MacConil",
		"MacConile", "MacConill", "MacConiquhy", "MacConkey", "MacConl",
		"MacConlea", "MacConnach", "MacConnacher", "MacConnachie", "MacConnaghy",
		"MacConnal", "MacConnchye", "MacConnechie", "MacConnechy", "MacConnel",
		"MacConnell", "MacConnichie", "MacConnil", "MacConnill", "MacConnochie",
		"MacConnoquhy", "MacConnquhy", "MacConnyll", "MacConochey", "MacConochie",
		"MacConoughey", "MacConquhar", "MacConquhie", "MacConquhy", "MacConquy",
		"MacCooish", "MacCook", "MacCool", "MacCorc", "MacCorcadail",
		"MacCorcadale", "MacCorcadill", "MacCord", "MacCordadill", "MacCoren",
		"MacCork", "MacCorkell", "MacCorker", "MacCorkie", "MacCorkil",
		"MacCorkill", "MacCorkindale", "MacCorkle", "MacCorley", "MacCormack",
		"MacCormaic", "MacCormaig", "MacCormick", "MacCormock", "MacCormok",
		"MacCornack", "MacCornick", "MacCornock", "MacCornok", "MacCorqudill",
		"MacCorquell", "MacCorquhedell", "MacCorquidall", "MacCorquidill",
		"MacCorquidle", "MacCorquodale", "MacCorquodill", "MacCorquydill",
		"MacCorrie", "MacCorron", "MacCorry", "MacCorvie", "MacCorwis", "MacCory",
		"MacCosch", "MacCosh", "MacCosham", "MacCoshan", "MacCoshen", "MacCoshim",
		"MacCoshin", "MacCosker", "MacCoskery", "MacCoskrie", "MacCoskry",
		"MacCoubray", "MacCoubrey", "MacCoubrie", "MacCouck", "MacCoug", "MacCouil",
		"MacCouk", "MacCouke", "MacCoul", "MacCoulach", "MacCoulagh", "MacCoulaghe",
		"MacCoule", "MacCoull", "MacCoun", "MacCourich", "MacCourt", "MacCouyll",
		"MacCowag", "MacCowan", "MacCowatt", "MacCowbyn", "MacCowell", "MacCowen",
		"MacCowig", "MacCowil", "MacCowir", "MacCowis", "MacCowl", "MacCowlach",
		"MacCowle", "MacCowley", "MacCowne", "MacCoy", "MacCoyle", "MacCoynich",
		"MacCra", "MacCrabit", "MacCraccan", "MacCrach", "MacCrachan", "MacCrachen",
		"MacCrackan", "MacCracken", "MacCrae", "MacCraich", "MacCraie",
		"MacCraikane", "MacCrain", "MacCraing", "MacCraith", "MacCraken", "MacCran",
		"MacCrane", "MacCrary", "MacCrastyne", "MacCrath", "MacCravey", "MacCraw",
		"MacCray", "MacCrea", "MacCreaddie", "MacCreadie", "MacCreary", "MacCreath",
		"MacCreavie", "MacCreavy", "MacCreddan", "MacCredie", "MacCree",
		"MacCreerie", "MacCreery", "MacCreich", "MacCreiff", "MacCreigh",
		"MacCreight", "MacCreire", "MacCreirie", "MacCreitche", "MacCreith",
		"MacCrekan", "MacCrekane", "MacCrendill", "MacCrenild", "MacCreory",
		"MacCrerie", "MacCrery", "MacCrevey", "MacCrewer", "MacCrewir", "MacCrie",
		"MacCrime", "MacCrimmon", "MacCrindell", "MacCrindill", "MacCrindle",
		"MacCrire", "MacCririck", "MacCririe", "MacCristal", "MacCriste",
		"MacCristie", "MacCristin", "MacCristine", "MacCriuer", "MacCrivag",
		"MacCriver", "MacCrobert", "MacCrobie", "MacCrokane", "MacCrom", "MacCron",
		"MacCrone", "MacCrore", "MacCrorie", "MacCrory", "MacCroskie", "MacCrossan",
		"MacCrotter", "MacCrouder", "MacCrouther", "MacCrow", "MacCrowther",
		"MacCroy", "MacCruar", "MacCruimein", "MacCrum", "MacCrumb", "MacCrume",
		"MacCrumen", "MacCrumie", "MacCrundle", "MacCrunnell", "MacCryndill",
		"MacCryndle", "MacCrynell", "MacCrynill", "MacCrynnell", "MacCrynnill",
		"MacCuabain", "MacCuag", "MacCuaig", "MacCuail", "MacCuaill", "MacCualraig",
		"MacCuaraig", "MacCubben", "MacCubbin", "MacCubbine", "MacCubbing",
		"MacCubbon", "MacCubein", "MacCubeine", "MacCuben", "MacCubene",
		"MacCubine", "MacCubyn", "MacCubyne", "MacCucheon", "MacCudden", "MacCudie",
		"MacCue", "MacCueish", "MacCuffie", "MacCug", "MacCuiag", "MacCuidhean",
		"MacCuig", "MacCuilam", "MacCuile", "MacCuimrid", "MacCuinn", "MacCuir",
		"MacCuish", "MacCuishe", "MacCuistan", "MacCuisten", "MacCuistion",
		"MacCuiston", "MacCuithean", "MacCuithein", "MacCuk", "MacCuley",
		"MacCulican", "MacCuligan", "MacCuligin", "MacCulikan", "MacCuliken",
		"MacCullach", "MacCullagh", "MacCullaghe", "MacCullaigh", "MacCullan",
		"MacCullauch", "MacCullen", "MacCulliam", "MacCullie", "MacCullin",
		"MacCullion", "MacCullo", "MacCulloch", "MacCullocht", "MacCullogh",
		"MacCulloh", "MacCullom", "MacCullough", "MacCullum", "MacCully",
		"MacCulzian", "MacCune", "MacCunn", "MacCuoch", "MacCur", "MacCurchie",
		"MacCurdie", "MacCurdy", "MacCure", "MacCurich", "MacCurie", "MacCurrach",
		"MacCurragh", "MacCurrich", "MacCurrie", "MacCurry", "MacCurtain",
		"MacCurthy", "MacCusack", "MacCusker", "MacCutchan", "MacCutchen",
		"MacCutcheon", "MacCutchion", "MacCuthaig", "MacCuthan", "MacCutheon",
		"MacCwne", "MacDade", "MacDaid", "MacDairmid", "MacDairmint", "MacDanel",
		"MacDaniel", "MacDaniell", "MacDarmid", "MacDavid", "MacDearmid",
		"MacDearmont", "MacDermaid", "MacDermand", "MacDerment", "MacDermid",
		"MacDermont", "MacDermot", "MacDermott", "MacDhiarmaid", "MacDhomhnuill",
		"MacDhonchaidh", "MacDhonnachie", "MacDhugal", "MacDhughaill", "MacDiarmid",
		"MacDiarmond", "MacDill", "MacDimslea", "MacDoaniel", "MacDogall",
		"MacDole", "MacDoll", "MacDonach", "MacDonachie", "MacDonachy", "MacDonagh",
		"MacDonald", "MacDonart", "MacDonchy", "MacDonell", "MacDonill",
		"MacDonleavy", "MacDonnach", "MacDonnchaidh", "MacDonnel", "MacDonnell",
		"MacDonnill", "MacDonnslae", "MacDonnyle", "MacDonochie", "MacDonol",
		"MacDonoll", "MacDonough", "MacDonquhy", "MacDonyll", "MacDool",
		"MacDormond", "MacDouagh", "MacDoual", "MacDouall", "MacDouell",
		"MacDougal", "MacDougald", "MacDougall", "MacDoughal", "MacDougle",
		"MacDoul", "MacDouny", "MacDouwille", "MacDouyl", "MacDovall", "MacDovele",
		"MacDoville", "MacDovylle", "MacDowal", "MacDowale", "MacDowall",
		"MacDowalle", "MacDowele", "MacDowell", "MacDowelle", "MacDowile",
		"MacDowille", "MacDowilt", "MacDowll", "MacDowylle", "MacDoyle", "MacDrain",
		"MacDual", "MacDuall", "MacDuel", "MacDuff", "MacDuffee", "MacDuffie",
		"MacDuffy", "MacDugal", "MacDugald", "MacDuhile", "MacDule", "MacDull",
		"MacDulothe", "MacDuncan", "MacDunlane", "MacDunleavy", "MacDunlewe",
		"MacDunslea", "MacDuoel", "MacDuphe", "MacDuthie", "MacDuwell", "MacDuwyl",
		"MacEachain", "MacEachainn", "MacEachan", "MacEachane", "MacEacharin",
		"MacEacharne", "MacEachearn", "MacEachen", "MacEacheran", "MacEachern",
		"MacEachin", "MacEachine", "MacEachnie", "MacEachny", "MacEachran",
		"MacEachren", "MacEalair", "MacEan", "MacEane", "MacEanruig",
		"MacEantailyeour", "MacEarachar", "MacEaracher", "MacEchan", "MacEcheny",
		"MacEchern", "MacEcherns", "MacEchnie", "MacEda", "MacEddie", "MacEgie",
		"MacEinzie", "MacEiver", "MacElduff", "MacEleary", "MacEletyn",
		"MacElfresh", "MacElfrish", "MacElhatton", "MacElheran", "MacElherran",
		"MacEllar", "MacEllere", "MacElligatt", "MacElpersoun", "MacElrath",
		"MacElroy", "MacElvain", "MacElveen", "MacElwain", "MacEmlinn", "MacEnrick",
		"MacEntyre", "MacEnzie", "MacEogan", "MacEoghainn", "MacEoghann", "MacEoin",
		"MacEol", "MacEracher", "MacErar", "MacErchar", "MacErracher",
		"MacErrocher", "MacEsayg", "MacEth", "MacEthe", "MacEtterick", "MacEttrick",
		"MacEuchine", "MacEuen", "MacEuer", "MacEuir", "MacEun", "MacEur",
		"MacEure", "MacEvan", "MacEvar", "MacEven", "MacEver", "MacEvin",
		"MacEvine", "MacEvoy", "MacEwan", "MacEwen", "MacEwer", "MacEwin",
		"MacEwine", "MacEwing", "MacEwingstoun", "MacEwir", "MacEwn", "MacEwyre",
		"MacFadden", "MacFaddrik", "MacFade", "MacFaden", "MacFadin", "MacFadion",
		"MacFadrick", "MacFadwyn", "MacFadyean", "MacFadyen", "MacFadyon",
		"MacFadzan", "MacFadzean", "MacFadzein", "MacFadzeon", "MacFaell",
		"MacFagan", "MacFaid", "MacFail", "MacFait", "MacFaitt", "MacFaktur",
		"MacFal", "MacFale", "MacFall", "MacFargus", "MacFarlan", "MacFarland",
		"MacFarlane", "MacFarlen", "MacFarlin", "MacFarling", "MacFarquhar",
		"MacFarquher", "MacFarsane", "MacFarsne", "MacFarson", "MacFate",
		"MacFater", "MacFather", "MacFatridge", "MacFattin", "MacFaul", "MacFauld",
		"MacFaull", "MacFayden", "MacFayle", "MacFead", "MacFeat", "MacFeate",
		"MacFeaters", "MacFedden", "MacFederan", "MacFedran", "MacFedrice",
		"MacFee", "MacFeeters", "MacFegan", "MacFerchar", "MacFergus", "MacFerlane",
		"MacFerquhair", "MacFerquhare", "MacFerries", "MacFerson", "MacFersoune",
		"MacFetridge", "MacFey", "MacFeyden", "MacFeye", "MacFie", "MacFingan",
		"MacFingon", "MacFingone", "MacFinnan", "MacFinnen", "MacFinnon",
		"MacFleger", "MacFoill", "MacForsoun", "MacForsyth", "MacFrederick",
		"MacFrizzel", "MacFrizzell", "MacFrizzle", "MacFuirigh", "MacFuktor",
		"MacFuktur", "MacFun", "MacFunie", "MacFunn", "MacFyall", "MacFydeane",
		"MacFyngoun", "MacGaa", "MacGabhawn", "MacGachan", "MacGachand",
		"MacGacharne", "MacGachen", "MacGachey", "MacGachie", "MacGachyn",
		"MacGaghen", "MacGaichan", "MacGaithan", "MacGal", "MacGall", "MacGannet",
		"MacGaradh", "MacGaraidh", "MacGarmorie", "MacGarmory", "MacGarra",
		"MacGarrow", "MacGarva", "MacGarvey", "MacGarvie", "MacGaskell",
		"MacGaskill", "MacGauchan", "MacGauchane", "MacGauchin", "MacGaughrin",
		"MacGaugie", "MacGaukie", "MacGaulay", "MacGavin", "MacGaw", "MacGawley",
		"MacGaychin", "MacGe", "MacGeachan", "MacGeachen", "MacGeachie",
		"MacGeachin", "MacGeachy", "MacGeaghy", "MacGeak", "MacGechan", "MacGechie",
		"MacGee", "MacGeechan", "MacGeever", "MacGehee", "MacGeil", "MacGeoch",
		"MacGeoraidh", "MacGeorge", "MacGeouch", "MacGermorie", "MacGeth",
		"MacGethe", "MacGetrick", "MacGettrich", "MacGettrick", "MacGeuchie",
		"MacGey", "MacGhee", "MacGhey", "MacGhie", "MacGhillefhiondaig",
		"MacGhilleghuirm", "MacGhittich", "MacGhobhainn", "MacGhoill", "MacGhowin",
		"MacGhye", "MacGibbon", "MacGibbone", "MacGibboney", "MacGibon",
		"MacGibonesoun", "MacGiboun", "MacGibson", "MacGie", "MacGigh",
		"MacGilbert", "MacGilbothan", "MacGilbride", "MacGilcallum",
		"MacGilchatton", "MacGilchois", "MacGilchrist", "MacGilcreist",
		"MacGilcrist", "MacGildhui", "MacGilduff", "MacGildui", "MacGile",
		"MacGilelan", "MacGilevie", "MacGilewe", "MacGilfatrick", "MacGilfatrik",
		"MacGilfinan", "MacGilfud", "MacGilhosche", "MacGiligan", "MacGiliver",
		"MacGill", "MacGilladubh", "MacGillalane", "MacGillanders", "MacGillandras",
		"MacGillandrew", "MacGillandrish", "MacGillane", "MacGillas",
		"MacGillavary", "MacGillavery", "MacGillavrach", "MacGillayne",
		"MacGilldowie", "MacGille", "MacGilleanan", "MacGilleathain",
		"MacGillebeatha", "MacGillechallum", "MacGillechaluim", "MacGillechattan",
		"MacGillecoan", "MacGillecongall", "MacGilledow", "MacGilleduf",
		"MacGilleduibh", "MacGillefatrik", "MacGillefedder", "MacGilleghuirm",
		"MacGilleglash", "MacGillegowie", "MacGillegrum", "MacGilleis",
		"MacGillelan", "MacGillelane", "MacGillemartin", "MacGillemertin",
		"MacGillemhicheil", "MacGillemichael", "MacGillemichel", "MacGillemitchell",
		"MacGillemithel", "MacGillenan", "MacGilleoin", "MacGilleon", "MacGilleone",
		"MacGilleoun", "MacGilleoune", "MacGillepartik", "MacGillepatrick",
		"MacGillepatrik", "MacGillephadrick", "MacGillephadruig", "MacGillequhoan",
		"MacGillequhoane", "MacGillereach", "MacGillereith", "MacGillereoch",
		"MacGillery", "MacGillese", "MacGillevary", "MacGillevoray",
		"MacGillevorie", "MacGillevray", "MacGillewe", "MacGillewey",
		"MacGillewhome", "MacGillewie", "MacGillewra", "MacGillewray",
		"MacGillewriche", "MacGillewy", "MacGillewye", "MacGillfhaolain",
		"MacGillhois", "MacGillibride", "MacGillican", "MacGillichalloum",
		"MacGillichoan", "MacGillichoane", "MacGilliduffi", "MacGilliegorm",
		"MacGillies", "MacGilliewie", "MacGillifudricke", "MacGilligain",
		"MacGilligan", "MacGilligin", "MacGilligowie", "MacGilligowy",
		"MacGillimichael", "MacGillinnein", "MacGilliondaig", "MacGillip",
		"MacGilliphatrick", "MacGilliquhome", "MacGillirick", "MacGillis",
		"MacGillish", "MacGilliue", "MacGillivantic", "MacGillivary",
		"MacGilliveide", "MacGilliver", "MacGillivoor", "MacGillivraid",
		"MacGillivray", "MacGillivrie", "MacGillivry", "MacGilliwie",
		"MacGillmichell", "MacGillmitchell", "MacGillochoaine", "MacGillogowy",
		"MacGillolane", "MacGillon", "MacGillonie", "MacGillony", "MacGillop",
		"MacGillowray", "MacGilloyne", "MacGillphatrik", "MacGillreavy",
		"MacGillreick", "MacGillvane", "MacGillvary", "MacGillveray", "MacGillvery",
		"MacGillvra", "MacGillvray", "MacGillyane", "MacGilmartine", "MacGilmichal",
		"MacGilmichel", "MacGilmor", "MacGilnew", "MacGilp", "MacGilparick",
		"MacGilphadrick", "MacGilpharick", "MacGilrey", "MacGilroy", "MacGilroye",
		"MacGilvane", "MacGilvar", "MacGilvary", "MacGilveil", "MacGilvern",
		"MacGilvernock", "MacGilvernoel", "MacGilvery", "MacGilvie", "MacGilvory",
		"MacGilvra", "MacGilvray", "MacGilweane", "MacGilwrey", "MacGimpsie",
		"MacGimpsy", "MacGinnis", "MacGirr", "MacGiver", "MacGivern", "MacGlade",
		"MacGladrie", "MacGlagan", "MacGlashan", "MacGlashen", "MacGlashin",
		"MacGlasrich", "MacGlassan", "MacGlasserig", "MacGlassin", "MacGlasson",
		"MacGlassrich", "MacGlauchlin", "MacGlauflin", "MacGleane", "MacGledrie",
		"MacGleish", "MacGlenaghan", "MacGlenan", "MacGlennon", "MacGlew",
		"MacGlone", "MacGlugas", "MacGoldrick", "MacGomerie", "MacGomery",
		"MacGonnal", "MacGonnel", "MacGooch", "MacGorie", "MacGorlick",
		"MacGormick", "MacGormock", "MacGorre", "MacGorrie", "MacGorry", "MacGory",
		"MacGouan", "MacGougan", "MacGoun", "MacGoune", "MacGovin", "MacGow",
		"MacGowan", "MacGowen", "MacGown", "MacGowne", "MacGowy", "MacGra",
		"MacGrader", "MacGrae", "MacGrail", "MacGrain", "MacGranahan", "MacGrane",
		"MacGrasaych", "MacGrassych", "MacGrassycht", "MacGrasycht", "MacGrath",
		"MacGraw", "MacGrayych", "MacGreagh", "MacGreal", "MacGreen", "MacGregare",
		"MacGregor", "MacGregur", "MacGreigor", "MacGreil", "MacGreill",
		"MacGreische", "MacGreish", "MacGresche", "MacGresich", "MacGressich",
		"MacGressiche", "MacGreusach", "MacGreusaich", "MacGreusich", "MacGrevar",
		"MacGrewar", "MacGrewer", "MacGriger", "MacGrigor", "MacGrigour",
		"MacGrime", "MacGrimen", "MacGrimmon", "MacGrindal", "MacGroary",
		"MacGrory", "MacGrouther", "MacGrowder", "MacGrowther", "MacGruaig",
		"MacGruar", "MacGrudaire", "MacGrudder", "MacGruder", "MacGruer",
		"MacGrundle", "MacGrury", "MacGruthar", "MacGruther", "MacGuaig",
		"MacGuaran", "MacGuarie", "MacGuarrie", "MacGubb", "MacGubbin", "MacGuckin",
		"MacGuffey", "MacGuffie", "MacGuffoc", "MacGuffock", "MacGuffog",
		"MacGugan", "MacGuigan", "MacGuill", "MacGuilvery", "MacGuin", "MacGuire",
		"MacGuistan", "MacGulican", "MacGumeraitt", "MacGunnion", "MacGuoga",
		"MacGurgh", "MacGurk", "MacGurkich", "MacGy", "MacGybbon", "MacGye",
		"MacGyll", "MacGyllepatric", "MacHael", "MacHaffey", "MacHaffie",
		"MacHaffine", "MacHamish", "MacHans", "MacHarday", "MacHardie", "MacHardy",
		"MacHarg", "MacHarold", "MacHarrie", "MacHarrold", "MacHarry", "MacHarvie",
		"MacHatton", "MacHay", "MacHee", "MacHendric", "MacHendrie", "MacHendry",
		"MacHenish", "MacHenrie", "MacHenrik", "MacHenry", "MacHerlick",
		"MacHerloch", "MacHerres", "MacHerries", "MacHeth", "MacHethrick",
		"MacHgie", "MacHieson", "MacHilliegowie", "MacHillies", "MacHilmane",
		"MacHinch", "MacHinzie", "MacHlachlan", "MacHnight", "MacHoiter",
		"MacHomas", "MacHomash", "MacHomie", "MacHonel", "MacHonichy", "MacHouat",
		"MacHoul", "MacHoule", "MacHouston", "MacHoutton", "MacHowell",
		"MacHpatrick", "MacHquan", "MacHquhan", "MacHray", "MacHrudder",
		"MacHruder", "MacHrurter", "MacHruter", "MacHuat", "MacHucheon",
		"MacHucheoun", "MacHugh", "MacHuin", "MacHuiston", "MacHuitcheon",
		"MacHulagh", "MacHullie", "MacHutchen", "MacHutcheon", "MacHutchin",
		"MacHutchison", "MacHutchon", "MacHutchoun", "MacHyntoys", "MacIain",
		"MacIan", "MacIkin", "MacIlaine", "MacIlandick", "MacIlaraith",
		"MacIlarith", "MacIlbowie", "MacIlbraie", "MacIlbreid", "MacIlbrick",
		"MacIlbryd", "MacIlbuie", "MacIlchattan", "MacIlchoan", "MacIlchoane",
		"MacIlchoen", "MacIlchombie", "MacIlchomhghain", "MacIlchomich",
		"MacIlchomie", "MacIlchomy", "MacIlchreist", "MacIlchrom", "MacIlchrum",
		"MacIlchrumie", "MacIlcrist", "MacIlday", "MacIldeu", "MacIldeus",
		"MacIldew", "MacIldonich", "MacIldoui", "MacIldowie", "MacIldowy",
		"MacIldue", "MacIlduf", "MacIlduff", "MacIlduy", "MacIlees", "MacIleish",
		"MacIlelan", "MacIlendrish", "MacIleollan", "MacIlergan", "MacIlerith",
		"MacIleur", "MacIlewe", "MacIlfadrich", "MacIlfatrik", "MacIlfun",
		"MacIlghuie", "MacIlglegane", "MacIlguie", "MacIlguy", "MacIlhaffie",
		"MacIlhagga", "MacIlhane", "MacIlhaos", "MacIlhatton", "MacIlhauch",
		"MacIlhaugh", "MacIlhench", "MacIlheran", "MacIlherran", "MacIlhois",
		"MacIlhoise", "MacIlhose", "MacIlhouse", "MacIliphadrick", "MacIlishe",
		"MacIliwray", "MacIllaine", "MacIllandarish", "MacIllandick", "MacIllayn",
		"MacIllbride", "MacIlleain", "MacIllechallum", "MacIllees", "MacIlleese",
		"MacIlleglass", "MacIlleish", "MacIlleland", "MacIllenane",
		"MacIllepatrick", "MacIllephadrick", "MacIllephedder", "MacIllepheder",
		"MacIllephudrick", "MacIllereoch", "MacIllereoche", "MacIllergin",
		"MacIlleriach", "MacIllevorie", "MacIllewe", "MacIllewie", "MacIllfatrick",
		"MacIllfreish", "MacIllfrice", "MacIllhois", "MacIllhos", "MacIllhose",
		"MacIllhuy", "MacIllichoan", "MacIlliduy", "MacIllimhier", "MacIlliruaidh",
		"MacIllon", "MacIllory", "MacIllreach", "MacIllreave", "MacIllrevie",
		"MacIllrick", "MacIllvain", "MacIllveyan", "MacIllvra", "MacIllwrick",
		"MacIlmanus", "MacIlmartine", "MacIlmeane", "MacIlmeine", "MacIlmertin",
		"MacIlmeyne", "MacIlmichael", "MacIlmichaell", "MacIlmichall",
		"MacIlmichell", "MacIlmorie", "MacIlmorrow", "MacIlmoun", "MacIlmune",
		"MacIlmunn", "MacIlna", "MacIlnae", "MacIlnaey", "MacIlneive", "MacIlnew",
		"MacIloray", "MacIloure", "MacIlpadrick", "MacIlpatrick", "MacIlpedder",
		"MacIlquham", "MacIlquhan", "MacIlra", "MacIlraich", "MacIlraith",
		"MacIlravey", "MacIlravie", "MacIlray", "MacIlreach", "MacIlreath",
		"MacIlreave", "MacIlrevie", "MacIlriach", "MacIlrie", "MacIlrith",
		"MacIlrivich", "MacIlroy", "MacIlroych", "MacIluraick", "MacIluray",
		"MacIlurick", "MacIlvail", "MacIlvain", "MacIlvaine", "MacIlvane",
		"MacIlvar", "MacIlvayne", "MacIlvean", "MacIlveane", "MacIlveen",
		"MacIlveerie", "MacIlvern", "MacIlvernock", "MacIlvery", "MacIlvian",
		"MacIlvora", "MacIlvoray", "MacIlvory", "MacIlvra", "MacIlvrach",
		"MacIlvrae", "MacIlvraith", "MacIlvray", "MacIlvreed", "MacIlvride",
		"MacIlwain", "MacIlwaine", "MacIlweine", "MacIlwham", "MacIlwhannel",
		"MacIlwhom", "MacIlwra", "MacIlwraith", "MacIlwraithe", "MacIlwrathe",
		"MacIlwray", "MacIlwrick", "MacIlwrith", "MacImmey", "MacImmie", "MacInair",
		"MacInally", "MacInas", "MacInayr", "MacIncaird", "MacInchruter",
		"MacInclerich", "MacInclerie", "MacInclerycht", "MacIndeoir", "MacIndeor",
		"MacIndoe", "MacIndoer", "MacInechy", "MacIneskair", "MacInesker",
		"MacInferson", "MacIngvale", "MacInisker", "MacInkaird", "MacInkeard",
		"MacInlaintaig", "MacInleaster", "MacInleister", "MacInlester",
		"MacInlister", "MacInnes", "MacInnesh", "MacInneskar", "MacInnesker",
		"MacInness", "MacInnis", "MacInnisch", "MacInnish", "MacInnocater",
		"MacInnon", "MacInnowcater", "MacInnowcatter", "MacInnuer", "MacInnugatour",
		"MacInnuier", "MacInnyeir", "MacInocader", "MacInroy", "MacInstalker",
		"MacInstokir", "MacInstray", "MacInstrie", "MacInstry", "MacInstucker",
		"MacIntagart", "MacIntagerit", "MacIntailyeour", "MacIntargart",
		"MacIntayleor", "MacIntaylor", "MacInteer", "MacInthosse", "MacIntioch",
		"MacIntire", "MacIntoch", "MacIntoschecht", "MacIntoschie", "MacIntoschye",
		"MacIntosh", "MacInturner", "MacIntyir", "MacIntyller", "MacIntylor",
		"MacIntyr", "MacIntyre", "MacInuair", "MacInuar", "MacInuctar",
		"MacInucter", "MacInuire", "MacInuyer", "MacInvaille", "MacInvale",
		"MacInvalloch", "MacInville", "MacInvine", "MacIock", "MacIosaig",
		"MacIphie", "MacIrvine", "MacIsaac", "MacIsaak", "MacIsack", "MacIsaick",
		"MacIsak", "MacIseik", "MacIsh", "MacIssac", "MacIstalkir", "MacIttrick",
		"MacIvar", "MacIver", "MacIverach", "MacIvirach", "MacIvor", "MacIye",
		"MacJames", "MacJamis", "MacJanet", "MacJannet", "MacJarrow", "MacJerrow",
		"MacJiltroch", "MacJock", "MacJore", "MacK", "MacKa", "MacKaa", "MacKaay",
		"MacKadam", "MacKadem", "MacKadie", "MacKaggie", "MacKai", "MacKaig",
		"MacKaige", "MacKaigh", "MacKail", "MacKaill", "MacKain", "MacKainzie",
		"MacKairlie", "MacKairly", "MacKaiscal", "MacKaiskill", "MacKalar",
		"MacKale", "MacKalexander", "MacKall", "MacKalla", "MacKallan", "MacKallay",
		"MacKallister", "MacKalpie", "MacKalpin", "MacKame", "MacKames", "MacKance",
		"MacKandrew", "MacKane", "MacKanrig", "MacKantoiss", "MacKants",
		"MacKanyss", "MacKanze", "MacKaras", "MacKardie", "MacKarlich", "MacKascal",
		"MacKaskil", "MacKaskill", "MacKaskin", "MacKau", "MacKaula", "MacKauley",
		"MacKaw", "MacKawe", "MacKawes", "MacKay", "MacKbayth", "MacKbrid",
		"MacKcaige", "MacKchonchie", "MacKcline", "MacKconil", "MacKconnell",
		"MacKcook", "MacKcoul", "MacKcrae", "MacKcrain", "MacKcrow", "MacKcrumb",
		"MacKculloch", "MacKdowall", "MacKe", "MacKeachan", "MacKeachie",
		"MacKeachy", "MacKeag", "MacKeamish", "MacKean", "MacKeand", "MacKeandla",
		"MacKeane", "MacKeanzie", "MacKearass", "MacKeardie", "MacKearlie",
		"MacKearly", "MacKearrois", "MacKearsie", "MacKeaver", "MacKeay",
		"MacKecherane", "MacKechern", "MacKechnie", "MacKechran", "MacKechrane",
		"MacKechren", "MacKeddey", "MacKeddie", "MacKedy", "MacKee", "MacKeech",
		"MacKeechan", "MacKeeg", "MacKeekine", "MacKeenan", "MacKeesick",
		"MacKeever", "MacKeevor", "MacKegg", "MacKeggie", "MacKeich", "MacKeig",
		"MacKeihan", "MacKeil", "MacKein", "MacKeinezie", "MacKeinzie",
		"MacKeissik", "MacKeith", "MacKeithan", "MacKeithen", "MacKeiver",
		"MacKeiy", "MacKelar", "MacKelbride", "MacKeldey", "MacKeldowie",
		"MacKelecan", "MacKelegan", "MacKelein", "MacKeleran", "MacKelican",
		"MacKell", "MacKellachie", "MacKellaich", "MacKellaig", "MacKellaigh",
		"MacKellar", "MacKellayr", "MacKeller", "MacKelloch", "MacKellor",
		"MacKelly", "MacKelpin", "MacKelrae", "MacKelvain", "MacKelvey",
		"MacKelvie", "MacKemie", "MacKemmie", "MacKemy", "MacKena", "MacKenabry",
		"MacKendric", "MacKendrich", "MacKendrick", "MacKendrie", "MacKendrig",
		"MacKendry", "MacKenen", "MacKeney", "MacKenezie", "MacKenich", "MacKenie",
		"MacKenmie", "MacKenna", "MacKennah", "MacKennan", "MacKennane",
		"MacKennay", "MacKenney", "MacKenrick", "MacKentase", "MacKentyre",
		"MacKenyee", "MacKenyie", "MacKenzie", "MacKenzy", "MacKeochan", "MacKeon",
		"MacKeowan", "MacKeown", "MacKeracher", "MacKeracken", "MacKeraish",
		"MacKeras", "MacKerchar", "MacKercher", "MacKerdie", "MacKerichar",
		"MacKericher", "MacKerley", "MacKerlich", "MacKerliche", "MacKerlie",
		"MacKerloch", "MacKermick", "MacKern", "MacKernock", "MacKerracher",
		"MacKerral", "MacKerras", "MacKerrel", "MacKerricher", "MacKerrin",
		"MacKerris", "MacKerron", "MacKerrow", "MacKersey", "MacKersie", "MacKersy",
		"MacKesek", "MacKesk", "MacKessack", "MacKessick", "MacKessock",
		"MacKessog", "MacKessogg", "MacKeswal", "MacKethan", "MacKethe",
		"MacKethrick", "MacKetterick", "MacKettrick", "MacKeur", "MacKeurtain",
		"MacKever", "MacKevin", "MacKevor", "MacKevors", "MacKew", "MacKewan",
		"MacKewer", "MacKewin", "MacKewish", "MacKewn", "MacKewnie", "MacKewyne",
		"MacKewyr", "MacKey", "MacKeyoche", "MacKfarlen", "MacKghie", "MacKgil",
		"MacKglesson", "MacKhardie", "MacKhimy", "MacKhonachy", "MacKiachan",
		"MacKiaran", "MacKiarran", "MacKibbin", "MacKibbon", "MacKichan", "MacKick",
		"MacKiddie", "MacKie", "MacKiech", "MacKiehan", "MacKigg", "MacKiggan",
		"MacKildaiye", "MacKildash", "MacKilday", "MacKilferson", "MacKilhaffy",
		"MacKilhoise", "MacKilican", "MacKilikin", "MacKill", "MacKillaig",
		"MacKille", "MacKilleane", "MacKillenane", "MacKillhose", "MacKilliam",
		"MacKillib", "MacKillican", "MacKillicane", "MacKillichane",
		"MacKillichoan", "MacKilligan", "MacKilligane", "MacKilligin",
		"MacKillimichael", "MacKillip", "MacKillmartine", "MacKillmichaell",
		"MacKillop", "MacKillor", "MacKilmichael", "MacKilmichel", "MacKilmine",
		"MacKilmon", "MacKilmoun", "MacKilmun", "MacKilmune", "MacKilmurray",
		"MacKilpatrick", "MacKilquhone", "MacKilrae", "MacKilrea", "MacKilroy",
		"MacKiltosche", "MacKilvain", "MacKilvane", "MacKilven", "MacKilvie",
		"MacKilwein", "MacKilweyan", "MacKilwraith", "MacKilwrath", "MacKilwyan",
		"MacKim", "MacKimmie", "MacKimmy", "MacKindel", "MacKindew", "MacKindlay",
		"MacKindle", "MacKinfarsoun", "MacKinin", "MacKinish", "MacKinla",
		"MacKinlay", "MacKinley", "MacKinna", "MacKinnay", "MacKinnel",
		"MacKinnell", "MacKinnen", "MacKinnes", "MacKinneskar", "MacKinness",
		"MacKinney", "MacKinnie", "MacKinning", "MacKinnis", "MacKinnoch",
		"MacKinnon", "MacKinoun", "MacKinsagart", "MacKinshe", "MacKinstay",
		"MacKinstrey", "MacKinstrie", "MacKinstry", "MacKintaggart",
		"MacKintaylzeor", "MacKintishie", "MacKintoch", "MacKintoche",
		"MacKintoisch", "MacKintorss", "MacKintosh", "MacKintyre", "MacKinven",
		"MacKinyie", "MacKinze", "MacKinzie", "MacKiock", "MacKirchan", "MacKirdie",
		"MacKirdy", "MacKirsty", "MacKisack", "MacKiseck", "MacKissack",
		"MacKissek", "MacKissick", "MacKissoch", "MacKissock", "MacKistock",
		"MacKithan", "MacKitterick", "MacKittrick", "MacKiver", "MacKivers",
		"MacKivirrich", "MacKiynnan", "MacKjames", "MacKlagan", "MacKlain",
		"MacKlan", "MacKlanachen", "MacKlanan", "MacKlane", "MacKlannan",
		"MacKlarain", "MacKlawchlane", "MacKlawklane", "MacKlechreist",
		"MacKlehois", "MacKleiry", "MacKlellan", "MacKlellane", "MacKlemin",
		"MacKlemurray", "MacKlen", "MacKlenden", "MacKlendon", "MacKleod",
		"MacKleroy", "MacKlewain", "MacKlewraith", "MacKlin", "MacKlinnan",
		"MacKlowis", "MacKluire", "MacKmaster", "MacKmillan", "MacKmorran",
		"MacKmunish", "MacKmurrie", "MacKnabe", "MacKnach", "MacKnacht", "MacKnae",
		"MacKnaer", "MacKnaight", "MacKnair", "MacKnaire", "MacKnaught",
		"MacKnaughtane", "MacKnawcht", "MacKnaycht", "MacKnayt", "MacKne",
		"MacKneach", "MacKneale", "MacKnedar", "MacKnee", "MacKneicht", "MacKneis",
		"MacKneische", "MacKneishe", "MacKnellan", "MacKness", "MacKnicht",
		"MacKnie", "MacKnight", "MacKnilie", "MacKnily", "MacKnish", "MacKnitt",
		"MacKnockater", "MacKnocker", "MacKnockiter", "MacKnokaird", "MacKoen",
		"MacKomash", "MacKomie", "MacKommie", "MacKomy", "MacKonald", "MacKondachy",
		"MacKone", "MacKonnell", "MacKonochie", "MacKork", "MacKorkitill",
		"MacKorkyll", "MacKornock", "MacKornok", "MacKouchane", "MacKoull",
		"MacKoun", "MacKowean", "MacKowen", "MacKowie", "MacKowin", "MacKowle",
		"MacKowloch", "MacKowloche", "MacKowne", "MacKownne", "MacKowyne",
		"MacKperson", "MacKphaill", "MacKpharsone", "MacKqueane", "MacKquyne",
		"MacKra", "MacKrachin", "MacKrae", "MacKraith", "MacKraken", "MacKray",
		"MacKrayth", "MacKreath", "MacKree", "MacKreiche", "MacKrekane",
		"MacKrenald", "MacKrenele", "MacKrie", "MacKritchy", "MacKrory", "MacKuen",
		"MacKuenn", "MacKuerdy", "MacKuffie", "MacKuinn", "MacKuir", "MacKuish",
		"MacKukan", "MacKulagh", "MacKulican", "MacKullie", "MacKulloch",
		"MacKullouch", "MacKune", "MacKuntosche", "MacKunuchie", "MacKure",
		"MacKurerdy", "MacKurkull", "MacKurrich", "MacKury", "MacKush", "MacKusick",
		"MacKussack", "MacKwarrathy", "MacKwatt", "MacKwhinney", "MacKwilliam",
		"MacKy", "MacKye", "MacKygo", "MacKym", "MacKymmie", "MacKynich",
		"MacKynioyss", "MacKynnair", "MacKynnay", "MacKynnayr", "MacKynnell",
		"MacKynnie", "MacKyntagart", "MacKyntaggart", "MacKyntalyhur",
		"MacKyntoich", "MacKyntossche", "MacKyntoys", "MacKyrnele", "MacLabhrain",
		"MacLabhruinn", "MacLachan", "MacLachie", "MacLachlainn", "MacLachlan",
		"MacLachlane", "MacLachlin", "MacLackie", "MacLae", "MacLaerigh",
		"MacLaerike", "MacLaertigh", "MacLaffertie", "MacLafferty", "MacLagain",
		"MacLagan", "MacLagane", "MacLagen", "MacLaggan", "MacLaggen", "MacLaghlan",
		"MacLagine", "MacLaglan", "MacLaglen", "MacLagone", "MacLaiman", "MacLain",
		"MacLaine", "MacLairen", "MacLairish", "MacLairtie", "MacLalan",
		"MacLalland", "MacLallen", "MacLammie", "MacLamon", "MacLamond",
		"MacLamont", "MacLamroch", "MacLanachan", "MacLanaghan", "MacLanaghen",
		"MacLandsborough", "MacLane", "MacLannachen", "MacLanochen", "MacLanoquhen",
		"MacLaomuinm", "MacLaran", "MacLardie", "MacLardy", "MacLaren", "MacLarin",
		"MacLaring", "MacLartie", "MacLarty", "MacLartych", "MacLatchie",
		"MacLatchy", "MacLauchan", "MacLauchlan", "MacLauchlane", "MacLauchleine",
		"MacLauchlen", "MacLauchlin", "MacLauchrie", "MacLaugas", "MacLaughan",
		"MacLaughlan", "MacLaughland", "MacLaughlane", "MacLaughlin", "MacLauren",
		"MacLaurent", "MacLaurin", "MacLaurine", "MacLaverty", "MacLavor",
		"MacLawchtlane", "MacLawhorn", "MacLawmane", "MacLawran", "MacLawrin",
		"MacLawrine", "MacLaws", "MacLay", "MacLayne", "MacLea", "MacLean",
		"MacLeand", "MacLeane", "MacLeannaghain", "MacLear", "MacLeary", "MacLeash",
		"MacLeaver", "MacLeay", "MacLeerie", "MacLees", "MacLeesh", "MacLeever",
		"MacLefrish", "MacLehoan", "MacLehose", "MacLeich", "MacLein", "MacLeish",
		"MacLeister", "MacLelan", "MacLeland", "MacLelane", "MacLelann", "MacLelen",
		"MacLellan", "MacLelland", "MacLellane", "MacLeman", "MacLemme", "MacLemon",
		"MacLemond", "MacLen", "MacLenaghan", "MacLenane", "MacLenden", "MacLendon",
		"MacLene", "MacLenechen", "MacLennan", "MacLenochan", "MacLentick",
		"MacLeoad", "MacLeod", "MacLeoid", "MacLeot", "MacLeougas", "MacLeran",
		"MacLergain", "MacLergan", "MacLerich", "MacLerie", "MacLern", "MacLeron",
		"MacLeroy", "MacLese", "MacLess", "MacLetchie", "MacLeud", "MacLeur",
		"MacLeverty", "MacLewain", "MacLewd", "MacLewis", "MacLey", "MacLglesson",
		"MacLimont", "MacLin", "MacLinden", "MacLinein", "MacLinnen", "MacLintoch",
		"MacLintock", "MacLise", "MacLish", "MacLiss", "MacLiver", "MacLlauchland",
		"MacLochlainn", "MacLochlin", "MacLockie", "MacLode", "MacLoed",
		"MacLoghlin", "MacLoid", "MacLoir", "MacLokie", "MacLolan", "MacLolane",
		"MacLonachin", "MacLonvie", "MacLoon", "MacLoor", "MacLorn", "MacLouchlan",
		"MacLoud", "MacLougas", "MacLoughlin", "MacLouis", "MacLouvie", "MacLow",
		"MacLowe", "MacLowkas", "MacLoy", "MacLoyde", "MacLroy", "MacLucais",
		"MacLucas", "MacLucase", "MacLuckie", "MacLucky", "MacLude", "MacLugaish",
		"MacLugane", "MacLugas", "MacLugash", "MacLugeis", "MacLugers", "MacLuggan",
		"MacLugish", "MacLuguis", "MacLuir", "MacLuke", "MacLulaghe", "MacLulaich",
		"MacLulich", "MacLulli", "MacLullich", "MacLullick", "MacLumfa",
		"MacLumpha", "MacLung", "MacLur", "MacLure", "MacLurg", "MacLuskey",
		"MacLuskie", "MacLusky", "MacLwannell", "MacLwhannel", "MacLymont",
		"MacLyn", "MacLyndon", "MacMaghnuis", "MacMagister", "MacMagnus",
		"MacMahon", "MacMain", "MacMaines", "MacMainess", "MacMains", "MacMalduff",
		"MacMan", "MacManamy", "MacManaway", "MacManes", "MacManis", "MacMann",
		"MacMannas", "MacMannes", "MacMannus", "MacManus", "MacMark", "MacMarquis",
		"MacMarten", "MacMartin", "MacMartun", "MacMartyne", "MacMaster", "MacMath",
		"MacMathon", "MacMaurice", "MacMayne", "MacMeachie", "MacMean", "MacMeans",
		"MacMeechan", "MacMeekan", "MacMeeken", "MacMeekin", "MacMeeking",
		"MacMeikan", "MacMein", "MacMeinn", "MacMen", "MacMenamie", "MacMenamin",
		"MacMenemie", "MacMenemy", "MacMenigall", "MacMenzies", "MacMertein",
		"MacMertene", "MacMertin", "MacMhannis", "MacMhaolain", "MacMhathain",
		"MacMhourich", "MacMhuireadhaigh", "MacMhuirich", "MacMhuirrich",
		"MacMhurchaidh", "MacMichael", "MacMichan", "MacMicheil", "MacMichell",
		"MacMichie", "MacMickan", "MacMicken", "MacMickin", "MacMicking",
		"MacMigatour", "MacMikan", "MacMiken", "MacMilane", "MacMillan",
		"MacMilland", "MacMillen", "MacMillin", "MacMillon", "MacMin", "MacMina",
		"MacMine", "MacMinn", "MacMinne", "MacMinnies", "MacMinnis", "MacMitchel",
		"MacMitchell", "MacMoil", "MacMolan", "MacMolane", "MacMolland",
		"MacMonagle", "MacMonies", "MacMonnies", "MacMoran", "MacMorane",
		"MacMordoch", "MacMoreland", "MacMoren", "MacMorice", "MacMories",
		"MacMorin", "MacMorine", "MacMoris", "MacMorland", "MacMoroquhy",
		"MacMorran", "MacMorrane", "MacMorrin", "MacMoryn", "MacMoryne",
		"MacMowtrie", "MacMuckater", "MacMuiredhaigh", "MacMuiredhuigh",
		"MacMuirigh", "MacMukrich", "MacMulan", "MacMulane", "MacMullan",
		"MacMullen", "MacMullin", "MacMullon", "MacMulron", "MacMunagle",
		"MacMuncater", "MacMuncatter", "MacMune", "MacMungatour", "MacMunn",
		"MacMurachy", "MacMurchaidh", "MacMurchie", "MacMurchou", "MacMurchy",
		"MacMurd", "MacMurdo", "MacMurdoch", "MacMurdon", "MacMurdy", "MacMuredig",
		"MacMurich", "MacMurphy", "MacMurquhe", "MacMurquhie", "MacMurray",
		"MacMurre", "MacMurree", "MacMurrich", "MacMurriche", "MacMurrie",
		"MacMurrin", "MacMurry", "MacMurrycht", "MacMurrye", "MacMurtchie",
		"MacMurtery", "MacMurtie", "MacMurtrie", "MacMury", "MacMutrie",
		"MacMychel", "MacMychele", "MacMylan", "MacMyllan", "MacMyllane", "MacMyn",
		"MacMyne", "MacMynneis", "MacNab", "MacNabb", "MacNachdan", "MacNacht",
		"MacNachtan", "MacNachtane", "MacNachtin", "MacNachton", "MacNae",
		"MacNaght", "MacNaghtane", "MacNaghten", "MacNaicht", "MacNaichtane",
		"MacNaight", "MacNail", "MacNaill", "MacNair", "MacNairn", "MacNait",
		"MacNakaird", "MacNale", "MacNally", "MacNamaoile", "MacNamell", "MacNamil",
		"MacNamill", "MacNaoimhin", "MacNaois", "MacNaoise", "MacNap", "MacNar",
		"MacNare", "MacNarin", "MacNatt", "MacNaucater", "MacNauch", "MacNauche",
		"MacNauchtan", "MacNauchtane", "MacNauchton", "MacNaught", "MacNaughtan",
		"MacNaughten", "MacNaughton", "MacNauth", "MacNauton", "MacNay",
		"MacNayair", "MacNayer", "MacNayr", "MacNayre", "MacNea", "MacNeacail",
		"MacNeacain", "MacNeacden", "MacNeachdainn", "MacNeachden", "MacNeadair",
		"MacNeal", "MacNeale", "MacNeall", "MacNear", "MacNecaird", "MacNedair",
		"MacNedar", "MacNedyr", "MacNee", "MacNeel", "MacNeelie", "MacNeer",
		"MacNees", "MacNeice", "MacNeid", "MacNeigh", "MacNeight", "MacNeil",
		"MacNeill", "MacNeille", "MacNeillie", "MacNeilly", "MacNeir", "MacNeis",
		"MacNeische", "MacNeish", "MacNeiss", "MacNeit", "MacNeiving", "MacNekard",
		"MacNele", "MacNelly", "MacNely", "MacNesche", "MacNeskar", "MacNesker",
		"MacNess", "MacNett", "MacNettar", "MacNeur", "MacNevin", "MacNewer",
		"MacNey", "MacNeyll", "MacNial", "MacNicail", "MacNiccoll", "MacNichol",
		"MacNichole", "MacNicholl", "MacNicht", "MacNickle", "MacNicol",
		"MacNicoll", "MacNidder", "MacNider", "MacNie", "MacNiel", "MacNielie",
		"MacNiff", "MacNight", "MacNikord", "MacNillie", "MacNily", "MacNische",
		"MacNish", "MacNiter", "MacNitt", "MacNivaine", "MacNiven", "MacNoah",
		"MacNoaise", "MacNoble", "MacNocaird", "MacNoder", "MacNokaird",
		"MacNokard", "MacNokerd", "MacNokord", "MacNomiolle", "MacNomoille",
		"MacNorcard", "MacNorton", "MacNougard", "MacNowcater", "MacNowcatter",
		"MacNoyar", "MacNoyare", "MacNoyiar", "MacNucadair", "MacNucater",
		"MacNucator", "MacNucatter", "MacNuctar", "MacNuer", "MacNuicator",
		"MacNuir", "MacNuire", "MacNure", "MacNutt", "MacNuyer", "MacNvyr",
		"MacNychol", "MacNychole", "MacNycholl", "MacNysche", "MacO'Shenag",
		"MacO'Shennaig", "MacObyn", "MacOchtery", "MacOchtrie", "MacOchtry",
		"MacOdrum", "MacOisein", "MacOlaine", "MacOldonich", "MacOleane",
		"MacOlmichaell", "MacOloghe", "MacOlonie", "MacOlony", "MacOlphatrick",
		"MacOlrig", "MacOmelyne", "MacOmie", "MacOmish", "MacOnachie", "MacOnachy",
		"MacOnchie", "MacOndochie", "MacOndoquhy", "MacOnechy", "MacOnee",
		"MacOneill", "MacOnele", "MacOnhale", "MacOnie", "MacOnill", "MacOnlay",
		"MacOnochie", "MacOnohie", "MacOrkill", "MacOrmack", "MacOrquidill",
		"MacOrquodale", "MacOseanag", "MacOsenage", "MacOsennag", "MacOsham",
		"MacOshennag", "MacOshenog", "MacOstrich", "MacOstrick", "MacOual",
		"MacOuat", "MacOuhir", "MacOul", "MacOulie", "MacOull", "MacOulric",
		"MacOulroy", "MacOurich", "MacOurlic", "MacOwan", "MacOwat", "MacOwen",
		"MacOwis", "MacOwl", "MacOwlache", "MacPadane", "MacPaden", "MacPaid",
		"MacPaill", "MacParlan", "MacParland", "MacParlane", "MacParlin",
		"MacPartick", "MacPatre", "MacPatrick", "MacPaul", "MacPaule", "MacPawle",
		"MacPearson", "MacPeeters", "MacPerson", "MacPersone", "MacPersonn",
		"MacPeter", "MacPetir", "MacPetre", "MacPetri", "MacPetrie", "MacPhadan",
		"MacPhadden", "MacPhaddion", "MacPhade", "MacPhadein", "MacPhaden",
		"MacPhadraig", "MacPhadrick", "MacPhadrig", "MacPhadrik", "MacPhadruck",
		"MacPhadruig", "MacPhadryk", "MacPhadzen", "MacPhael", "MacPhaell",
		"MacPhaid", "MacPhaide", "MacPhaidein", "MacPhaiden", "MacPhaidin",
		"MacPhail", "MacPhaile", "MacPhaill", "MacPhait", "MacPhale",
		"MacPharheline", "MacPharick", "MacPharlain", "MacPharlane", "MacPharson",
		"MacPhate", "MacPhater", "MacPhatrick", "MacPhatricke", "MacPhatryk",
		"MacPhaul", "MacPhaull", "MacPhayll", "MacPheadair", "MacPheadarain",
		"MacPhearson", "MacPheat", "MacPhedar", "MacPheddair", "MacPheddrin",
		"MacPhedearain", "MacPhederan", "MacPhedran", "MacPhedrein", "MacPhedron",
		"MacPhee", "MacPheidearain", "MacPheidiran", "MacPheidran", "MacPheidron",
		"MacPhell", "MacPhersen", "MacPherson", "MacPhersone", "MacPhete",
		"MacPhial", "MacPhie", "MacPhiel", "MacPhilib", "MacPhilip", "MacPhilipps",
		"MacPhingone", "MacPhoid", "MacPhorich", "MacPhun", "MacPhune", "MacPhuney",
		"MacPhunie", "MacPhunn", "MacPhuny", "MacPhyden", "MacPilips", "MacQha",
		"MacQhardies", "MacQharter", "MacQherter", "MacQua", "MacQuaben",
		"MacQuade", "MacQuaid", "MacQuain", "MacQuaire", "MacQuaker", "MacQualter",
		"MacQuan", "MacQuarie", "MacQuarrane", "MacQuarrey", "MacQuarrie",
		"MacQuarter", "MacQuartie", "MacQuat", "MacQuater", "MacQuatter",
		"MacQuattie", "MacQuatty", "MacQuay", "MacQuaynes", "MacQuckian", "MacQue",
		"MacQuean", "MacQueane", "MacQuee", "MacQueeban", "MacQueen", "MacQueeney",
		"MacQueenie", "MacQuein", "MacQueine", "MacQueir", "MacQueiston", "MacQuen",
		"MacQuene", "MacQuesten", "MacQueston", "MacQuey", "MacQueyn", "MacQueyne",
		"MacQuhae", "MacQuhalter", "MacQuhan", "MacQuhannil", "MacQuharrane",
		"MacQuharrie", "MacQuharry", "MacQuhartoune", "MacQuhat", "MacQuhatti",
		"MacQuhattie", "MacQuheen", "MacQuhen", "MacQuhenn", "MacQuhenne",
		"MacQuhenzie", "MacQuheritie", "MacQuheyne", "MacQuhine", "MacQuhinny",
		"MacQuhinze", "MacQuhir", "MacQuhirertie", "MacQuhirirtie", "MacQuhirr",
		"MacQuhirrie", "MacQuhirtir", "MacQuhirtour", "MacQuhirtoure", "MacQuhoire",
		"MacQuhollastar", "MacQuhonale", "MacQuhonyle", "MacQuhore", "MacQuhorie",
		"MacQuhorre", "MacQuhorter", "MacQuhoull", "MacQuhriter", "MacQuhyn",
		"MacQuhyne", "MacQuhynze", "MacQuibben", "MacQuibbon", "MacQuiben",
		"MacQuid", "MacQuie", "MacQuien", "MacQuikan", "MacQuilkan", "MacQuilliam",
		"MacQuiltroch", "MacQuin", "MacQuine", "MacQuinne", "MacQuinnes",
		"MacQuiod", "MacQuire", "MacQuirter", "MacQuistan", "MacQuisten",
		"MacQuistin", "MacQuiston", "MacQuithean", "MacQuitheane", "MacQuithen",
		"MacQuorcadaill", "MacQuore", "MacQuorie", "MacQuorn", "MacQuorne",
		"MacQuorquhordell", "MacQuorquodale", "MacQuorquordill", "MacQuorrie",
		"MacQurrie", "MacQuyre", "MacQwaker", "MacRa", "MacRach", "MacRad",
		"MacRae", "MacRah", "MacRaht", "MacRaild", "MacRaill", "MacRailt",
		"MacRain", "MacRaine", "MacRaing", "MacRaith", "MacRalte", "MacRanal",
		"MacRanald", "MacRandal", "MacRandall", "MacRandell", "MacRanich",
		"MacRanie", "MacRankein", "MacRankin", "MacRankine", "MacRanking",
		"MacRankyne", "MacRannal", "MacRannald", "MacRath", "MacRau", "MacRaurie",
		"MacRavey", "MacRaw", "MacRay", "MacRayne", "MacRe", "MacRea", "MacReadie",
		"MacReady", "MacRearie", "MacReary", "MacReath", "MacReay", "MacRedie",
		"MacRee", "MacReekie", "MacReiche", "MacReil", "MacReill", "MacReirie",
		"MacReith", "MacRenald", "MacRenold", "MacRerie", "MacReth", "MacReull",
		"MacRevey", "MacRevie", "MacRey", "MacReynald", "MacReynold", "MacReynolds",
		"MacRiche", "MacRichie", "MacRie", "MacRikie", "MacRimmon", "MacRindle",
		"MacRinnell", "MacRinnyl", "MacRirick", "MacRiridh", "MacRirie",
		"MacRitchey", "MacRitchie", "MacRitchy", "MacRither", "MacRob", "MacRobb",
		"MacRobbie", "MacRobe", "MacRobert", "MacRoberts", "MacRobi", "MacRobie",
		"MacRobin", "MacRoderick", "MacRoe", "MacRoithrich", "MacRonald",
		"MacRonall", "MacRone", "MacRorie", "MacRory", "MacRotherick", "MacRourie",
		"MacRow", "MacRowat", "MacRowatt", "MacRoy", "MacRoyre", "MacRoyree",
		"MacRoyri", "MacRuairidh", "MacRuar", "MacRuaraidh", "MacRuary",
		"MacRudder", "MacRudrie", "MacRuer", "MacRuidhri", "MacRurie", "MacRurry",
		"MacRury", "MacRuter", "MacRyche", "MacRynald", "MacRynall", "MacRyndill",
		"MacRynell", "MacRynild", "MacRypert", "MacRyrie", "MacSagart", "MacSata",
		"MacSayde", "MacScamble", "MacScilling", "MacSetree", "MacSeveney",
		"MacShannachan", "MacSherry", "MacShille", "MacShimes", "MacShimidh",
		"MacShimie", "MacShimmie", "MacShirie", "MacShirrie", "MacShuibhne",
		"MacSimon", "MacSkellie", "MacSkelly", "MacSkimming", "MacSloy",
		"MacSoirle", "MacSorle", "MacSorlet", "MacSorley", "MacSorlie", "MacSorll",
		"MacSorlle", "MacSorrill", "MacSorrle", "MacSouarl", "MacSporran",
		"MacStaker", "MacStalker", "MacSteven", "MacStokker", "MacSuain", "MacSuin",
		"MacSwain", "MacSwaine", "MacSwan", "MacSwane", "MacSwanney", "MacSween",
		"MacSwen", "MacSweyne", "MacSwigan", "MacSwiggan", "MacSwyde", "MacSwyne",
		"MacSymon", "MacTaevis", "MacTagart", "MacTaggard", "MacTaggart",
		"MacTaggate", "MacTaggert", "MacTaggit", "MacTaldrach", "MacTaldridge",
		"MacTaldroch", "MacTalzyr", "MacTamhais", "MacTarlach", "MacTarlich",
		"MacTarmayt", "MacTary", "MacTause", "MacTaveis", "MacTavish", "MacTawisch",
		"MacTawys", "MacTear", "MacTeer", "MacTeir", "MacTer", "MacTere",
		"MacTerlach", "MacTeyr", "MacThamais", "MacThamhais", "MacThavish",
		"MacThearlaich", "MacThom", "MacThomaidh", "MacThomais", "MacThomas",
		"MacThome", "MacThomie", "MacThorcadail", "MacThorcuill", "MacThurkill",
		"MacTier", "MacTire", "MacToiche", "MacTomais", "MacTorquedil",
		"MacTorquil", "MacToschy", "MacToshy", "MacTurk", "MacTyr", "MacTyre",
		"MacUalraig", "MacUaltair", "MacUaraig", "MacUbein", "MacUbin", "MacUbine",
		"MacUidhir", "MacUilam", "MacUilleim", "MacUir", "MacUirigh", "MacUish",
		"MacUiston", "MacUlagh", "MacUlaghe", "MacUllie", "MacUlloch", "MacUlric",
		"MacUlrich", "MacUlrick", "MacUlrig", "MacUne", "MacUrchie", "MacUrchy",
		"MacUre", "MacUrich", "MacVail", "MacVain", "MacVaine", "MacVale",
		"MacVane", "MacVanish", "MacVannan", "MacVannel", "MacVararthy",
		"MacVararty", "MacVarish", "MacVarraich", "MacVarrais", "MacVarrich",
		"MacVarrish", "MacVarrist", "MacVarthie", "MacVat", "MacVater", "MacVaxter",
		"MacVay", "MacVeagh", "MacVean", "MacVeane", "MacVeay", "MacVee",
		"MacVeigh", "MacVeirrich", "MacVenish", "MacVennie", "MacVerrathie",
		"MacVey", "MacVicar", "MacVicker", "MacVie", "MacVillie", "MacVinie",
		"MacVinish", "MacVinnie", "MacVirrich", "MacVirriche", "MacVirrist",
		"MacVitie", "MacVittae", "MacVittie", "MacVoerich", "MacVorchie",
		"MacVoreis", "MacVoreiss", "MacVoreist", "MacVorich", "MacVoriche",
		"MacVoris", "MacVorish", "MacVorist", "MacVorrich", "MacVourich",
		"MacVretny", "MacVrettny", "MacVurarthie", "MacVurarthy", "MacVurchie",
		"MacVurich", "MacVurie", "MacVurirch", "MacVuririch", "MacVurist",
		"MacVurrich", "MacVurriche", "MacVurrish", "MacWade", "MacWalrick",
		"MacWalter", "MacWaltir", "MacWarie", "MacWarish", "MacWat", "MacWater",
		"MacWatt", "MacWatte", "MacWatter", "MacWattie", "MacWattir", "MacWatty",
		"MacWean", "MacWeane", "MacWeeny", "MacWerarthe", "MacWerarthie", "MacWete",
		"MacWha", "MacWhae", "MacWhan", "MacWhaneall", "MacWhanell", "MacWhanle",
		"MacWhanlie", "MacWhannall", "MacWhanne", "MacWhannel", "MacWhannell",
		"MacWhannil", "MacWhanrall", "MacWharrie", "MacWhaugh", "MacWhaw",
		"MacWheir", "MacWhey", "MacWhin", "MacWhinn", "MacWhinney", "MacWhinnie",
		"MacWhir", "MacWhire", "MacWhirr", "MacWhirrie", "MacWhirter",
		"MacWhirtour", "MacWhiston", "MacWhonnell", "MacWhorter", "MacWhrurter",
		"MacWhunye", "MacWhy", "MacWhynie", "MacWhyrter", "MacWiccar", "MacWiggan",
		"MacWilliam", "MacWilliame", "MacWilliams", "MacWillie", "MacWinney",
		"MacWirrich", "MacWirriche", "MacWirter", "MacWithean", "MacWithy",
		"MacWorthie", "MacWrarthie", "MacWray", "MacWrerdie", "MacWurchie",
		"MacWurie", "MacWyllie", "MacYe", "MacYewin", "MacYllecrist", "MacYlory",
		"MacYlroy", "MacYlroye", "MacYlveine", "MacYnniel", "MacYnstalker",
		"MacYnthosche", "MacYnthose", "MacYntoch", "MacYntoisch", "MacYntyre",
		"MacYnwiss", "MacYowin", "MacYsaac", "MacYsac", "MacYuir", "MacYwene",
		"Macleod",
		"ApShaw", "d'Albini", "d'Aubigney", "d'Aubigné", "d'Autry", "d'Entremont",
		"d'Hurst", "D'ovidio", "da Graça", "DaSilva", "DeAnda", "deAnnethe", "deAubigne",
		"deAubigny", "DeBardelaben", "DeBardeleben", "DeBaugh", "deBeauford", "DeBerry",
		"deBethune", "DeBetuile", "DeBoard", "DeBoer", "DeBohun", "DeBord", "DeBose",
		"DeBrouwer", "DeBroux", "DeBruhl", "deBruijn", "deBrus", "deBruse", "deBrusse",
		"DeBruyne", "DeBusk", "DeCamp", "deCastilla", "DeCello", "deClare", "DeClark", "DeClerck",
		"DeCoste", "deCote", "DeCoudres", "DeCoursey", "DeCredico", "deCuire", "DeCuyre",
		"DeDominicios", "DeDuyster", "DeDuytscher", "DeDuytser", "deFiennes", "DeFord", "DeForest",
		"DeFrance", "DeFriece", "DeGarmo", "deGraaff", "DeGraff", "DeGraffenreid", "DeGraw",
		"DeGrenier", "DeGroats", "DeGroft", "DeGrote", "DeHaan", "DeHaas", "DeHaddeclive",
		"deHannethe", "DeHatclyf", "DeHaven", "DeHeer", "DeJager", "DeJarnette", "DeJean",
		"DeJong", "deJonge", "deKemmeter", "deKirketon", "DeKroon", "deKype", "del-Rosario",
		"dela Chamotte", "DeLa Cuadra", "DeLa Force", "dela Fountaine", "dela Greña",
		"dela Place", "DeLa Ward", "DeLaci", "DeLacy", "DeLaet", "DeLalonde", "DelAmarre", "DeLancey",
		"DeLascy", "DelAshmutt", "DeLassy", "DeLattre", "DeLaughter", "DeLay", "deLessine", "DelGado",
		"DelGaudio", "DeLiberti", "DeLoache", "DeLoatch", "DeLoch", "DeLockwood",
		"DeLong", "DeLozier", "DeLuca", "DeLucenay", "deLucy", "DeMars", "DeMartino",
		"deMaule", "DeMello", "DeMinck", "DeMink", "DeMoree", "DeMoss", "DeMott", "DeMuynck",
		"deNiet", "DeNise", "DeNure", "DePalma", "DePasquale", "dePender", "dePercy",
		"DePoe", "DePriest", "DePu", "DePui", "DePuis", "DeReeper", "deRochette", "deRose",
		"DeRossett", "DeRover", "deRuggele", "deRuggle", "DeRuyter", "deSaint-Sauveur",
		"DeSantis", "desCuirs", "DeSentis", "DeShane", "DeSilva", "DesJardins", "DesMarest",
		"deSoleure", "DeSoto", "DeSpain", "DeStefano", "deSwaert", "deSwart", "DeVall",
		"DeVane", "DeVasher", "DeVasier", "DeVaughan", "DeVaughn", "DeVault", "DeVeau", "DeVeault",
		"deVilleneuve", "DeVilliers", "DeVinney", "DeVito", "deVogel", "DeVolder", "DeVolld",
		"DeVore", "deVos", "DeVries", "deVries", "DeWall", "DeWaller", "DeWalt",
		"deWashington", "deWerly", "deWessyngton", "DeWet", "deWinter", "DeWitt", "DeWolf",
		"DeWolfe", "DeWolff", "DeWoody", "DeYager", "DeYarmett", "DeYoung", "DiCicco",
		"DiCredico", "DiFillippi", "DiGiacomo", "DiMarco", "DiMeo", "DiMonte", "DiNonno",
		"DiPietro", "diPilato", "DiPrima", "DiSalvo", "du Bosc", "du Hurst", "DuFort", "DuMars",
		"DuPre", "DuPue", "DuPuy", "FitzUryan", "kummel", "LaBarge", "LaBarr", "LaBauve",
		"LaBean", "LaBelle", "LaBerteaux", "LaBine", "LaBonte", "LaBorde", "LaBounty",
		"LaBranche", "LaBrash", "LaCaille", "LaCasse", "LaChapelle", "LaClair", "LaComb",
		"LaCoste", "LaCount", "LaCour", "LaCroix", "LaFarlett", "LaFarlette", "LaFerry",
		"LaFlamme", "LaFollette", "LaForge", "LaFortune", "LaFoy", "LaFramboise", "LaFrance",
		"LaFuze", "LaGioia", "LaGrone", "LaLiberte", "LaLonde", "LaLone", "LaMaster",
		"LaMay", "LaMere", "LaMont", "LaMotte", "LaPeer", "LaPierre", "LaPlante", "LaPoint",
		"LaPointe", "LaPorte", "LaPrade", "LaRocca", "LaRochelle", "LaRose", "LaRue", "LaVallee",
		"LaVaque", "LaVeau", "LeBleu", "LeBoeuf", "LeBoiteaux", "LeBoyteulx", "LeCheminant",
		"LeClair", "LeClerc", "LeCompte", "LeCroy", "LeDuc", "LeFevbre", "LeFever", "LeFevre",
		"LeFlore", "LeGette", "LeGrand", "LeGrave", "LeGro", "LeGros", "LeJeune", "LeMaistre",
		"LeMaitre", "LeMaster", "LeMesurier", "LeMieux", "LeMoe", "LeMoigne", "LeMoine",
		"LeNeve", "LePage", "LeQuire", "LeQuyer", "LeRou", "LeRoy", "LeSuer", "LeSueur", "LeTardif",
		"LeVally", "LeVert", "LoMonaco", "Macabe", "Macaluso", "MacaTasney", "Macaulay",
		"Macchitelli", "Maccoone", "Maccurry", "Macdermattroe", "Macdiarmada", "Macelvaine", "Macey",
		"Macgraugh", "Machan", "Machann", "Machum", "Maciejewski", "Maciel", "Mackaben",
		"Mackall", "Mackartee", "Mackay", "Macken", "Mackert", "Mackey", "Mackie", "Mackin", "Mackins",
		"Macklin", "Macko", "Macksey", "Mackwilliams", "Maclean", "Maclinden", "Macomb",
		"Macomber", "Macon", "Macoombs", "Macraw", "Macumber", "Macurdy", "Macwilliams", "MaGuinness",
		"MakCubyn", "MakCumby", "Mcelvany", "Mcsherry",
		"Op den Dyck", "Op den Graeff",
		"regory", "Schweißguth", "StElmo", "StGelais", "StJacques", "te Boveldt", "VanAernam",
		"VanAken", "VanAlstine", "VanAmersfoort", "VanAntwerp", "VanArlem", "VanArnam",
		"VanArnem", "VanArnhem", "VanArnon", "VanArsdale", "VanArsdalen", "VanArsdol", "vanAssema",
		"vanAsten", "VanAuken", "VanAwman", "VanBaucom", "VanBebber", "VanBeber",
		"VanBenschoten", "VanBibber", "VanBilliard", "vanBlare", "vanBlaricom", "VanBuren",
		"VanBuskirk", "VanCamp", "VanCampen", "VanCleave", "VanCleef", "VanCleve",
		"VanCouwenhoven", "VanCovenhoven", "VanCowenhoven", "VanCuren", "VanDalsem", "VanDam",
		"VanDe Poel", "vanden Dijkgraaf", "vanden Kommer", "VanDer Aar", "vander Gouwe",
		"VanDer Honing", "VanDer Hooning", "vander Horst", "vander Kroft", "vander Krogt",
		"VanDer Meer", "vander Meulen", "vander Putte", "vander Schooren", "VanDer Veen",
		"VanDer Ven", "VanDer Wal", "VanDer Weide", "VanDer Willigen", "vander Wulp", "vander Zanden",
		"vander Zwan", "VanDer Zweep", "VanDeren", "VanDerlaan", "VanDerveer",
		"VanderWoude", "VanDeursen", "VanDeusen", "vanDijk", "VanDoren", "VanDorn", "VanDort",
		"VanDruff", "VanDryer", "VanDusen", "VanDuzee", "VanDuzen", "VanDuzer", "VanDyck",
		"VanDyke", "VanEman", "VanEmmen", "vanEmmerik", "VanEngen", "vanErp", "vanEssen",
		"VanFleet", "VanGalder", "VanGelder", "vanGerrevink", "VanGog", "vanGogh", "VanGorder",
		"VanGordon", "VanGroningen", "VanGuilder", "VanGundy", "VanHaaften", "VanHaute", "VanHees",
		"vanHeugten", "VanHise", "VanHoeck", "VanHoek", "VanHook", "vanHoorn",
		"VanHoornbeeck", "VanHoose", "VanHooser", "VanHorn", "VanHorne", "VanHouten", "VanHoye",
		"VanHuijstee", "VanHuss", "VanImmon", "VanKersschaever", "VanKeuren",
		"VanKleeck", "VanKoughnet", "VanKouwenhoven", "VanKuykendaal", "vanLeeuwen", "vanLent",
		"vanLet", "VanLeuven", "vanLingen", "VanLoozen", "VanLopik", "VanLuven",
		"vanMaasdijk", "VanMele", "VanMeter", "vanMoorsel", "VanMoorst", "VanMossevelde", "VanNaarden",
		"VanNamen", "VanNemon", "VanNess", "VanNest", "VanNimmen", "vanNobelen",
		"VanNorman", "VanNormon", "VanNostrunt", "VanNote", "VanOker", "vanOosten", "VanOrden", "VanOrder",
		"VanOrma", "VanOrman", "VanOrnum", "VanOstrander", "VanOvermeire",
		"VanPelt", "VanPool", "VanPoole", "VanPoorvliet", "VanPutten", "vanRee", "VanRhijn", "vanRijswijk",
		"VanRotmer", "VanSchaick", "vanSchelt", "VanSchoik", "VanSchoonhoven",
		"VanSciver", "VanScoy", "VanScoyoc", "vanSeters", "VanSickle", "VanSky", "VanSnellenberg",
		"vanStaveren", "VanStraten", "VanSuijdam", "VanTassel", "VanTassell",
		"VanTessel", "VanTexel", "VanTuyl", "VanValckenburgh", "vanValen", "VanValkenburg", "VanVelsor",
		"VanVelzor", "VanVlack", "VanVleck", "VanVleckeren", "VanWaard",
		"VanWart", "VanWassenhove", "VanWinkle", "VanWoggelum", "vanWordragen", "VanWormer", "VanZuidam",
		"VanZuijdam", "VonAdenbach", "vonAllmen", "vonBardeleben", "vonBerckefeldt",
		"VonBergen", "vonBreyman", "VonCannon", "vonFreymann", "vonHeimburg", "VonHuben", "vonKramer",
		"vonKruchenburg", "vonPostel", "VonRohr", "VonRohrbach", "VonSass", "VonSasse",
		"vonSchlotte", "VonSchneider", "VonSeldern", "VonSpringer", "VonVeyelmann", "VonZweidorff",
	}
	# Note. We do the oppsoite with "Mac*" names so will need to add them as needed, e.g.,
	# MacDonald


	foreach s [split $S ","] {
		set s [string trim $s]
		regsub -all {"} $s {} s
		set SPECIAL([string tolower $s]) $s
	}


	# Try to pick out a few common formats with regexps first.
	proc common_formats {raw} {
		array set x [_common_formats $raw]


		# Post-process results of RE, unless verbatim flag is set

		if {![info exists x(verbatim)]} {

			if {[info exists x(initials)]} {
				set x(initials) [string toupper [string map {"." "" "-" "" " " ""} $x(initials)]]
			}

			if {[info exists x(first_name)]} {
				set x(first_name) [capitalize_name $x(first_name)]
			}

			if {[info exists x(last_name)]} {
				set x(last_name) [capitalize_name $x(last_name)]
			}

			if {[info exists x(first_name)]} {
				if {[info exists x(initials_first)]} {
					set initials [string range $x(first_name) 0 0]
					if {[info exists x(initials)]} {
						set initials "$x(initials)${initials}"
					}
					set x(initials) $initials
				} else {
					set initials [string range $x(first_name) 0 0]
					if {[info exists x(initials)]} {
						append initials $x(initials)
					}
					set x(initials) $initials
				}
			}
		}

		set non_empty 0
		foreach k {last_name first_name initials} {
			if {[info exists x($k)]} {
				lappend ret [string trim $x($k)]
				set non_empty 1
			} else {
				lappend ret ""
			}
		}

		return $ret

	}

	proc _common_formats {raw} {
		variable TITLE_JUNK
		variable TRAILING_JUNK
		variable TRAILING_JUNK_2
		variable NAME_2
		variable INITIALS_4
		variable PREFIX
		variable SURNAME
		variable SURNAMES

		set debug 0

		# "verbatim name"
		if {[regexp {^\s*"([^"]+)"\s*$} $raw -> ret(last_name)]} {
			if {$debug} { puts "Match Rule 0" }
			set ret(verbatim) 1
			return [array get ret]
		}

		# Manually specified
		if {[regexp {^\s*=/([^/]*)/([^/]*)/([^/]*)/=\s*$} $raw -> ret(first_name) ret(initials) ret(last_name)]} {
			if {$debug} { puts "Match Rule 1" }
			set ret(verbatim) 1
			return [array get ret]
		}

		# "on (3+ words)" -> verbatim
		if {[regexp -nocase {^\s*(on(\s+\w+){3,})} $raw -> ret(last_name) ]} {
			if {$debug} { puts "Match Rule 2" }
			set ret(verbatim) 1
			return [array get ret]
		}

		# "the (2+ words)" -> verbatim
		if {[regexp -nocase {^\s*(the(\s+\w+){2,})} $raw -> ret(last_name) ]} {
			if {$debug} { puts "Match Rule 3" }
			set ret(verbatim) 1
			return [array get ret]
		}

		# anything ending in "group" (or similar)
		if {[regexp -nocase {\s+(group|consortium|project|alliance|team)$} $raw -> ret(last_name) ]} {
			if {$debug} { puts "Match Rule 4" }
			set ret(verbatim) 1
			return [array get ret]
		}


		# First, all the "surname, firstname options"

		# Cameron(,?) R.D.
		if {[regexp\
				 [subst {^($SURNAMES),? ?($INITIALS_4)$}]\
				 $raw -> ret(last_name) ret(initials)]} {
 			if {$debug} { puts "Match Rule 5" }
			return [array get ret] }

		# Gladstein Ancona, Deborah A.
		# redundant - caught by #6
		if {[regexp\
				 [subst {^($SURNAMES), ?($NAME_2)(?: ($INITIALS_4))?$}]\
				 $raw -> ret(last_name) ret(first_name) ret(initials)]} {
			if {$debug} { puts "Match Rule 15" }
			return [array get ret]
		}

		# Cameron, Richard D
		if {[regexp\
				 [subst {^($SURNAMES), ?($NAME_2)( \[A-Z\]+)?}]\
				 $raw -> ret(last_name) ret(first_name) ret(initials)]} {
			if {$debug} { puts "Match Rule 6 $ret(last_name) $ret(first_name) $ret(initials)" }
			return [array get ret]
		}


		# Gladstein Ancona, D. A.
		# redundant - caught by #5
		if {0 && [regexp\
				 [subst {^($SURNAMES), ?($INITIALS_4)$}]\
				 $raw -> ret(last_name) ret(initials)]} {
			if {$debug} { puts "Match Rule 16" }
			return [array get ret]
		}


		# Smithers, D Waylon
		if {[regexp\
				 [subst {^($SURNAMES), ?($INITIALS_4)($NAME_2) $}]\
				 $raw -> ret(last_name) ret(initials) ret(first_name)]} {
			if {$debug} { puts "Match Rule 17" }
			set ret(initials_first) 1
			return [array get ret]
		}

		# R.D. Cameron
		if {[regexp\
				 [subst {^($INITIALS_4)($SURNAME) $}]\
				 $raw -> ret(initials) ret(last_name)]} {
			if {$debug} { puts "Match Rule 7" }
			return [array get ret]
		}

		# Richard D. Cameron
		# Richard Cameron
		if {[regexp\
				 [subst {^($NAME_2) ($INITIALS_4)?($SURNAME) $}]\
				 $raw -> ret(first_name) ret(initials) ret(last_name)]} {
			if {$debug} { puts "Match Rule 9" }
			return [array get ret]
		}

		# R.D.Cameron
		if {[regexp\
				 [subst -nocommands {^((?:[A-Z]\\\.){1,3})($SURNAME) $}]\
				 $raw -> ret(initials) ret(last_name)]} {
			if {$debug} { puts "Match Rule 10" }
			return [array get ret]
		}


		# Cameron
#		if {[regexp\
#				 [subst {^($SURNAME) $}]\
#				 $raw -> ret(last_name) ret(initials)]} {
#			if {$debug} { puts "Match Rule 11" }
#			return [array get ret]
#		}

		# D Waylon Smithers
		if {[regexp\
				 [subst {^($INITIALS_4)($NAME_2) ($SURNAME) $}]\
				 $raw -> ret(initials) ret(first_name) ret(last_name)]} {
			if {$debug} { puts "Match Rule 12" }
			set ret(initials_first) 1
			return [array get ret]
		}


		# It's impossible to distinguish between "NAME SURNAME SURNAME" and
		# "NAME NAME SURNAME" - the latter is more likely so assume that
		# Deborah Gladstein Ancona
		if {[regexp\
				 [subst {^($NAME_2) ($NAME_2) ($SURNAME) $}]\
				 $raw -> ret(first_name) middle_name ret(last_name)]} {
			if {$debug} { puts "Match Rule 13" }
			set ret(initials) [string range $middle_name 0 0]
			return [array get ret]
		}

		# Deborah A. Gladstein Ancona
		if {[regexp\
				 [subst {^($NAME_2) ($INITIALS_4)(${SURNAME}(?: $SURNAME)*) $}]\
				 $raw -> ret(first_name) ret(initials) ret(last_name)]} {
			if {$debug} { puts "Match Rule 14" }
			return [array get ret]
		}



		# Now we'll give up. This should always be the last case.
		# See if we can extract anything that looks even vaguely like a surname
		# and be happy with that.
		if {[regexp [subst {($SURNAMES)}]\
				 $raw -> ret(last_name)]} {
			if {$debug} { puts "Match Rule 18" }
			return [array get ret]
		}

		if {[regexp [subst {($SURNAME)}]\
				 $raw -> ret(last_name)]} {
			if {$debug} { puts "Match Rule 19" }
			return [array get ret]
		}

	}


	proc c2html {c} {
		return [format "&#x%4.4x;" [scan $c %c]]
	}

	proc html2u {s} {
		while {[regexp {&#[xX]([0-9A-Fa-f]+);} $s match digits]} {
			regsub -all $match $s [format %c 0x$digits] s
		}
		return $s
	}

	proc parse_author {raw} {
		variable TITLE_JUNK
		variable TRAILING_JUNK
		variable TRAILING_JUNK_2
		variable EMAIL

		# trim whitespace
		set raw [string trim $raw]

		# unicode extra spaces:
		set raw [string map {"\u00A0" " "} $raw]

		set raw [string trim $raw]
		set raw [html2u $raw]
		# this function only defined in main server
		catch {
			set raw [unicode_bibtex_unmap $raw]
		}

		# If we have a braced string, turn it into a quoted string
		if {([string index $raw 0] eq "\{") && ([string index $raw end] eq "\}")} {
			set raw \"[string range $raw 1 end-1]\"
		}

		# Remove leading, trailing, double spacing,
		# and other unwanted bits and pieces.
		set work $raw
		set work [regsub -all {\s{2,}} $work " "]
		set work [regsub -all {,+} $work ","]
		set work [regsub -all {\s+\.+$} $work ""]
		set work [regsub -all {,+$} $work ""]
		set work [regsub -all {&nbsp;} $work " "]
		set work [regsub -all {\s+,} $work ","]
		set work [regsub -all {\s+\.+\s+} $work " "]
		set work [regsub -all {\s+\.+} $work "."]
		set work [regsub -all {\s+;+} $work ";"]
		set work [regsub -all {\\} $work ""]

		# using raw/work is from legacy code.
		# Previously "raw" was sacrosanct and tweaking done using "work",
		# but now all the obvious stuff is done on the raw.  This might
		# be wrong in some circumstances but seems best overall.
		set raw $work

		set work [regsub -all {[()]} $work ""]
		set work [regsub -all "$EMAIL" $work ""]

		# puts "$work"

		# Honorific and strange conventions just need to get binned immediately
		# (I don't support this for now, but because I keep the raw names
		#  this stuff can be added in retrospectively if required)
		set work [regsub "^$TITLE_JUNK" $work ""]
		set work [regsub "${TRAILING_JUNK}\$" $work ""]
		set work [regsub "${TRAILING_JUNK_2}\$" $work ""]

		# The way we've phrased the REs, we need a trailing space
		append work " "

		set common [common_formats $work]

		if {[llength $common]>0} {
			lappend common $raw
			return $common
		}

		return {}
	}

	proc capitalize_name_part {sub} {
		variable PREFIX
		variable SPECIAL
		if {[regexp [subst {($PREFIX)(.*)$}] $sub -> prefix rest]} {
			#D'Angelo, and not D'angelo
			set this $prefix
			append this [totitle $rest]
		} else {
			set this [totitle $sub]
		}
		if {[info exists SPECIAL([string tolower $this])]} {
			set this $SPECIAL([string tolower $this])
		}
		return $this
	}

	# Sometime get BibTeX {} so strip off any non letters
	# Q: should we be throwing away {} - probably yes
	# as they get thrown away on editing anyway.
	proc totitle {name} {
		regexp {^([^[:alnum:]]*)(.*?)$} $name -> pre post
		return "$pre[string totitle $post]"
	}


	# TODO? should we skip this is the name is
	# already mixed-case?
	proc capitalize_name {name} {
		variable PREFIX2
		variable SPECIAL
		if {[regexp {[a-z]} $name] && [regexp {[A-Z]} $name]} {
			return $name
		}
		# We do this test for each name part, but some special cases
		# have hyphens, etc so try at the "global" level first
		if {[info exists SPECIAL([string tolower $name])]} {
			return $SPECIAL([string tolower $name])
		}

		foreach sub [split $name "-"] {
			lappend ret [capitalize_name_part $sub]
		}
		set ret [join $ret "-"]

		# Yuck, this is horrible
		foreach sub [split $ret " "] {
			if {[regexp $PREFIX2 $sub]} {
				#puts "xxx1: $sub -> $sub"
				lappend ret2 $sub
			} elseif {[regexp {\-} $sub]} {
				#puts "xxx2: $sub -> $sub"
				lappend ret2 $sub
			} else {
				#puts "xxx3: $sub -> [capitalize_name_part $sub]"
				lappend ret2 [capitalize_name_part $sub]
			}
		}


		return [join $ret2 " "]
	}

	proc test_author {} {
		test_parse_author
	}

 	proc parse_test_cases {} {
		# last_name first_name initials raw
 		return [list \
 				{"Edozien" "Leroy" "LC" "Edozien, Leroy C"}\
 				{"Chaitin" "" "GJ" "G. J. Chaitin"} \
 				{"Chaitin" "" "GJ" "G. J. Chaitin	 "}\
 				{"Chaitin" "" "GJ" "    G. J. Chaitin"}\
 				{"Chaitin" "" "GJ" "    G. J. Chaitin    "}\
				{"Chaitin" "" "GJ" "Prof. G. J. Chaitin"}\
 				{"Chaitin" "" "GJ" "Sir G. J. Chaitin"}\
 				{"Chaitin" "" "GJ" "Mister Prof. Dr. G. J. Chaitin"}\
 				{"Chaitin" "" "GJ" "Mister Prof. Dr. G. J. CHAITIN"}\
 				{"Chaitin" "" "GJ" "G. J. Chaitin Jnr."}\
 				{"Chaitin" "" "GJ" "G. J. Chaitin Sr"}\
 				{"Chaitin" "" "GJ" "G. J. Chaitin Sr."}\
 				{"Chaitin" "" "GJ" "G. J. Chaitin et al."}\
 				{"Ferreira" "Fernando" "F" "Fernando Ferreira"}\
 				{"Botz" "" "GW" "G.W.Botz"}\
 				{"D'Angelo" "Barbara" "BJ" "D'Angelo, Barbara J."}\
 				{"Moyo" "" "LM" "Moyo L.M."}\
 				{"Peyton-Jones" "Simon" "S" "Simon Peyton-Jones"}\
 				{"O'Donnell" "Jill" "J" "Jill O'Donnell"}\
 				{"Vonesch" "Jean-Luc" "J" "Jean-Luc Vonesch"}\
 				{"von Herrath" "Matthias" "M" "Matthias von Herrath"}\
 				{"O'Donnell-Tormey" "Jill" "J" "Jill O'Donnell-Tormey"}\
 				{"Smithers" "Waylon" "DW" "D Waylon Smithers"}\
 				{"Smithers" "Waylon" "DW" "D. Waylon Smithers"}\
 				{"Smithers" "Waylon" "DW" "Smithers, D Waylon"}\
 				{"von Herrath" "Matthias" "M" "Matthias von Herrath"}\
 				{"von Hoyningen-Huene" "Wolfgang" "W" "von Hoyningen-Huene, Wolfgang"}\
 				{"de Boer" "" "J" "de Boer, J."}\
 				{"van den Berg" "Debbie" "DLC" "Debbie L.C. van den Berg"}\
 				{"Botz" "" "GW" "Botz G. W.,"}\
 				{"" "" "" ""}\
 				{"Cameron" "" "" "Cameron"}\
				{"Chaitin" "Gregory" "GJ" "GREGORY J CHAITIN"}\
				{"A Company Name" "" "" "\"A Company Name\""}\
				{"A Company Name" "" "" "{A Company Name}"}\
 				{"Cameron" "" "" "rcameron@citeulike.org (Cameron et al)"}\
 				{"Cameron" "Richard" "RD" "Richard D Cameron"}\
 				{"Cameron" "Richard" "RD" "Richard  D  Cameron"}\
 				{"Florek" "" "HJ" "Florek, H.-J."}\
 				{"Steves" "" "ABC" "Steves, A.B.C"}\
				{"Cho-Vega" "Jeong" "JH" "Jeong Hee Cho-Vega"}\
				{"Yeung" "Henry" "HW" "Henry Wai-chung Yeung"}\
				{"Gladstein Ancona" "Deborah" "DA" "Deborah A. Gladstein Ancona"}\
				{"Gladstein Ancona" "Deborah" "DA" "Gladstein Ancona, Deborah A."}\
				{"Gladstein Ancona Bancona Anaconda" "Deborah" "DA" "Gladstein Ancona Bancona Anaconda, Deborah A."}\
				{"Gladstein Ancona Bancona Anaconda" "" "DA" "Gladstein Ancona Bancona Anaconda, D. A."}\
				{"The Science Project" "" "" "The Science Project"}\
				{"On the Science Project" "" "" "On the Science Project"}\
 				{"Florek" "" "HJ" "Florek , H.-J."}\
				{"De La Paz" "Susan" "S" "De La Paz, Susan"}\
				{"Ager" "" "JW" "J. W. Ager III"}\
				{"Buchwald" "Stephen" "SL" "Stephen L. Buchwald"}\
				{"Person" "" "I" "Person I"}\
				{"Person" "" "I" "Person I."}\
 				{"Steves" "" "BA" "Steves B.A."}\
				{"Rumbaut" "" "RG" "Rumbaut,R. G."}\
				{"Rumbaut" "" "RG" "Rumbaut, R. G."}\
				{"Rumbaut" "" "RG" "Rumbaut,R. G"}\
				{"Lino Cardenas" "Christian" "CL" "Lino Cardenas, Christian L."}\
				{"Forster" "Malcolm" "MR" "Forster, Malcolm R."}\
				{"DeKay" "Michael" "ML" "Michael L DeKay"}\
				{"O'Connell" "Gary" "GIM" "Gary I M O'Connell"}\
				{"O'Connell" "Gary" "GIM" "O'Connell, Gary I M"}\
				{"McDonald" "Gary" "GIM" "MCDONALD, GARY I M"}\
				{"MacDonald" "Gary" "GIM" "MACDONALD, GARY I M"}\
				{"d'Hurst" "Gary" "GIM" "d'Hurst, GARY I M"}\
				{"VanDer Zweep" "Gary" "GIM" "VanDer Zweep, GARY I M"}\
				{"vander Wulp" "Gary" "GIM" "vander Wulp, GARY I M"}\
				{"de la Vallee Poussin" "Charles" "CL" "de la Vallee Poussin, Charles Louis"}\
			]
	#			{"de la Vallee Poussin" "Charles" "CLXJ" "de la Vallee Poussin, Charles Louis Xavier Joseph"}\
	#			{"de la Vallee Poussin" "Charles" "CLXJ" "de la Vallee Poussin, Charles Louis Xavier Joseph"}\
	#			{"de la Vallee Poussin" "Charles" "CLXJ" "Charles Louis de la Vallee Poussin"}\
	#			{"de la Vallee Poussin" "Charles" "CLXJ" "Charles Louis Xavier Joseph de la Vallee Poussin"}\


 	}

	proc test_parse_author {} {
		foreach case [parse_test_cases] {
			foreach {last_name first_name initials raw_name} $case {}

			# Raw name is element 3
			set result [parse_author [lindex $case 3]]

			if {[llength $result]!=[llength $case]} {
				error "Failed to parse $case"
			}

			foreach expected [lrange $case 0 2] actual [lrange $result 0 2] {
				if {$expected != $actual} {
					puts stderr "Failed parse: Expected $case but got $result"
				}
			}

		}
	}

	test_author

}
