require 'active_support/core_ext'
raise File.exists?(File.join(File.dirname(__FILE__), "has_extra_data/railtie.rb")).to_s
require File.join(File.dirname(__FILE__), "has_extra_data/railtie.rb")

#module HasExtraData
#  autoload :Hook, File.join(File.dirname(__FILE__), "has_extra_data/hook")
#end