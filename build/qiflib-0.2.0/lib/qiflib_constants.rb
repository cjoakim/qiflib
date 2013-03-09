
# This file, and Qiflib module, define constant values used in this library.
# This include the lists of field names within the csv and delimited files.
  
module Qiflib

  VERSION        = '0.2.0'
  DATE           = '2013-02-23'
  AUTHOR         = 'Chris Joakim' 
  EMAIL          = 'cjoakim@bellsouth.net'
  SOURCE_QUICKEN = 'quicken'
  SOURCE_IBANK   = 'ibank'

  def self.csv_category_field_names
    %w( id name )
  end
  
  def self.csv_transaction_field_names
    %w(
      id
      acct_owner
      acct_name
      acct_type
      date
      amount
      number
      ibank_n
      cleared
      payee
      category
      memo
      split1_amount
      split1_category
      split1_memo
      split2_amount
      split2_category
      split2_memo
      split3_amount
      split3_category
      split3_memo
      address1
      address2
      address3
      address4
      address5
      address6
      eol_ind
    )
  end
    
end
 