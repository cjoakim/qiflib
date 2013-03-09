=begin

Copyright (C) 2013 Chris Joakim.

=end

require 'rubygems'
require 'rake'
require 'rbconfig' 
require 'rdoc/task' 
require 'rspec/core/rake_task'
# require 'qiflib' 

$: << "."
$:.unshift File.join(File.dirname(__FILE__), "", "lib") 
Dir[File.join(File.dirname(__FILE__),'lib/tasks/*.rake')].each { | file | load file }

require 'qiflib'

desc "Default Task; rake spec"
task :default => [ 'spec'.to_sym ]  

Rake::RDocTask.new do | rd |
  rd.main  = "README.rdoc"
  rd.title = "qiflib"
  rd.rdoc_files.include("README.rdoc", "lib/**/*.rb") 
end
 
RSpec::Core::RakeTask.new('spec')
  