# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "super_sti/version"

Gem::Specification.new do |s|
  s.name        = "super_sti"
  s.version     = SuperSTI::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jeremy Walker"]
  s.email       = ["jez.walker@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Ruby Rails - Add has_extra_data to SDI models with clean database tables.}
  s.description = %q{Adds an add_extra_data method to ActiveRecord that invisibly includes an extra data table. Means you can use STI but keep your database clean.}

  s.add_dependency "rails", ">= 3.1.0.rc1"
  s.add_development_dependency "rspec-rails"
  
  s.rubyforge_project = "has_extra_data"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
