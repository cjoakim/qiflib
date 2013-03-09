=begin

Copyright (C) 2013 Chris Joakim.

RSpec test case for class Qiflib::Date.

=end

$:.unshift File.join(File.dirname(__FILE__), "..", "lib")
require File.dirname(__FILE__) + '/../lib/qiflib.rb'
require 'spec_helper'

describe "Qiflib::Date" do

  it "should handle pre Y2K dates" do
    date = Qiflib::Date.new('1/4/99')
    date.string_value.should == '1/4/99'
    date.yy.should == '99'
    date.mm.should == '01'
    date.dd.should == '04' 
    date.year.should == '1999'  
    date.year_mm.should == '1999-01' 
    date.to_s.should == '1999-01-04'
  end
  
  it "should handle post Y2K dates" do
    date = Qiflib::Date.new('3/28/12')
    date.string_value.should == '3/28/12'
    date.yy.should == '12'
    date.mm.should == '03'
    date.dd.should == '28' 
    date.year.should == '2012'  
    date.year_mm.should == '2012-03' 
    date.to_s.should == '2012-03-28'
  end
  
  it "should handle an empty String" do
    date = Qiflib::Date.new('')
    date.string_value.should == ''
    date.yy.should == '00'
    date.mm.should == '00'
    date.dd.should == '00' 
    date.year.should == '0000'  
    date.year_mm.should == '0000-00' 
    date.to_s.should == '0000-00-00'
  end 
  
  it "should handle no arg" do
    date = Qiflib::Date.new()
    date.string_value.should == ''
    date.yy.should == '00'
    date.mm.should == '00'
    date.dd.should == '00' 
    date.year.should == '0000'  
    date.year_mm.should == '0000-00'
    date.to_s.should == '0000-00-00'
  end
  
  it "should handle a nil arg" do
    date = Qiflib::Date.new(nil)
    date.string_value.should == ''
    date.yy.should == '00'
    date.mm.should == '00'
    date.dd.should == '00' 
    date.year.should == '0000'  
    date.year_mm.should == '0000-00' 
    date.to_s.should == '0000-00-00'
  end
  
end
 