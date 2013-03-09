=begin 

Copyright (C) 2013 Chris Joakim.

=end

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
  f = command_line_arg('f', 'data/ibank_20120328.qif')
  csv_lines = Qiflib::Util.qiftocsv([f])
  puts "csv_lines: #{csv_lines.size}"
  csv_lines.each { | csv | puts csv }
end
