lib = File.expand_path "../../lib/", __FILE__
$:.unshift lib unless $:.include? lib

# FIXME: Fixes an issue where the gem would fail to load if `graphite` gem was
#        installed. This is a bug due to the gem being named `graphite-sass`,
#        yet requires being loaded as `graphite` (issue #4.)
require "graphite"
