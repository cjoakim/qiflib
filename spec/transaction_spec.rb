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
    t.cleared.should    == 'X'
    t.category.should   == '516 tech books'
    t.number.should     == ''
    t.ibank_n.should    == ''
    t.payee.should      == 'Borders Books & Music'
    t.memo.should       == 'test memo'
    t.splits.size.should == 2
    t.splits[0]['category'].should == '516 tech books'
    t.splits[0]['memo'].should     == 'http pocket ref, java tuning'
    t.splits[0]['amount'].to_s.should == '-44.00'
    t.splits[1]['category'].should == '570 cd & music'
    t.splits[1]['memo'].should     == 'u2, knoppfler, hootie'
    t.splits[1]['amount'].to_s.should == '-60.23'
    t.address.size.should == 0
  end

  it "should implement method 'to_csv'" do
    t = Qiflib::Transaction.new('chris', 'visa', 'credit', 'ibank')
    lines = sample_split_transaction1_lines
    lines.each { | line | t.add_line(line) }
    csv = t.to_csv(3456)
    array = CSV.parse(csv)[0]

    array[0].should == '3457' # id
    array[1].should == 'chris' # acct_owner
    array[2].should == 'visa' # acct_name
    array[3].should == 'credit' # acct_type
    array[4].should == '2001-02-10' # date
    array[5].should == '-104.23' # amount
    array[6].should == '' # number
    array[7].should == '' # ibank_n
    array[8].should == 'X' # cleared
    array[9].should == 'Borders Books & Music' # payee
    array[10].should == '516 tech books' # category
    array[11].should == 'test memo' # memo
    array[12].should == '-44.00' # split1_amount
    array[13].should == '516 tech books' # split1_category
    array[14].should == 'http pocket ref, java tuning' # split1_memo
    array[15].should == '-60.23' # split2_amount
    array[16].should == '570 cd & music' # split2_category
    array[17].should == 'u2, knoppfler, hootie' # split2_memo
    array[18].should == '0.0' # split3_amount
    array[19].should == '' # split3_category
    array[20].should == '' # split3_memo
    array[21].should == '' # address1
    array[22].should == '' # address2
    array[23].should == '' # address3
    array[24].should == '' # address4
    array[25].should == '' # address5
    array[26].should == '' # address6
    array[27].should == 'x' # eol_ind
  end


  it "should implement method 'as_array'" do
    t = Qiflib::Transaction.new('chris', 'visa', 'credit', 'ibank')
    lines = sample_split_transaction1_lines
    lines.each { | line | t.add_line(line) }
    array = t.as_array(3456)

    array[0].should == 3457 # id
    array[1].should == 'chris' # acct_owner
    array[2].should == 'visa' # acct_name
    array[3].should == 'credit' # acct_type
    array[4].should == '2001-02-10' # date
    array[5].should == '-104.23' # amount
    array[6].should == '' # number
    array[7].should == '' # ibank_n
    array[8].should == 'X' # cleared
    array[9].should == 'Borders Books & Music' # payee
    array[10].should == '516 tech books' # category
    array[11].should == 'test memo' # memo
    array[12].should == '-44.00' # split1_amount
    array[13].should == '516 tech books' # split1_category
    array[14].should == 'http pocket ref, java tuning' # split1_memo
    array[15].should == '-60.23' # split2_amount
    array[16].should == '570 cd & music' # split2_category
    array[17].should == 'u2, knoppfler, hootie' # split2_memo
    array[18].should == '0.0' # split3_amount
    array[19].should == '' # split3_category
    array[20].should == '' # split3_memo
    array[21].should == '' # address1
    array[22].should == '' # address2
    array[23].should == '' # address3
    array[24].should == '' # address4
    array[25].should == '' # address5
    array[26].should == '' # address6
    array[27].should == 'x' # eol_ind
  end

end
