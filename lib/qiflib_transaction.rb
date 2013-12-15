
module Qiflib

  # Instances of this class represent a transaction parsed within an
  # !Account section of a qif file.

  class Transaction

    attr_accessor :id # computed field
    attr_accessor :acct_owner, :acct_name, :acct_type, :source_app # constructor arg fields
    attr_reader   :date, :amount, :cleared, :category, :number, :payee, :memo # data fields
    attr_reader   :splits, :address
    attr_accessor :balance

    def self.csv_header
      CSV.generate do | csv |
        csv << Qiflib::csv_transaction_field_names
      end
    end

    def initialize(acct_owner=nil, acct_name=nil, acct_type=nil, source_app='quicken')
      if acct_owner
        @acct_owner = "#{acct_owner}".downcase
        @acct_name  = "#{acct_name}".downcase
        @acct_type  = "#{acct_type}".downcase
        @source_app = "#{source_app}".downcase
        @id, @date, @amount, @cleared, @category, @number, @memo, @payee, @balance = 0, nil, nil, '', '', '', '', '', ''
        @splits, @curr_split, @address = [], {}, []
      end
    end

    def add_line(line)
      if line
        stripped = line.strip
        if stripped.size > 0
          # Field Indicator Explanations:
          # D Date
          # T Amount
          # C Cleared status
          # N Num (check or reference number)
          # P Payee
          # M Memo
          # A Address (up to five lines; the sixth line is an optional message)
          # L Category (Category/Subcategory/Transfer/Class)
          # S Category in split (Category/Transfer/Class)
          # E Memo in split
          # $ Dollar amount of split
          # ^ End of the entry
          if (stripped.match(/^D/))
            @date = Qiflib::Date.new(line_value(stripped))
          elsif (stripped.match(/^T/))
            @amount = Qiflib::Money.new(line_value(stripped))
          elsif (stripped.match(/^P/))
            @payee = line_value(stripped)
          elsif (stripped.match(/^C/))
            @cleared = line_value(stripped)
          elsif (stripped.match(/^N/))
            @number = line_value(stripped)
          elsif (stripped.match(/^M/))
            @memo = line_value(stripped)
          elsif (stripped.match(/^L/))
            @category = line_value(stripped).downcase
          elsif (stripped.match(/^S/))
            @category = line_value(stripped).downcase if @category.size == 0 # default to first split category
            current_split['category'] = line_value(stripped).downcase
          elsif (stripped.match(/^E/))
            current_split['memo'] = line_value(stripped)
          elsif (stripped.match(/^A/))
            @address << line_value(stripped)
          elsif (stripped.match(/^\$/))
            current_split['amount'] = Qiflib::Money.new(line_value(stripped))
            splits << current_split
            @curr_split = {}
          end
        end
      end
    end

    def ibank?
      @source_app == 'ibank'
    end

    def valid?
      return false if date.nil?
      return false if date.to_s.size < 8
      return false if date.to_s == '0000-00-00'
      true
    end

    def current_split
      @curr_split = {} if @curr_split.nil?
      @curr_split
    end

    def to_csv(idx=0)
      CSV.generate do | csv |
        csv << as_array(idx)
      end
    end

    def as_array(idx=0)
      array = []
      array << idx + 1
      array << acct_owner.downcase
      array << acct_name.downcase
      array << acct_type.downcase
      array << date.to_s
      array << amount.to_s
      array << number
      array << cleared
      array << payee
      array << category
      array << memo
      3.times { | i |
        if i < splits.size
          array << splits[i]['amount'].to_s
          array << splits[i]['category']
          array << splits[i]['memo']
        else
          array << '0.0'
          array << ''
          array << ''
        end
      }
      6.times { | i |
        if i < address.size
          array << address[i]
        else
          array << ''
        end
      }
      array << balance
      array << 'x'
      array
    end

    def line_value(s)
      return '' if s.nil? || s.size < 1
      s[1, s.size].strip
    end

  end

end
