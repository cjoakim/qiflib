=begin
                                      
Copyright (C) 2013 Chris Joakim.

RSpec test case for class Qiflib::Money.

=end

$:.unshift File.join(File.dirname(__FILE__), "..", "lib")
require File.dirname(__FILE__) + '/../lib/qiflib.rb'
require 'spec_helper'

describe "Qiflib::Money" do

  it "should handle truncated negative values" do
    m = Qiflib::Money.new('-130.')
    m.string_value.should == '-130.00'
    m.cents.should == -13000
  end
  
  it "should handle truncated positive values" do
    m = Qiflib::Money.new('1000.')
    m.string_value.should == '1000.00'
    m.cents.should == 100000
  end  
  
  it "should handle positive values with decimals" do
    m = Qiflib::Money.new('6543.21')
    m.string_value.should == '6543.21'
    m.cents.should == 654321
  end 
  
  it "should handle negative values with decimals" do
    m = Qiflib::Money.new('-6543.21')
    m.string_value.should == '-6543.21'
    m.cents.should == -654321
  end
  
  it "should handle an empty String" do
    m = Qiflib::Money.new('')
    m.string_value.should == '0.00'
    m.cents.should == 0
  end 
  
  it "should handle no arg" do
    m = Qiflib::Money.new()
    m.string_value.should == '0.00'
    m.cents.should == 0   
  end
  
  it "should handle a nil arg" do
    m = Qiflib::Money.new(nil)
    m.string_value.should == '0.00'
    m.cents.should == 0   
  end

end
 