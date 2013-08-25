=begin

Copyright (C) 2013 Chris Joakim.

RSpec test case for module Qiflib - VERSION and DATE.

=end

$:.unshift File.join(File.dirname(__FILE__), "..", "lib")
require File.dirname(__FILE__) + '/../lib/qiflib.rb'
require 'spec_helper'

describe "Qiflib module constants" do

  it "should have the correct VERSION" do
    Qiflib::VERSION.should == '0.3.0'
  end

  it "should have the correct DATE" do
    Qiflib::DATE.should == '2013-08-25'
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
    # header_array.each { | name |
    #   puts "      lines << '  #{name.strip}          varchar(80),'"
    # }
  end

  it "should implement the method 'csv_category_field_names'" do
    header_array = Qiflib::csv_category_field_names
    validate_category_header_fields(header_array)
  end

end