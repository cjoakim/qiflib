=begin

Copyright (C) 2013 Chris Joakim. 

RSpec test case for class Qiflib::Category.

=end

$:.unshift File.join(File.dirname(__FILE__), "..", "lib")
require File.dirname(__FILE__) + '/../lib/qiflib.rb'
require 'spec_helper'

describe "Qiflib::Category" do

  it "should implement a constructor" do 
    c = Qiflib::Category.new('555 stuff') 
    c.id.should == 0
    c.name.should == '555 stuff'
  end
  
  it "should implement the method 'to_csv'" do 
    c = Qiflib::Category.new('555 Stuff') 
    csv = c.to_csv(194).should == "195,555 stuff\n"
  end  
  
end
 