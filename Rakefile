require "bundler/gem_tasks"


desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -I lib -r retentiongrid.rb"
end

task :c => :console