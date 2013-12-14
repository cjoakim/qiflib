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
  f = command_line_arg('f', '../cjoakim/ruby/quicker/data/ibank.qif')
  input_list = []
  input_list << {
    :owner    => 'Chris',
    :filename => f,
    :source   => Qiflib::SOURCE_IBANK }
  puts "==="
  Qiflib::Util.transactions_to_csv(input_list).each { | line | puts line }
  puts "==="
  Qiflib::Util.catetory_names_to_csv([f]).each { | line | puts line }
  puts "==="
end

desc 'Convert qif file(s) to delim txt format.'
task :qif2delim do
  f = command_line_arg('f', 'data/private/ibank_20120328.qif')
  f = command_line_arg('f', '../cjoakim/ruby/quicker/data/ibank.qif')
  input_list = []
  input_list << {
    :owner    => 'Chris',
    :filename => f,
    :source   => Qiflib::SOURCE_IBANK }
  puts "==="
  Qiflib::Util.transactions_to_delim(input_list).each { | line | puts line }
  puts "==="
  Qiflib::Util.catetory_names_to_delim([f]).each { | line | puts line }
  puts "==="
end

desc 'List the CSV fields and their indices'
task :list_csv_fields do
  hash = Qiflib::csv_transaction_field_map
  hash.keys.sort.each { | idx |
    name = hash[idx]
    puts "csv field index #{idx} = #{name}"
  }
end

