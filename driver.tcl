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

proc driver_from_command_line {} {
	if {[info exists ::argv0] && [file tail $::argv0]=="driver.tcl"} {
		# We've been started up from the command line (by a plugin developer)
		# rather than from inside the application.
		return 1
	}
	return 0
}

if {[driver_from_command_line]} {
	source author.tcl
	source bibtex.tcl
	source ris.tcl
}

# First thing to do is load the plugin description files and get some idea of what we're dealing with.
# They're all defined in a tcl-like syntax, so we need to define two trivial commands to parse them

# The base filenames of all the extensions we know about
namespace eval driver {
	
	variable PLUGINS

	proc plugin {raw_kvpairs} {
		variable PLUGIN
		variable DETAIL_${PLUGIN}
		
		# Bodge the contents of this string to remove
		# pseudo "comments".
		set kvpairs ""
		foreach line [split $raw_kvpairs "\n"] {
			if {![regexp {^\s*#} $line]} {
				append kvpairs "$line\n"
			}
		}
		
		array set DETAIL_${PLUGIN} $kvpairs
		
		# Check for required fields
		foreach f {author email language regexp version} {
			if {![info exists DETAIL_${PLUGIN}($f)] || [set DETAIL_${PLUGIN}($f)]==""} {
				error "Plugin definition file for $PLUGIN does not define a value for: $f"
			}
		}
	}

	# This command is executed with the config file is sourced.
	
	proc format_linkout {type body} {
		# Slight Tcl tricker here. Define a procedure, but with
		# a slightly different signature to what might be obvious
		proc format_linkout_${type} {type ikey_1 ckey_1 ikey_2 ckey_2} $body
	}


	proc test {url kvpairs} {
		variable PLUGIN
		variable TESTS_${PLUGIN}
		lappend TESTS_${PLUGIN} [list $url $kvpairs]
	}

	proc descr_dir {} {
		# Possibly assuming UNIX style paths here
		return "$::env(PWD)/descr"
	}

	proc read_descr {} {
		variable PLUGINS
		variable PLUGIN
		foreach file [glob -directory [descr_dir] "*.cul"] {
			set name [file rootname [file tail $file]]
			
			lappend PLUGINS $name
			set PLUGIN $name
			
			# The description file is actually a valid TCL file, which we can source
			source $file
			
			# Confirm it actually defined what it had to
			variable DETAIL_$PLUGIN
			if {![info exists DETAIL_${PLUGIN}]} {
				error "Plugin description file for $PLUGIN does not have a valid plugin directive"
			}
			
			set language [set DETAIL_${PLUGIN}(language)]

			variable TESTS_$PLUGIN
			if {$language!="none"} {
				if {![info exists TESTS_${PLUGIN}] || [llength [set TESTS_${PLUGIN}]]==0} {
					error "Plugin $PLUGIN does not define any tests"
				}
			}
			
			# And it had better actually have an executable
			set exe [executable_for_name $language $PLUGIN]
			if {![file exists $exe] && $language!="none"} {
				error "No executable exists for plugin ${PLUGIN}. I was expecting $exe"
			}
			if {![file executable $exe] && $language!="none"} {
				error "File should be executable: $exe"
			}
		}
		
		set PLUGINS [lsort $PLUGINS]
	}


	# The list of plugins which pass the initial
	# regexp test for the url
	proc interested_plugins {url} {
		variable PLUGINS
		
		set ret {}
		
		foreach p $PLUGINS {
			variable DETAIL_${p}
			if {[regexp [set DETAIL_${p}(regexp)] $url]} {
				lappend ret $p
			}
		}
		
		return $ret
	}

	# Some fields are special in that the support multiple
	# values. Linkouts and authors are two examples of this
	proc is_multiple_field {field} {
		if {[lsearch {author editor linkout formatted_url} $field]>-1} {
			return 1
		}
		return 0
	}


	# Actually do the work. Given a URL, we'll actually
	# run the appropriate plugins and then we'll have a result.
	proc parse_url {url {rec_level 0}} {
		
		# Plugins are permitted to "redirect" to other URLs
		# but we really don't want to end up in an inifite loop
		# with each iteration doing a DOS attack on our hosts.
		# Limit the recursion to much lower than the default tcl
		# recursion limit.
		if {$rec_level > 5} {
			error "Too much recursion. Last url was $url"
		}
		
		set candidates [interested_plugins $url]
		
		foreach plugin $candidates {
			# For now, we'll just exec() a process. This is
			# not terribly efficient, and we ultimately want to
			# have the plugins run in a persistent executable which
			# we can talk to over a little socket server.
			#
			# It's fine for now though. One or two exec()s per post
			# isn't the limiting factor for performance at the moment.

			variable DETAIL_${plugin}
			set language [set DETAIL_${plugin}(language)]

			# Blocking IO. In production the server will abort the request
			# after a timeout and free the filedescriptor if it hangs.
			set exe [executable_for_name $language $plugin]
			cd [file dirname $exe]
			set fd [open "|$exe" "r+"]
			puts $fd $url
			flush $fd
			set result [read $fd]
			close $fd

			set lines [split $result "\n"]

			# Tcl enforces the old unix convention that files end with a blank line
			set last_line [lindex $lines end]
			if {$last_line==""} {
				set lines [lrange $lines 0 end-1]
				set result [join $lines "\n"]
				set last_line [lindex $lines end]
			}
			
			# The last line of the file should contain some status information.
			if {![regexp {status\t([^\t]+)(\t(.*)+)?$} $last_line -> status extra]} {
				error "$plugin: Expected plugin to return status in last line. Got:\n---\n$result\n---"
			}

			if {$status!="ok" && $status!="err" && $status!="redirect" && $status!="not_interested"} {
				error "Invalid status code from plugin. Expected ok, err, or redirect. Got: $last_line"
			}

			if {$status=="err"} {
				return [list status err msg [string trim $extra]]
			}

			# If this plugin is not interested, then we'll see if the next guy in the queue
			# can do any better
			if {$status=="not_interested"} {
				continue
			}

			# If another plugin can handle it, we'll do that
			if {$status=="redirect"} {
				incr rec_level
				return [parse_url $url $rec_level]
			}

			# Otherwise we'll just have to sort out the data.
			set ret(status) $status

			set state ""
			set lineno 1
			foreach line [lrange $lines 0 end-1] {

				# Toy state machine to keep track of which block we should be parsing
				if {[regexp {^begin_(tsv|ris|bibtex)$} $line -> new_state]} {
					if {$state!=""} {
						error "$lineno: Nested begin blocks in output from $parser $url"
					}
					set state $new_state
					
					continue
				} elseif {[regexp {^end_(tsv|ris|bibtex)$} $line -> old_state]} {
					if {$state!=$old_state} {
						error "$lineno: Found end_$old_state block, but was in $state block"
					}
					
					# Flush the remaining buffer into the array
					if {$state=="tsv" && [info exists tsv_state]} {
						if {[is_multiple_field $tsv_state]} {
							lappend ret($tsv_state) $tsv_buffer
						} else {
							set ret($tsv_state) $tsv_buffer
						}
						set tsv_buffer ""
					}

					set state ""
					continue
				}

				if {$state=="tsv"} {
					if {[regexp {^([^\t]+)\t(.*)$} $line -> key value]} {
						if {[info exists tsv_state]} {
							if {[is_multiple_field $tsv_state]} {
								lappend ret($tsv_state) $tsv_buffer
							} else {
								set ret($tsv_state) $tsv_buffer
							}
						}
						set tsv_buffer $value
						set tsv_state $key
					} else {
						# It's a continuation of the previous key
						if {![info exists tsv_state]} {
							error "$lineno: Found data in output without knowing which key it belongs to: $line"
						}
						append tsv_buffer "\n$line"
					}
				} elseif {$state=="ris"} {
					lappend ris_lines $line
				} elseif {$state=="bibtex"} {
					lappend bibtex_lines $line
				}
			}
			if {$state!=""} {
				error "Saw begin $state block, but no end $state block"
			}
			
			if {[info exists ris_lines]} {
				set ris [join $ris_lines "\n"]

				# Merge in. TSV data takes priority.
				foreach {k v} [parse_ris $ris] {
					if {![info exists ret($k)]} {
						set ret($k) $v
					}
				}
			}
			
			if {[info exists bibtex_lines]} {
				set bibtex [join $bibtex_lines "\n"]

				# Merge in. TSV data takes priority.
				foreach {k v} [parse_bibtex $bibtex] {
					if {![info exists ret($k)]} {
						set ret($k) $v
					}
				}
			}
			

			# Post-process what we've got from the plugin.
			if {[info exists ret(author)]} {
				foreach author $ret(author) {
					lappend ret(authors) [::author::parse_author $author]
				}
				unset ret(author)
			}


			if {[info exists ret(editor)]} {
				foreach editor $ret(editors) {
					lappend ret(editors) [::author::parse_author $editor]
				}
				unset ret(editor)
			}

			if {[info exists ret(linkout)]} {
				foreach lo $ret(linkout) {
					lappend ret(linkouts) [split $lo "\t"]
				}
				unset ret(linkout)
			}

			foreach {k v} [array get ret] {
				if {$v==""} {
					# If it's an empty string, we may as well not have it
					unset ret($k)
				}
			}

			# This is a particular BibTeX oddity
			if {[info exists ret(end_page)] && $ret(end_page)=="+"} {
				unset ret(end_page)
			}

			set ret(plugin) $plugin
			set ret(plugin_version) [set DETAIL_${plugin}(version)]
			
			
			# TODO - make sure the kv pairs takes priority over bibtex/ris
			# Return the first plugin which gets a result.

			return [array get ret]
		}
		
		return {}
	}

	proc executable_base_dir {} {
		return "$::env(PWD)"
	}

	proc executable_for_name {language plugin} {
		
		switch -- [string tolower $language] {
			tcl {set ext "tcl"}
			perl {set ext "pl"}
			python {set ext "py"}
			none {set ext ""}
			default {error "Unsupported language: $language"}
		}

		# Check we're not going to be executing anything
		# surprising
		if {![regexp {[A-Za-z0-9_-]} $plugin]} {
			error "Illegal plugin name: $plugin"
		}
		return "[executable_base_dir]/$language/${plugin}.${ext}"
	}


	proc test_error {level plugin url field error} {
		set field_part ""
		if {$field!=""} {
			set field_part "(Field = $field): "
		}
		puts stderr "$level: (Plugin = $plugin): (URL = $url): $field_part $error"
	}

	proc test_plugins {} {
		# Test 'em all.
		variable PLUGINS

		puts "Testing all plugins"
		puts ""
		puts "Please note that some tests may fail if you are running them from a"
		puts "machine which does not have access rights to the content, or if the"
		puts "scraper is written in an obscure language which you don't have installed"
		puts "on your machine."
		puts ""
		
		foreach p $PLUGINS {
			variable TESTS_$p
			if {[info exists TESTS_$p]} {
				test_plugin $p
			}
		}
	}

	proc test_plugin {plugin} {
		variable TESTS_${plugin}

		set count 1
		foreach test [set TESTS_$plugin] {
			set url [lindex $test 0]
			puts "Testing $plugin $count/[llength [set TESTS_$plugin]]"
			incr count

			set expected [lindex $test 1]
			set actual [parse_url $url]

			if {[llength $actual]==0} {
				test_error Error $plugin $url "" "Failed to parse $url"
				# No point checking anything else here
				continue
			}


			catch {unset x_expected}
			catch {unset x_actual}
			
			array set x_actual $actual

			# Can't do an array set as this contains multiple values
			foreach {k v} $expected {
				if {[is_multiple_field $k]} {
					lappend x_expected($k) $v
				} else {
					set x_expected($k) $v
				}
			}
									
			# The test case needs a bit of post-processing to put it into 
			# canonical form
			if {[info exists x_expected(linkout)]} {
				set x_expected(linkouts) $x_expected(linkout)
				unset x_expected(linkout)
			}

			if {[info exists x_expected(author)]} {
				set x_expected(authors) $x_expected(author)
				unset x_expected(author)
			}

			if {[info exists x_expected(editor)]} {
				set x_expected(editors) $x_expected(editor)
				unset x_expected(editor)
			}

			
			# We'll also run the linkout formatter as we'll want to test that too.
			if {[info exists x_actual(linkouts)]} {
				foreach l $x_actual(linkouts) {
					foreach {type ikey_1 ckey_1 ikey_2 ckey_2} $l {}
					foreach {descr link} [format_linkout_$type $type $ikey_1 $ckey_1 $ikey_2 $ckey_2] {
						lappend x_actual(formatted_url) [list $descr $link]
					}
				}
			}

			if {![info exists x_expected(status)]} {
				test_error Error $plugin $url status "Test case does not specify a value for the status field"
				continue
			}

			if {![info exists x_actual(status)]} {
				test_error Error $plugin $url status "Plugin did not return a value in the status field"
				continue
			}

			if {$x_actual(status) != $x_expected(status)} {
				if {[info exists x_actual(msg)]} {
					set msg " : $x_actual(msg)"
				} else {
					set msg ""
				}
				test_error Error $plugin $url status "Expected status $x_expected(status), but got $x_actual(status) $msg"
				continue
			}

			set expected [array get x_expected]
			set actual   [array get x_actual]

			
			# Check we get what we wanted
			foreach {k v} $expected {
				if {[info exists x_actual($k)]} {
					set actual_v $x_actual($k)
				} else {
					set actual_v ""
				}
				
				if {![string equal $actual_v $v]} {
					test_error Error $plugin $url $k "Expected:\n'$v'\nbut actually got:\n'$actual_v'\n\n\n"
				}
			}

			# And warn about any extra information
			foreach {k v} $actual {
				
				if {[lsearch {plugin plugin_version cite} $k]>-1} {
					# These aren't required to be in the test case
					continue
				}

				if {![info exists x_expected($k)]} {
					test_error Warning $plugin $url $k "Plugin returned data unexpected by test case: $v"
				}
			}
		}
	}



	if {[driver_from_command_line]} {

		# On startup from command line do stuff. Otherwise leave
		# the decision to the main application.
		read_descr

		
		set ok 0
		if {[llength $::argv]==2 && ([lindex $argv 0]=="test" || [lindex $argv 0]=="parse")} {
			set ok 1
		}
		
		if {!$ok} {
			puts {Usage:
  driver.tcl test all
  driver.tcl test -plugin-
  driver.tcl parse -url-
  
  test all: runs all tests. Note that some may fail
            unless you have access rights to everything
            the plugins require
  
  test -plugin-: will test just your plugin, where
                 the plugin is the base name of the .cul file
  
  parse -url-: will show the results of parsing an arbitrary url
			}
			exit
		}

		switch -- [lindex $::argv 0] {
			test {
				set plugin [lindex $::argv 1]
				if {$plugin=="all"} {
					test_plugins
				} else {
					test_plugin $plugin
				}
			}
			parse {
				set url [lindex $::argv 1]
				set parsed [parse_url $url]

				puts "parsing $url"
				puts ""
				if {[llength $parsed]==0} {
					puts "No plugin was interested in this url."
				} else {
					foreach {k v} $parsed {
						puts "$k -> $v"
					}
				}
			}
			
		}
	}
}