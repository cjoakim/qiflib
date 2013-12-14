=begin

Copyright (C) 2013 Chris Joakim.

RSpec test case for class Qiflib::Util.

=end

$:.unshift File.join(File.dirname(__FILE__), "..", "lib")
require File.dirname(__FILE__) + '/../lib/qiflib.rb'
require 'spec_helper'

describe "Qiflib::Util" do

  def test_qif_filename
    'data/private/ibank_20131214.qif'
  end

  def test_transactions_csv_filename
    'data/private/qiflib_transactions.csv'
  end

  def test_transactions_txt_filename
    'data/private/qiflib_transactions.txt'
  end

  def test_categories_csv_filename
    'data/private/qiflib_categories.csv'
  end

  def test_ddl_filename
    'data/qiflib.ddl'
  end

  def test_sh_filename
    'data/qiflib.sh'
  end

  it "should implement method 'transactions_to_csv', for ibank files" do
    csv_filename = test_transactions_csv_filename
    expected_line_count  = 10000
    expected_field_count = 28
    input_list = []
    input_list << {
      :owner    => 'Chris',
      :filename => test_qif_filename,
      :source   => Qiflib::SOURCE_IBANK }
    csv_lines = Qiflib::Util.transactions_to_csv(input_list)
    write_lines(csv_filename, csv_lines)

    csv_lines.size.should > expected_line_count
    csv_in = IO.readlines(csv_filename)
    csv_in.size.should > expected_line_count

    header_array     = CSV.parse(csv_in[0])[0]
    first_tran_array = CSV.parse(csv_in[1])[0]
    last_tran_array  = CSV.parse(csv_in[-6])[0]

    validate_transaction_header_fields(header_array)

    # Qiflib::Util::describe_csv_field_array(first_tran_array)
    array = first_tran_array
    array[0].should == '1' # id
    array[1].should == 'chris' # acct_owner
    array[2].should == 'amex blue 11006' # acct_name
    array[3].should == 'ccard' # acct_type
    array[4].should == '2002-05-04' # date
    array[5].should == '-100.00' # amount
    array[6].should == '' # number
    array[7].should == 'X' # cleared
    array[8].should == "Zapata's Cantina" # payee
    array[9].should == '550 dining out' # category
    array[10].should == 'with Karen & Gary' # memo
    array[11].should == '0.0' # split1_amount
    array[12].should == '' # split1_category
    array[13].should == '' # split1_memo
    array[14].should == '0.0' # split2_amount
    array[15].should == '' # split2_category
    array[16].should == '' # split2_memo
    array[17].should == '0.0' # split3_amount
    array[18].should == '' # split3_category
    array[19].should == '' # split3_memo
    array[20].should == '' # address1
    array[21].should == '' # address2
    array[22].should == '' # address3
    array[23].should == '' # address4
    array[24].should == '' # address5
    array[25].should == '' # address6
    array[26].should == 'x' # eol_ind
  end

  it "should implement method 'transactions_to_delim', for ibank files" do
    delim_filename = test_transactions_txt_filename
    expected_line_count  = 10000
    expected_field_count = 28
    input_list = []
    input_list << {
      :owner    => 'Chris',
      :filename => test_qif_filename,
      :source   => Qiflib::SOURCE_IBANK }
    delim_lines = Qiflib::Util.transactions_to_delim(input_list)
    write_lines(delim_filename, delim_lines)

    delim_lines.size.should > expected_line_count
    delim_in = IO.readlines(delim_filename)
    delim_in.size.should > expected_line_count

    first_tran_array = delim_in[0].strip.split('^')
    last_tran_array  = delim_in[-6].strip.split('^')

    # Qiflib::Util::describe_csv_field_array(first_tran_array)
    array = first_tran_array
    array[0].should == '1' # id
    array[1].should == 'chris' # acct_owner
    array[2].should == 'amex blue 11006' # acct_name
    array[3].should == 'ccard' # acct_type
    array[4].should == '2002-05-04' # date
    array[5].should == '-100.00' # amount
    array[6].should == '' # number
    array[7].should == 'X' # cleared
    array[8].should == "Zapata's Cantina" # payee
    array[9].should == '550 dining out' # category
    array[10].should == 'with Karen & Gary' # memo
    array[11].should == '0.0' # split1_amount
    array[12].should == '' # split1_category
    array[13].should == '' # split1_memo
    array[14].should == '0.0' # split2_amount
    array[15].should == '' # split2_category
    array[16].should == '' # split2_memo
    array[17].should == '0.0' # split3_amount
    array[18].should == '' # split3_category
    array[19].should == '' # split3_memo
    array[20].should == '' # address1
    array[21].should == '' # address2
    array[22].should == '' # address3
    array[23].should == '' # address4
    array[24].should == '' # address5
    array[25].should == '' # address6
    array[26].should == 'x' # eol_ind

    # Qiflib::Util::describe_csv_field_array(last_tran_array)
    array = last_tran_array
    array[0].should == '10202' # id
    array[1].should == 'chris' # acct_owner
    array[2].should == 'wachovia checking' # acct_name
    array[3].should == 'bank' # acct_type
    array[4].should == '2013-12-05' # date
    array[5].should == '-85.00' # amount
    array[6].should == '5209' # number
    array[7].should == '' # cleared
    array[8].should == 'Duke Energy' # payee
    array[9].should == '120 electric' # category
    array[10].should == '81.59 due 12/9' # memo
    array[11].should == '0.0' # split1_amount
    array[12].should == '' # split1_category
    array[13].should == '' # split1_memo
    array[14].should == '0.0' # split2_amount
    array[15].should == '' # split2_category
    array[16].should == '' # split2_memo
    array[17].should == '0.0' # split3_amount
    array[18].should == '' # split3_category
    array[19].should == '' # split3_memo
    array[20].should == '' # address1
    array[21].should == '' # address2
    array[22].should == '' # address3
    array[23].should == '' # address4
    array[24].should == '' # address5
    array[25].should == '' # address6
    array[26].should == 'x' # eol_ind
  end

  it "should implement method 'catetory_names_to_csv', for ibank files" do
    csv_filename = test_categories_csv_filename
    csv_lines = Qiflib::Util.catetory_names_to_csv([test_qif_filename])
    write_lines(csv_filename, csv_lines)

    csv_lines.size.should > 80
    csv_in = IO.readlines(csv_filename)
    csv_in.size.should > 80

    header_array    = CSV.parse(csv_in[0])[0]
    first_cat_array = CSV.parse(csv_in[1])[0]
    last_cat_array  = CSV.parse(csv_in[-1])[0]

    validate_category_header_fields(header_array)

    first_cat_array.size.should == 2
    first_cat_array[0].should == '1'
    first_cat_array[1].should == '001 salary'

    last_cat_array.size.should == 2
    last_cat_array[0].should == '88'
    last_cat_array[1].should == '•marriott rewards visa'
  end

  it "should implement method 'catetory_names_to_delim', for ibank files" do
    delim_filename = test_categories_csv_filename
    delim_lines = Qiflib::Util.catetory_names_to_delim([test_qif_filename])
    write_lines(delim_filename, delim_lines)

    delim_lines.size.should > 80
    delim_in = IO.readlines(delim_filename)
    delim_in.size.should > 80

    first_cat_array = delim_in[0].strip.split('^')
    last_cat_array  = delim_in[-1].strip.split('^')

    first_cat_array.size.should == 2
    first_cat_array[0].should == '1'
    first_cat_array[1].should == '001 salary'

    last_cat_array.size.should == 2
    last_cat_array[0].should == '88'
    last_cat_array[1].should == '•marriott rewards visa'
  end

  it "should implement method 'generate_sqlite_ddl'" do
    ddl_filename = test_ddl_filename
    ddl_lines = Qiflib::Util.generate_sqlite_ddl
    write_lines(ddl_filename, ddl_lines, true)
    ddl_lines.size.should == 44
    ddl_in = IO.readlines(ddl_filename)
    ddl_in.size.should == 44

    ddl_in[1].strip.should  == 'drop table if exists transactions;'
    ddl_in[2].strip.should  == 'drop table if exists categories;'
    ddl_in[4].strip.should  == 'create table transactions('
    ddl_in[41].strip.should == '.import private/qiflib_transactions.txt transactions'
  end

  it "should implement method 'generate_sqlite_load_script'" do
    sh_filename = test_sh_filename
    sh_lines = Qiflib::Util.generate_sqlite_load_script
    write_lines(sh_filename, sh_lines, true)

    sh_lines.size.should == 4
    sh_in = IO.readlines(sh_filename)
    sh_in.size.should == 4

    sh_in[0].strip.should == '#!/bin/bash'
    sh_in[2].strip.should == 'sqlite3 qiflib.db < qiflib.ddl'
  end

end
