
module Qiflib

  # Instances of this class represent a dollar amount values from within a qif file.
  
  class Money

    attr_reader :string_value
    
    def initialize(s='0.00')
      @string_value = "#{s}".tr('TBL, ' , '') 
      if @string_value.size < 1
        @string_value = '0.00'
      end
      if @string_value.end_with?('.')
        @string_value = "#{string_value}00"
      end
    end

    def to_s
      @string_value
    end
    
    def cents
      string_value.tr("$.","").to_i
    end
    
  end
  
end
