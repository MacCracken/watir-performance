# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: watir-performance 0.9.4 ruby lib

Gem::Specification.new do |s|
  s.name = "watir-performance".freeze
  s.version = "0.9.4"

  s.required_rubygems_version = Gem::Requirement.new("~> 3.0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Robert MacCracken".freeze, "Tim Koopmans".freeze]
  s.date = "2019-10-01"
  s.description = "This gem collects and summarises metrics speficied in the W3C Navigation web performance specifications at http://w3c-test.org/webperf/specs/NavigationTiming/ when using watir and a compatible browser".freeze
  s.email = ["robert.maccracken@gmail.com".freeze, "tim.koops@gmail.com".freeze]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".gitlab-ci.yml",
    ".rspec",
    ".travis.yml",
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
  s.homepage = "http://github.com/MacCracken/watir-performance".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3.0".freeze)
  s.rubygems_version = "3.0.6".freeze
  s.summary = "A simple helper gem for watir performance metrics".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<watir>.freeze, ["~> 6.16"])
      s.add_runtime_dependency(%q<webdrivers>.freeze, ["~> 4.0"])
      s.add_development_dependency(%q<activesupport>.freeze, ["~> 6.0"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 2.0"])
      s.add_development_dependency(%q<jeweler>.freeze, ["~> 2.3"])
      s.add_development_dependency(%q<nokogiri>.freeze, ["~> 1.8"])
      s.add_development_dependency(%q<rdoc>.freeze, ["~> 6.2"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.8"])
    else
      s.add_dependency(%q<watir>.freeze, ["~> 6.16"])
      s.add_dependency(%q<webdrivers>.freeze, ["~> 4.0"])
      s.add_dependency(%q<activesupport>.freeze, ["~> 6.0"])
      s.add_dependency(%q<bundler>.freeze, ["~> 2.0"])
      s.add_dependency(%q<jeweler>.freeze, ["~> 2.3"])
      s.add_dependency(%q<nokogiri>.freeze, ["~> 1.8"])
      s.add_dependency(%q<rdoc>.freeze, ["~> 6.2"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.8"])
    end
  else
    s.add_dependency(%q<watir>.freeze, ["~> 6.16"])
    s.add_dependency(%q<webdrivers>.freeze, ["~> 4.0"])
    s.add_dependency(%q<activesupport>.freeze, ["~> 6.0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 2.0"])
    s.add_dependency(%q<jeweler>.freeze, ["~> 2.3"])
    s.add_dependency(%q<nokogiri>.freeze, ["~> 1.8"])
    s.add_dependency(%q<rdoc>.freeze, ["~> 6.2"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.8"])
  end
end

