=begin

Copyright (C) 2013 Chris Joakim.

RSpec test case for class Qiflib::Util.

=end

$:.unshift File.join(File.dirname(__FILE__), "..", "lib")
require File.dirname(__FILE__) + '/../lib/qiflib.rb'
require 'spec_helper'

describe "Qiflib::Util" do
  
  it "should implement method 'transactions_to_csv', for ibank files" do
    csv_filename = 'data/qiflib_transactions.csv' 
    expected_line_count = 9945
    expected_field_count = 28
    input_list = []
    input_list << { 
      :owner    => 'Chris',
      :filename => 'data/ibank_20120328.qif',
      :source   => Qiflib::SOURCE_IBANK }
    csv_lines = Qiflib::Util.transactions_to_csv(input_list)
    write_lines(csv_filename, csv_lines)
    csv_lines.size.should == expected_line_count
    csv_in = IO.readlines(csv_filename)
    csv_in.size.should == expected_line_count
    
    header_array = CSV.parse(csv_in[0])[0]
    first_tran_array = CSV.parse(csv_in[1])[0]
    last_tran_array  = CSV.parse(csv_in[-1])[0]

    validate_transaction_header_fields(header_array)

    first_tran_array.size.should == expected_field_count
    first_tran_array[0].should == '1'
    first_tran_array[1].should == 'chris'
    first_tran_array[2].should == 'amex blue 11006'
    first_tran_array[3].should == 'ccard'
    first_tran_array[4].should == '2002-05-04'
    first_tran_array[5].should == '-100.00'
    first_tran_array[6].should == ''
    first_tran_array[7].should == 'Withdrawal'
    first_tran_array[8].should == ''
    first_tran_array[9].should == "Zapata\'s Cantina"
    first_tran_array[10].should == '550 dining out'
    first_tran_array[11].should == 'with Karen & Gary'
    first_tran_array[12].should == '0.0'
    first_tran_array[13].should == ''
    first_tran_array[14].should == ''
    first_tran_array[15].should == '0.0'
    first_tran_array[16].should == ''
    first_tran_array[17].should == ''
    first_tran_array[18].should == '0.0'
    first_tran_array[19].should == ''
    first_tran_array[20].should == ''
    first_tran_array[21].should == ''
    first_tran_array[22].should == ''
    first_tran_array[23].should == ''
    first_tran_array[24].should == ''
    first_tran_array[25].should == ''
    first_tran_array[26].should == ''
    first_tran_array[27].should == 'x'
           
    last_tran_array.size.should == expected_field_count
    last_tran_array[0].should == '9944'
    last_tran_array[1].should == 'chris'
    last_tran_array[2].should == 'wachovia checking'
    last_tran_array[3].should == 'bank'
    last_tran_array[4].should == '2012-03-28'
    last_tran_array[5].should == '-1000.00'
    last_tran_array[6].should == '4884'
    last_tran_array[7].should == 'POS'
    last_tran_array[8].should == ''
    last_tran_array[9].should == 'Cardmember Service'
    last_tran_array[10].should == '[marriott rewards visa 8822]'
    last_tran_array[11].should == '$982.83 due 4/16'
    last_tran_array[12].should == '0.0'
    last_tran_array[13].should == ''
    last_tran_array[14].should == ''
    last_tran_array[15].should == '0.0'
    last_tran_array[16].should == ''
    last_tran_array[17].should == ''
    last_tran_array[18].should == '0.0'
    last_tran_array[19].should == ''
    last_tran_array[20].should == ''
    last_tran_array[21].should == ''
    last_tran_array[22].should == ''
    last_tran_array[23].should == ''
    last_tran_array[24].should == ''
    last_tran_array[25].should == ''
    last_tran_array[26].should == ''
    last_tran_array[27].should == 'x'
  end 
  
  it "should implement method 'transactions_to_delim', for ibank files" do
    delim_filename = 'data/qiflib_transactions.txt' 
    expected_line_count = 9944
    expected_field_count = 28
    input_list = []
    input_list << { 
      :owner    => 'Chris',
      :filename => 'data/ibank_20120328.qif',
      :source   => Qiflib::SOURCE_IBANK }
    delim_lines = Qiflib::Util.transactions_to_delim(input_list)
    write_lines(delim_filename, delim_lines)
    delim_lines.size.should == expected_line_count
    delim_in = IO.readlines(delim_filename)
    delim_in.size.should == expected_line_count
    
    first_tran_array = delim_in[0].strip.split('^')
    last_tran_array  = delim_in[-1].strip.split('^')

    first_tran_array.size.should == expected_field_count
    first_tran_array[0].should == '1'
    first_tran_array[1].should == 'chris'
    first_tran_array[2].should == 'amex blue 11006'
    first_tran_array[3].should == 'ccard'
    first_tran_array[4].should == '2002-05-04'
    first_tran_array[5].should == '-100.00'
    first_tran_array[6].should == ''
    first_tran_array[7].should == 'Withdrawal'
    first_tran_array[8].should == ''
    first_tran_array[9].should == "Zapata\'s Cantina"
    first_tran_array[10].should == '550 dining out'
    first_tran_array[11].should == 'with Karen & Gary'
    first_tran_array[12].should == '0.0'
    first_tran_array[13].should == ''
    first_tran_array[14].should == ''
    first_tran_array[15].should == '0.0'
    first_tran_array[16].should == ''
    first_tran_array[17].should == ''
    first_tran_array[18].should == '0.0'
    first_tran_array[19].should == ''
    first_tran_array[20].should == ''
    first_tran_array[21].should == ''
    first_tran_array[22].should == ''
    first_tran_array[23].should == ''
    first_tran_array[24].should == ''
    first_tran_array[25].should == ''
    first_tran_array[26].should == ''
    first_tran_array[27].should == 'x'
           
    last_tran_array.size.should == expected_field_count
    last_tran_array[0].should == '9944'
    last_tran_array[1].should == 'chris'
    last_tran_array[2].should == 'wachovia checking'
    last_tran_array[3].should == 'bank'
    last_tran_array[4].should == '2012-03-28'
    last_tran_array[5].should == '-1000.00'
    last_tran_array[6].should == '4884'
    last_tran_array[7].should == 'POS'
    last_tran_array[8].should == ''
    last_tran_array[9].should == 'Cardmember Service'
    last_tran_array[10].should == '[marriott rewards visa 8822]'
    last_tran_array[11].should == '$982.83 due 4/16'
    last_tran_array[12].should == '0.0'
    last_tran_array[13].should == ''
    last_tran_array[14].should == ''
    last_tran_array[15].should == '0.0'
    last_tran_array[16].should == ''
    last_tran_array[17].should == ''
    last_tran_array[18].should == '0.0'
    last_tran_array[19].should == ''
    last_tran_array[20].should == ''
    last_tran_array[21].should == ''
    last_tran_array[22].should == ''
    last_tran_array[23].should == ''
    last_tran_array[24].should == ''
    last_tran_array[25].should == ''
    last_tran_array[26].should == ''
    last_tran_array[27].should == 'x'
  end 

  it "should implement method 'catetory_names_to_csv', for ibank files" do
    csv_filename = 'data/qiflib_categories.csv'
    csv_lines = Qiflib::Util.catetory_names_to_csv(['data/ibank_20120328.qif'])
    write_lines(csv_filename, csv_lines)
    csv_lines.size.should == 88
    csv_in = IO.readlines(csv_filename)
    csv_in.size.should == 88
    
    header_array    = CSV.parse(csv_in[0])[0]
    first_cat_array = CSV.parse(csv_in[1])[0]
    last_cat_array  = CSV.parse(csv_in[-1])[0]

    validate_category_header_fields(header_array)

    first_cat_array.size.should == 2
    first_cat_array[0].should == '1'
    first_cat_array[1].should == '001 salary' 

    last_cat_array.size.should == 2
    last_cat_array[0].should == '87'
    last_cat_array[1].should == '_qk bal to stmt'
  end
  
  it "should implement method 'catetory_names_to_delim', for ibank files" do
    delim_filename = 'data/qiflib_categories.txt'
    delim_lines = Qiflib::Util.catetory_names_to_delim(['data/ibank_20120328.qif'])
    write_lines(delim_filename, delim_lines)
    delim_lines.size.should == 87
    delim_in = IO.readlines(delim_filename)
    delim_in.size.should == 87
    
    first_cat_array = delim_in[0].strip.split('^')
    last_cat_array  = delim_in[-1].strip.split('^')

    first_cat_array.size.should == 2
    first_cat_array[0].should == '1'
    first_cat_array[1].should == '001 salary' 

    last_cat_array.size.should == 2
    last_cat_array[0].should == '87'
    last_cat_array[1].should == '_qk bal to stmt' 
  end
  
  it "should implement method 'generate_sqlite_ddl'" do
    ddl_filename = 'data/qiflib.ddl'
    ddl_lines = Qiflib::Util.generate_sqlite_ddl
    write_lines(ddl_filename, ddl_lines, true)
    ddl_lines.size.should == 45
    ddl_in = IO.readlines(ddl_filename)
    ddl_in.size.should == 45
    
    ddl_in[1].strip.should == 'drop table if exists transactions;'
    ddl_in[2].strip.should == 'drop table if exists categories;'
    ddl_in[4].strip.should == 'create table transactions('  
  end
  
  it "should implement method 'generate_sqlite_load_script'" do
    sh_filename = 'data/qiflib.sh'
    sh_lines = Qiflib::Util.generate_sqlite_load_script
    write_lines(sh_filename, sh_lines, true)
    sh_lines.size.should == 4
    sh_in = IO.readlines(sh_filename)
    sh_in.size.should == 4
    
    sh_in[0].strip.should == '#!/bin/bash'
    sh_in[2].strip.should == 'sqlite3 qiflib.db < qiflib.ddl'
  end 

end
   