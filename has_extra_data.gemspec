# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "has_extra_data/version"

Gem::Specification.new do |s|
  s.name        = "has_extra_data"
  s.version     = HasExtraData::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jeremy Walker"]
  s.email       = ["jez.walker@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Ruby Rails - Add extra data to SDI models with clean database tables.}
  s.description = %q{Adds an add_extra_data method to ActiveRecord that invisibly includes an extra data table. Use with STI to keep your database clean.}

  s.add_dependency "activerecord"
  s.add_development_dependency "rspec"
  
  s.rubyforge_project = "has_extra_data"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
