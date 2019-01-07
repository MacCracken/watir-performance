require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  warn e.message
  warn 'Run `bundle install` to install missing gems'
  exit e.status_code
end

require 'rake'
require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = 'watir-performance'
  gem.homepage = 'http://github.com/MacCracken/watir-performance'
  gem.license = 'MIT'
  gem.summary = 'A simple helper gem for watir performance metrics'
  gem.description = 'This gem collects and summarises metrics speficied ' \
                    'in the W3C Navigation web performance specifications ' \
                    'at http://w3c-test.org/webperf/specs/NavigationTiming/ ' \
                    'when using watir and a compatible browser'
  gem.email = ['robert.maccracken@gmail.com', 'tim.koops@gmail.com']
  gem.authors = ['Robert MacCracken', 'Tim Koopmans']
  gem.required_rubygems_version = '~> 3.0'
  gem.required_ruby_version = '>= 2.6.0'
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task default: :spec

require 'rdoc/task'
RDoc::Task.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ''
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "watir-performance #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
