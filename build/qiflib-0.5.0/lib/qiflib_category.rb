
module Qiflib

  # Instances of this class represent a catgory parsed within the
  # !Type:Cat section of a qif file.  The qiflib gem only captures
  # the category name, and not the other fields.
  
  class Category

    attr_accessor :id
    attr_accessor :name
    
    # Return the CSV header row.
    
    def self.csv_header
      CSV.generate do | csv |
        csv << Qiflib::csv_category_field_names
      end 
    end 

    # Constructor.  The given n arg is an integer id value; defaults to 0.
    
    def initialize(n=0)
      @id, @name = 0, "#{n}".strip.downcase
    end
    
    # Return this instance a CSV row.
    
    def to_csv(idx=0)
      CSV.generate do | csv |
        csv << as_array(idx)
      end 
    end

    # Return this instance an 2-element array; id and name.
    
    def as_array(idx=0)
      array = []
      array << idx + 1
      array << name
      array
    end
  
  end
  
end
