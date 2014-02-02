
module Qiflib

  # Instances of this class represent a date from within a qif file,
  # such as 'D5/24/94'.
  
  class Date

    attr_accessor :string_value, :ccyymmdd, :year, :year_mm, :yy, :mm, :dd
    
    def initialize(string_value='')
      @cc, @yy, @mm, @dd = '00', '00', '00', '00'
      @string_value = "#{string_value}".tr('D','')
      tokens = @string_value.split('/')
      if (tokens && tokens.size > 2)
        m   = tokens[0].to_i
        d   = tokens[1].to_i
        y   = tokens[2].to_i
        @yy = tokens[2]
        if (y < 100)
          y < 50 ? @cc = "20" : @cc = "19"
        else
          @cc = ""
        end
        m < 10 ? @mm = "0#{m}" : @mm = "#{m}"
        d < 10 ? @dd = "0#{d}" : @dd = "#{d}"
      end
      @ccyymmdd = "#{@cc}#{@yy}-#{@mm}-#{@dd}"
      @year     = "#{@cc}#{@yy}"
      @year_mm  = "#{@cc}#{@yy}-#{@mm}"
    end
    
    def to_s
      @ccyymmdd
    end
    
  end

end
