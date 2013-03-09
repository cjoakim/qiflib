=begin

Copyright (C) 2013 Chris Joakim. 

RSpec test case for class Qiflib::Transaction.

=end

$:.unshift File.join(File.dirname(__FILE__), "..", "lib")
require File.dirname(__FILE__) + '/../lib/qiflib.rb'
require 'spec_helper'

describe "Qiflib::Transaction" do

  it "should implement a constructor" do 
    t = Qiflib::Transaction.new('chris', 'visa', 'credit', 'ibank')
    t.acct_owner.should == 'chris'
    t.acct_name.should  == 'visa'
    t.acct_type.should  == 'credit' 
    t.date.should       == nil
    t.amount.should     == nil
    t.cleared.should    == ''
    t.category.should   == ''
    t.number.should     == ''
    t.payee.should      == ''
    t.memo.should       == ''
    t.splits.should     == []
    t.address.should    == []
  end 
  
  it "should construct itself from a set of lines" do 
    t = Qiflib::Transaction.new('chris', 'visa', 'credit', 'ibank')
    lines = sample_split_transaction1_lines
    lines.each { | line | t.add_line(line) }
    t.acct_owner.should == 'chris'
    t.acct_name.should  == 'visa'
    t.acct_type.should  == 'credit' 
    t.date.to_s.should  == '2001-02-10'
    t.amount.to_s.should == '-104.23'
    t.cleared.should    == ''
    t.category.should   == ''
    t.number.should     == ''
    t.ibank_n.should    == 'Withdrawal' 
    t.payee.should      == 'Borders Books & Music'
    t.memo.should       == 'test memo'
    t.splits.size.should == 2
    t.splits[0]['category'].should == '516 tech books' 
    t.splits[0]['memo'].should     == 'http pocket ref, java tuning' 
    t.splits[0]['amount'].to_s.should == '-44.00' 
    t.splits[1]['category'].should == '570 cd & music' 
    t.splits[1]['memo'].should     == 'u2, knoppfler, hootie' 
    t.splits[1]['amount'].to_s.should == '-60.23'
    t.address.size.should == 3
    t.address[0].should == "Davidson"
    t.address[1].should == "North Carolina"
    t.address[2].should == "USA"
  end
  
  it "should implement method 'to_csv'" do 
    t = Qiflib::Transaction.new('chris', 'visa', 'credit', 'ibank')
    lines = sample_split_transaction1_lines
    lines.each { | line | t.add_line(line) } 
    csv = t.to_csv(3456) 
    array = CSV.parse(csv)[0]
    array[0].should == '3457'
    array[1].should == 'chris'
    array[2].should == 'visa'
    array[3].should == 'credit'
    array[4].should == '2001-02-10'
    array[5].should == '-104.23'
    array[6].should == ''
    array[7].should == 'Withdrawal'
    array[8].should == ''
    array[9].should == "Borders Books & Music"
    array[10].should == ''
    array[11].should == 'test memo'
    array[12].should == '-44.00'
    array[13].should == '516 tech books'
    array[14].should == 'http pocket ref, java tuning'
    array[15].should == '-60.23'
    array[16].should == '570 cd & music'
    array[17].should == 'u2, knoppfler, hootie'
    array[18].should == '0.0'
    array[19].should == ''
    array[20].should == ''
    array[21].should == 'Davidson'
    array[22].should == 'North Carolina'
    array[23].should == 'USA'
    array[24].should == ''
    array[25].should == ''
    array[26].should == ''
    array[27].should == 'x' 
  end
  
  
  it "should implement method 'as_array'" do 
    t = Qiflib::Transaction.new('chris', 'visa', 'credit', 'ibank')
    lines = sample_split_transaction1_lines
    lines.each { | line | t.add_line(line) } 
    array = t.as_array(3456) 
    array[0].should == 3457
    array[1].should == 'chris'
    array[2].should == 'visa'
    array[3].should == 'credit'
    array[4].should == '2001-02-10'
    array[5].should == '-104.23'
    array[6].should == ''
    array[7].should == 'Withdrawal'
    array[8].should == ''
    array[9].should == "Borders Books & Music"
    array[10].should == ''
    array[11].should == 'test memo'
    array[12].to_s.should == '-44.00'
    array[13].should == '516 tech books'
    array[14].should == 'http pocket ref, java tuning'
    array[15].to_s.should == '-60.23'
    array[16].should == '570 cd & music'
    array[17].should == 'u2, knoppfler, hootie'
    array[18].to_s.should == '0.0'
    array[19].should == ''
    array[20].should == ''
    array[21].should == 'Davidson'
    array[22].should == 'North Carolina'
    array[23].should == 'USA'
    array[24].should == ''
    array[25].should == ''
    array[26].should == ''
    array[27].should == 'x' 
  end
  
end
 