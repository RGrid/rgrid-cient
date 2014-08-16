require 'rspec/core'
require 'rspec/core/rake_task'
require 'webmock/rspec'
require 'yard'

RSpec::Core::RakeTask.new(:spec) do |spec|
 spec.pattern = FileList['spec/**/*_spec.rb']
end

YARD::Rake::YardocTask.new do |t|
  t.files   = ['lib/**/*.rb'] # optional
  # t.options = ['--any', '--extra', '--opts'] # optional
end

desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -I lib -r retentiongrid.rb"
end

task :c => :console

task :default => :spec

require "bundler/gem_tasks"
