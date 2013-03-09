require 'simplecov'
SimpleCov.start 

require 'rspec'
require 'qiflib'

RSpec.configure do | config |
  config.color_enabled = true
  config.formatter     = 'documentation'
end

def sample_split_transaction1_lines
  data = <<HEREDOC
D2/10/01
PBorders Books & Music
Mtest memo
T-104.23
NWithdrawal
S516 Tech Books
Ehttp pocket ref, java tuning
$-44.
S570 CD & Music
Eu2, knoppfler, hootie
$-60.23
ADavidson
ANorth Carolina 
AUSA
HEREDOC
  return as_lines(data)
end

def sample_split_transaction2_lines
  data = <<HEREDOC
D1/16/10
PAmazon.com
M2 norah jones, 2 coldplay cd's.  comet & reverse ajax
T-62.95
NWithdrawal
S570 CD & Music
E
$-44.95
S516 Tech Books
E
$-18.
ADavidson
ANorth Carolina
AUSA 
^  
HEREDOC
  return as_lines(data)
end

def validate_category_header_fields(header_array)
  header_array.size.should == 2
  header_array[0].should == 'id'
  header_array[1].should == 'name' 
end

def validate_transaction_header_fields(header_array)
  header_array.size.should == 28
  header_array[0].should == 'id'
  header_array[1].should == 'acct_owner'
  header_array[2].should == 'acct_name'
  header_array[3].should == 'acct_type'
  header_array[4].should == 'date'
  header_array[5].should == 'amount'
  header_array[6].should == 'number'
  header_array[7].should == 'ibank_n'
  header_array[8].should == 'cleared'
  header_array[9].should == 'payee'
  header_array[10].should == 'category'
  header_array[11].should == 'memo'
  header_array[12].should == 'split1_amount'
  header_array[13].should == 'split1_category'
  header_array[14].should == 'split1_memo'
  header_array[15].should == 'split2_amount'
  header_array[16].should == 'split2_category'
  header_array[17].should == 'split2_memo'
  header_array[18].should == 'split3_amount'
  header_array[19].should == 'split3_category'
  header_array[20].should == 'split3_memo'
  header_array[21].should == 'address1'
  header_array[22].should == 'address2'
  header_array[23].should == 'address3'
  header_array[24].should == 'address4'
  header_array[25].should == 'address5'
  header_array[26].should == 'address6'
  header_array[27].should == 'eol_ind'
end

def as_lines(s)
  sio, lines = StringIO.new("#{s}"), []
  sio.each_line { | line | lines << line.strip }
  return lines 
end

def write_file(out_name, content)
  out = File.new out_name, "w+"
  out.write content
  out.flush
  out.close  
  puts "file written: #{out_name}"  
end 

def write_lines(out_name, lines, add_newline=false)
  sio = StringIO.new
  lines.each { | line | 
    sio << "#{line}"
    sio << "\n" if add_newline 
  }
  write_file(out_name, sio.string)
end

     