#!/usr/bin/env tclsh

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

source util.tcl

set url [gets stdin]
set page [url_get $url]

# Pick up the odds and ends we don't get in the BibTeX record

puts "begin_tsv"

# Bonanza of possible linkouts
if {[regexp {<input type=\"hidden\" name=\"bibcode\" value=\"([^\"]+)\">} $page -> bibcode]} {
	puts [join [list linkout NASA {} $bibcode {} {}] "\t"]
} else {
	puts "status\terr\tWas expecting to find a NASA ADS 'bibcode' value on the page. I can't find one. Are you sure this is an abstract from the NASA ADS service?"
	exit
}

if {[regexp {\(arXiv:([^\(]+)\)} $page -> arxiv]} {
	puts [join [list linkout ARXIV {} $arxiv {} {}] "\t"]
}

if {[regexp {href=\"http://dx.doi.org/([^\"]+)\">} $page -> doi]} {
	puts [join [list linkout DOI {} $doi {} {}] "\t"]
}

if {[regexp {Abstract</h3>(.*?)<hr} $page -> abstract]} {
	puts "abstract\t[string trim $abstract]"
}

puts "end_tsv"

# All the rest should just come out of the BibTeX record

puts "begin_bibtex"

# They use an incredible number of journal abbreviations
# I believe this is the current list

puts {
@String{aa = {Astron. Astrophys.}}
@String{aaa = {Acta Acustica united with Acustica}}
@String{aap = {Ann. Appl. Probab.}}
@String{linceirsfmn = {Atti Accad. Naz. Lincei: Rend. Sc. fis. mat. nat.}}
@String{acp = {Adv. Chem. Phys.}}
@String{adp = {Ann. d. Phys.}}
@String{ahp = {Ann. Henri Poincar\'e}}
@String{ai = {Artif. Intell.}}
@String{aihp = {Ann. Inst. Henri Poincar\'e}}
@String{aipcp = {Am. Inst. Phys. Conf. Proc.}}
@String{ajm = {Am. J. Math.}}
@String{ajp = {Am. J. Phys.}}
@String{am = {Ann. Math.}}
@String{aml = {Ann. Math. Lett.}}
@String{amm = {Am. Math. Monthly}}
@String{amr = {Appl. Mech. Rev.}}
@String{ams = {Ann. Math. Stat.}}
@String{amsci = {Am. Sci.}}
@String{amst = {American Statistician}}
@String{aop = {Ann. of Phys.}}
@String{apa = {Appl. Phys. A}}
@String{apj = {Astrophys. J.}}
@String{appb = {Acta Phys. Polonica B}}
@String{ap = {Ann. Prob.}}
@String{arma = {Arch. Rational Mech. Anal.}}
@String{arpc = {Annu. Rev. Phys. Chem.}}
@String{as = {Ann. Stat.}}
@String{bams = {Bull. Am. Math. Soc.}}
@String{bern = {Bernoulli}}
@String{bjp = {Braz. J. Phys.}}
@String{bjps = {Brit. J. Phil. Sci.}}
@String{bm = {Biometrika}}
@String{bs = {Behav. Sci.}}
@String{bstj = {Bell Syst. Tech. J.}}
@String{camp = {Comments At. Mol. Phys.}}
@String{cdiasa = {Commun. Dublin Inst. Adv. Studies series A}}
@String{cejp = {Central Eur. J. Phys.}}
@String{ces = {Chem. Eng. Sci.}}
@String{chaos = {Chaos}}
@String{cmp = {Commun. Math. Phys.}}
@String{cmt = {Continuum Mech. Therm.}}
@String{complex = {Complexity}}
@String{cp = {Contemp. Phys.}}
@String{cpam = {Comm. Pure Appl. Math.}}
@String{cpc = {Comput. Phys. Comm.}}
@String{cqg = {Classical Quant. Grav.}}
@String{cras = {C. R. Acad. Sci. Paris}}
@String{crasi = {C. R. Acad. Sci. Paris S\'erie I}}
@String{csf = {Chaos, Solitons \& Fractals}}
@String{efm = {Eng. Fract. Mech.}}
@String{ejp = {Eur. J. Phys.}}
@String{em = {Econometrica}}
@String{epist = {Epistemologia}}
@String{epjb = {Eur. Phys. J. B: Condens. Matter}}
@String{epl = {Europhys. Lett.}}
@String{fortp = {Fortschr. Phys.}}
@String{fp = {Found. Phys.}}
@String{fpl = {Found. Phys. Lett.}}
@String{gn = {G\"ott. Nach.}}
@String{grr = {Gen. Relat. Gravit.}}
@String{hpa = {Helv. Phys. Acta}}
@String{ibmjrd = {IBM J. Res. Develop.}}
@String{ic = {Info. Comp.}}
@String{ieeejqe = {IEEE J. Quant. Electronics}}
@String{ieeetim = {IEEE Trans. Instr. Meas.}}
@String{ieeetit = {IEEE Trans. Inform. Theor.}}
@String{ieeetpami = {IEEE Trans. Pattern Anal. Mach. Intell.}}
@String{ieeetsp = {IEEE Trans. Signal Process.}}
@String{ieeetssc = {IEEE Trans. on Systems Science and Cybernetics}}
@String{ijar = {Int. J. Approximate Reasoning}}
@String{ijes = {Int. J. Engng. Sci.}}
@String{ijmpa = {Int. J. Mod. Phys. A}}
@String{ijmpc = {Int. J. Mod. Phys. C}}
@String{ijnlm = {Int. J. Non-Lin. Mech.}}
@String{ijtp = {Int. J. Theor. Phys.}}
@String{ijqc = {Int. J. Quant. Chem.}}
@String{ijqi = {Int. J. Quant. Inform.}}
@String{imajam = {IMA J. Appl. Math.}}
@String{ip = {Inverse Probl.}}
@String{ipm = {Inform. Process. Manag.}}
@String{is = {Inf. Sci.}}
@String{isrjm = {Israel J. Math.}}
@String{jacs = {J. Am. Chem. Soc.}}
@String{jair = {J. Artif. Intell. Res.}}
@String{jam = {J. Appl. Mech.}}
@String{jamm = {J. Appl. Math. Mech.}}
@String{jap = {J. Appl. Phys.}}
@String{jacousa = {J. Acoust. Soc. Am.}}
@String{jasa = {J. Am. Stat. Assoc.}}
@String{jce = {J. Chem. Educ.}}
@String{jcp = {J. Chem. Phys.}}
@String{jcta = {J. Combin. Theory A}}
@String{jdp = {J. de Phys.}}
@String{je = {J. Elasticity}}
@String{jem = {J. Econometrics}}
@String{jfi = {J. Franklin Inst.}}
@String{jgp = {J. Geom. Phys.}}
@String{jima = {J. Inst. Maths. Applics}}
@String{jltp = {J. Low Temp. Phys.}}
@String{jmm = {J. Math. Mech.}}
@String{jmo = {J. Mod. Opt.}}
@String{jmp = {J. Math. Phys.}}
@String{jmap = {J. Math. and Phys.}}
@String{jnet = {J. Non-Equilib. Thermodyn.}}
@String{jnlmp = {J. Nonlin. Math. Phys.}}
@String{josa = {J. Opt. Soc. Am.}}
@String{josab = {J. Opt. Soc. Am. B}}
@String{jpa = {J. Phys. A}}
@String{jpb = {J. Phys. B}}
@String{jpc = {J. Phys. Chem.}}
@String{jpcssp = {J. Phys. C}}
@String{jpca = {J. Phys. Chem. A}}
@String{jpcm = {J. Phys.: Condens. Matter}}
@String{jphil = {J. Phil.}}
@String{jphysio = {J. Physiol.}}
@String{jpsj = {J. Phys. Soc. Japan}}
@String{jr = {J. Rheol.}}
@String{jrma = {J. Rational Mech. Anal.}}
@String{jsc = {J. Supercond.}}
@String{jsl = {J. Symbolic Logic}}
@String{jsm = {J. Stat. Mech.}}
@String{jsp = {J. Stat. Phys.}}
@String{jspi = {J. Stat. Plann. Infer.}}
@String{jsv = {J. Sound Vib.}}
@String{jtb = {J. Theor. Biol.}}
@String{jvst = {J. Vac. Sci. Technol.}}
@String{laa = {Lin. Alg. Appl.}}
@String{lnc = {Lett. Nuovo Cimento}}
@String{lrr = {Living Rev. Relativity}}
@String{ma = {Math. Ann.}}
@String{mecc = {Meccanica}}
@String{metrol = {Metrologia}}
@String{mind = {Mind}}
@String{mnras = {Mon. Not. Roy. Astron. Soc.}}
@String{mp = {Math. Program.}}
@String{mst = {Meas. Sci. Technol.}}
@String{nams = {Notices of the AMS}}
@String{nat = {Nature}}
@String{nc = {Nuovo Cimento}}
@String{ncb = {Nuovo Cimento B}}
@String{neurc = {Neural Comp.}}
@String{nous = {No\^us}}
@String{np = {Nucl. Phys.}}
@String{npb = {Nucl. Phys. B}}
@String{nl = {Nonlinearity}}
@String{nw = {Naturwissenschaften}}
@String{ns = {New Scientist}}
@String{ol = {Opt. Lett.}}
@String{os = {Opt. Spectrosc.}}
@String{osid = {Open Syst. Inform. Dynam.}}
@String{pa = {Physica A}}
@String{paaas = {Proc. Am. Acad. Arts Sci.}}
@String{pac = {Pure Appl. Chem.}}
@String{paps = {Proc. Am. Philos. Soc.}}
@String{pasa = {Proc. Acad. Sci. Amsterdam (Proc. of the Section of Sciences Koninklijke Nederlandse Akademie van Wetenschappen)}}
@String{pb = {Physica B}}
@String{pcps = {Proc. Cambridge Philos. Soc.}}
@String{pd = {Physica D}}
@String{pe = {Physica E}}
@String{ped = {Phys. Educ.}}
@String{pess = {Phys. Essays}}
@String{pfl = {Phys. Fluids}}
@String{pfla = {Phys. Fluids A}}
@String{pgzm = {Phys. Ges. Z\"urich. Mitteilungen}}
@String{phy = {Physica}}
@String{physis = {Physis (Firenze)}}
@String{pieee = {Proc. IEEE}}
@String{pla = {Phys. Lett. A}}
@String{plb = {Phys. Lett. B}}
@String{plms = {Proc. London Math. Soc.}}
@String{pnasusa = {Proc. Natl. Acad. Sci. (USA)}}
@String{pm = {Phil. Mag.}}
@String{ppr = {Philosophy and Phenomenological Research}}
@String{pps = {Proc. Phys. Soc.}}
@String{ppsa = {Proc. Phys. Soc. A}}
@String{pqe = {Prog. Quant. Electr.}}
@String{pr = {Phys. Rev.}}
@String{pra = {Phys. Rev. A}}
@String{prama = {Pramana}}
@String{prb = {Phys. Rev. B}}
@String{prd = {Phys. Rev. D}}
@String{pre = {Phys. Rev. E}}
@String{prep = {Phys. Rep.}}
@String{prl = {Phys. Rev. Lett.}}
@String{prsl = {Proc. Roy. Soc. London}}
@String{prsla = {Proc. Roy. Soc. London A}}
@String{prslb = {Proc. Roy. Soc. London B}}
@String{ps = {Phys. Scripta}}
@String{psci = {Philos. Sci.}}
@String{pssb = {phys. stat. sol. (b)}}
@String{pt = {Phys. Today}}
@String{ptpse = {Phil. Trans.: Phys. Sci. Eng.}}
@String{ptrsl = {Phil. Trans. R. Soc. Lond.}}
@String{ptrsla = {Phil. Trans. R. Soc. Lond. A}}
@String{ptp = {Progr. Theor. Phys.}}
@String{ptps = {Progr. Theor. Phys. Suppl.}}
@String{pu = {Physics-Uspekhi}}
@String{pw = {Phys. World}}
@String{pz = {Physik. Zeitschr.}}
@String{qam = {Q. Appl. Math.}}
@String{qic = {Quant. Info. Comp.}}
@String{qip = {Quant. Inform. Process.}}
@String{qso = {Quant. Semiclass. Opt.}}
@String{rl = {Rend. Lincei}}
@String{rmap = {Rep. Math. Phys.}}
@String{rmp = {Rev. Mod. Phys.}}
@String{rpp = {Rep. Prog. Phys.}}
@String{rsi = {Rev. Sci. Instrum.}}
@String{sa = {Sci. Am.}}
@String{sci = {Science}}
@String{shpmp = {Stud. Hist. Phil. Mod. Phys.}}
@String{sl = {Studia Logica}}
@String{sm = {Superlattice Microst.}}
@String{sms = {Smart Mater. Struct.}}
@String{snc = {Supp. Nuovo Cimento}}
@String{snews = {Sci. News}}
@String{spaw = {\langgerman{K\"oniglich Preu{\ss}ische
                  Akademie der Wissenschaften (Berlin).
                  Sitzungsberichte}}}
@String{ss = {Stat. Sci.}}
@String{sy = {Synthese}}
@String{tad = {Theory and Decision}}
@String{tams = {Trans. Am. Math. Soc.}}
@String{tca = {Trans. Connect. Acad.}}
@String{tcps = {Trans. Cambridge Philos. Soc.}}
@String{tm = {Technometrics}}
@String{vdpg = {Ver. Deut. Phys. Ges.}}
@String{zn = {Z. Naturforschg.}}
@String{zp = {Z. Phys.}}
}


# Then comes the actual record

set bibtex_url "http://adsabs.harvard.edu/cgi-bin/nph-bib_query?bibcode=${bibcode}&data_type=BIBTEX"
set bibtex [url_get $bibtex_url]

# Tweak it slightly so
#   journal = {\prd},
# becomes
#  journal = prd,
# and the macro expansion can work.
set bibtex [regsub {journal = \{\\([a-z0-9]+)\},} $bibtex {journal = \1,}]

puts $bibtex
puts "end_bibtex"


puts "status\tok"