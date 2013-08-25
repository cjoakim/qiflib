=begin

Copyright (C) 2013 Chris Joakim.

=end

require 'qiflib'

desc 'Build the gem, then unpack and validate it'
task :build do
  filename = "qiflib-#{Qiflib::VERSION}.gem"
  dirname  = "qiflib-#{Qiflib::VERSION}"

  puts "Removing #{filename} ..."
  `rm  build/#{filename}`

  puts "Building #{filename} ..."
  `gem build qiflib.gemspec`

  puts "Copying gem to build dir ..."
  `cp  #{filename} build/`

  puts "Moving the unpack directory #{dirname} ..."
  `rm -rf build/#{dirname}`

  puts "Unpacking the gem ..."
  `gem unpack build/#{filename} --target build/`
end

desc 'Push the gem to RubyGems.org'
task :push do
  filename = "qiflib-#{Qiflib::VERSION}.gem"
  `gem push #{filename}`
end

desc 'Convert qif file(s) to csv format.'
task :qif2csv do
  f = command_line_arg('f', 'data/private/ibank_20120328.qif')
  input_list = []
  input_list << {
    :owner    => 'Chris',
    :filename => f,
    :source   => Qiflib::SOURCE_IBANK }
  puts "==="
  csv_lines = Qiflib::Util.transactions_to_csv(input_list)
  csv_lines.each { | line | puts line }
  puts "==="
  csv_lines = Qiflib::Util.catetory_names_to_csv([f])
  csv_lines.each { | line | puts line.inspect }
  puts "==="
end

desc 'Convert qif file(s) to delim txt format.'
task :qif2delim do
  f = command_line_arg('f', 'data/private/ibank_20120328.qif')
  input_list = []
  input_list << {
    :owner    => 'Chris',
    :filename => f,
    :source   => Qiflib::SOURCE_IBANK }
  puts "==="
  csv_lines = Qiflib::Util.transactions_to_delim(input_list)
  csv_lines.each { | line | puts line }
  puts "==="
  csv_lines = Qiflib::Util.catetory_names_to_delim([f])
  csv_lines.each { | line | puts line.inspect }
  puts "==="
end
