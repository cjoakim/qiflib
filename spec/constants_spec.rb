=begin

Copyright (C) 2013 Chris Joakim.

RSpec test case for module Qiflib - VERSION and DATE.

=end

$:.unshift File.join(File.dirname(__FILE__), "..", "lib")
require File.dirname(__FILE__) + '/../lib/qiflib.rb'
require 'spec_helper'

describe "Qiflib module constants" do

  it "should have the correct VERSION" do
    Qiflib::VERSION.should == '0.6.0'
  end

  it "should have the correct DATE" do
    Qiflib::DATE.should == '2013-12-15'
  end

  it "should have the correct AUTHOR" do
    Qiflib::AUTHOR.should == 'Chris Joakim'
  end

  it "should have the correct EMAIL" do
    Qiflib::EMAIL.should == 'cjoakim@bellsouth.net'
  end

  it "should have the correct SOURCE_QUICKEN" do
    Qiflib::SOURCE_QUICKEN.should == 'quicken'
  end

  it "should have the correct SOURCE_IBANK" do
    Qiflib::SOURCE_IBANK.should == 'ibank'
  end

  it "should implement the method 'csv_transaction_field_names'" do
    header_array = Qiflib::csv_transaction_field_names
    validate_transaction_header_fields(header_array)
  end

  it "should implement the method 'csv_transaction_field_map'" do
    hash = Qiflib::csv_transaction_field_map
    hash.size.should == 28
    hash[0].should == 'id'
    hash[1].should == 'acct_owner'
    hash[2].should == 'acct_name'
    hash[3].should == 'acct_type'
    hash[4].should == 'date'
    hash[5].should == 'amount'
    hash[6].should == 'number'
    hash[7].should == 'cleared'
    hash[8].should == 'payee'
    hash[9].should == 'category'
    hash[10].should == 'memo'
    hash[11].should == 'split1_amount'
    hash[12].should == 'split1_category'
    hash[13].should == 'split1_memo'
    hash[14].should == 'split2_amount'
    hash[15].should == 'split2_category'
    hash[16].should == 'split2_memo'
    hash[17].should == 'split3_amount'
    hash[18].should == 'split3_category'
    hash[19].should == 'split3_memo'
    hash[20].should == 'address1'
    hash[21].should == 'address2'
    hash[22].should == 'address3'
    hash[23].should == 'address4'
    hash[24].should == 'address5'
    hash[25].should == 'address6'
    hash[26].should == 'end_balance'
    hash[27].should == 'eol_ind'
  end



  it "should implement the method 'csv_category_field_names'" do
    header_array = Qiflib::csv_category_field_names
    validate_category_header_fields(header_array)
  end

end
