# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "watir-performance"
  s.version = "0.3.1"
  s.required_ruby_version = ['>= 2.2.0', '<= 2.4.3']
  s.authors = ["Tim Koopmans", "Robert MacCracken"]
  s.date = "2016-12-27"
  s.description = "This gem collects and summarises metrics speficied in the W3C Navigation web performance specifications at http://w3c-test.org/webperf/specs/NavigationTiming/ when using watir-webdriver and a compatible browser"
  s.email = "tim.koops@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "examples/basic.rb",
    "lib/idl_extractor.rb",
    "lib/performance.rb",
    "lib/watir-performance.rb",
    "spec/spec_helper.rb",
    "spec/watir-performance-non-supported-browser_spec.rb",
    "spec/watir-performance_spec.rb",
    "watir-performance.gemspec"
  ]
  s.homepage = "http://github.com/MacCracken/watir-performance"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]

  s.summary = "A simple helper gem for watir-webdriver performance metrics"

  s.add_runtime_dependency(%q<watir>, ["~> 6.1"])
  s.add_development_dependency(%q<rspec>, ["~> 3.5"])
  s.add_development_dependency(%q<bundler>, ["~> 1.13"])
  s.add_development_dependency(%q<jeweler>, ["~> 2.1"])
  s.add_development_dependency(%q<zomg>, ["~> 1.0"])
  s.add_development_dependency(%q<rdoc>, ["~> 5.0"])
  s.add_development_dependency(%q<nokogiri>, ["~> 1.7"])
  s.add_development_dependency(%q<activesupport>, ["~> 5.0"])
   
end

