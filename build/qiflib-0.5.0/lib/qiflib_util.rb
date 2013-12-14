
module Qiflib

  # This is the API class of the 'qiflib' library; all functionality
  # is accessed via the class/static methods of this class.

  class Util

    # Return lines in CSV format which contain the list of categories
    # within the given Array of filenames.

    def self.catetory_names_to_csv(files_list)
      categories, csv_lines = [], []
      csv_lines << Qiflib::Category.csv_header
      if files_list
        files_list.each { | filename |
          begin
            file, in_cats = File.new(filename, 'r'), false
            while (line = file.gets)
              stripped = line.strip
              if stripped.match(/^!Type:Cat/)
                in_cats = true
              else
                if (stripped.match(/^!/)) && (stripped.size > 1)
                  in_cats = false
                else
                  if in_cats
                    if (stripped.match(/^N/))
                      categories << line_value(stripped)
                    end
                  end
                end
              end
            end
            file.close if file
          rescue => err
            file.close if file
            puts "Exception: #{err.class.name} #{err.message} #{err.inspect}"
          end
        }
      end
      categories.uniq.sort.each_with_index { | name, idx |
        cat = Qiflib::Category.new(name.strip)
        csv_lines << cat.to_csv(idx)
      }
      csv_lines
    end

    # Return lines in ^-delimited format which contain the list of categories
    # within the given Array of filenames.

    def self.catetory_names_to_delim(files_list)
      delim_lines, csv_lines = [], catetory_names_to_csv(files_list)
      csv_lines.each_with_index { | csv_line, idx |
        if idx > 0
          sio = StringIO.new
          field_array = CSV.parse(csv_line)[0]
          field_array.each { | field |
            sio << field
            sio << '^'
          }
          delim_lines << "#{sio.string.strip.chop}\n"
        end
      }
      delim_lines
    end

    # Return lines in CSV format which contain the list of transactions
    # within the given input_list Array.  Each Hash within the input_list
    # should contain keys :owner, :filename, and :source.  Specify either
    # the value Qiflib::SOURCE_IBANK or Qiflib::SOURCE_QUICKEN for :source.

    def self.transactions_to_csv(input_list)
      transactions, csv_lines = [], []
      csv_lines << Qiflib::Transaction.csv_header
      if input_list
        input_list.each { | input_hash |
          owner    = input_hash[:owner]
          filename = input_hash[:filename]
          source   = input_hash[:source]
          process_file_for_transactions(owner, filename, source, transactions)
        }
        transactions.each_with_index { | tran, idx |
          csv_lines << tran.to_csv(idx)
        }
      end
      csv_lines
    end

    # Return lines in ^-delimited format which contain the list of transactions
    # within the given input_list Array.  Each Hash within the input_list
    # should contain keys :owner, :filename, and :source.  Specify either
    # the value Qiflib::SOURCE_IBANK or Qiflib::SOURCE_QUICKEN for :source.

    def self.transactions_to_delim(input_list)
      delim_lines, csv_lines = [], transactions_to_csv(input_list)
      csv_lines.each_with_index { | csv_line, idx |
        if idx > 0
          sio = StringIO.new
          field_array = CSV.parse(csv_line)[0]
          field_array.each { | field |
            sio << field
            sio << '^'
          }
          delim_lines << "#{sio.string.strip.chop}\n"
        end
      }
      delim_lines
    end

    # Return the lines of DDL for a sqlite3 database, with 'categories' and
    # 'transactions' tables.  The DDL will also import the ^-delimited files.

    def self.generate_sqlite_ddl
      lines = []
      lines << ''
      lines << 'drop table if exists transactions;'
      lines << 'drop table if exists categories;'
      lines << ''
      lines << 'create table transactions('
      lines << '  id               integer,'
      lines << '  acct_owner       varchar(80),'
      lines << '  acct_name        varchar(80),'
      lines << '  acct_type        varchar(80),'
      lines << '  date             varchar(80),'
      lines << '  amount           real,'
      lines << '  number           varchar(80),'
      lines << '  cleared          varchar(80),'
      lines << '  payee            varchar(80),'
      lines << '  category         varchar(80),'
      lines << '  memo             varchar(80),'
      lines << '  split1_amount    real,'
      lines << '  split1_category  varchar(80),'
      lines << '  split1_memo      real,'
      lines << '  split2_amount    varchar(80),'
      lines << '  split2_category  varchar(80),'
      lines << '  split2_memo      varchar(80),'
      lines << '  split3_amount    real,'
      lines << '  split3_category  varchar(80),'
      lines << '  split3_memo      varchar(80),'
      lines << '  address1         varchar(80),'
      lines << '  address2         varchar(80),'
      lines << '  address3         varchar(80),'
      lines << '  address4         varchar(80),'
      lines << '  address5         varchar(80),'
      lines << '  address6         varchar(80),'
      lines << '  eol_ind          char(1)'
      lines << ');'
      lines << ''
      lines << 'create table categories('
      lines << '  id       integer,'
      lines << '  name     varchar(80)'
      lines << ');'
      lines << ''
      lines << ".separator '^'"
      lines << ''
      lines << '.import private/qiflib_transactions.txt transactions'
      lines << '.import private/qiflib_categories.txt   categories'
      lines << ''
      lines
    end

    # Return the lines of bash-shell script to load the sqlite3 database via
    # the DDL generated in method 'generate_sqlite_ddl'.

    def self.generate_sqlite_load_script(db_name='qiflib.db', ddl_name='qiflib.ddl')
      lines = []
      lines << '#!/bin/bash'
      lines << ''
      lines << "sqlite3 #{db_name} < #{ddl_name}"
      lines << ''
      lines
    end

    # For testing purposes:  Qiflib::Util::describe_csv_field_array(array)

    def self.describe_csv_field_array(array)
      field_map = Qiflib::csv_transaction_field_map
      array.each_with_index { | val, idx |
        field_name = field_map[idx]
        puts "array[#{idx}].should == '#{val}' # #{field_name}"
      }
    end

    private

    def self.process_file_for_transactions(owner, filename, source, transactions)
      begin
        file = File.new(filename, 'r')
        in_acct_header, in_type_header, acct_name, acct_type = false, false, '?', '?'
        current_tran = Qiflib::Transaction.new(owner, acct_name, acct_type, source)
        line_number = 0
        while (line = file.gets)
          line_number = line_number + 1
          stripped = line.strip
          if stripped.match(/^!Account/)
            in_acct_header = true
          elsif stripped.match(/^!Type/)
            in_type_header = true
          else
            if in_acct_header
              if stripped.match(/^N/)
                acct_name = line_value(stripped)
                current_tran.acct_name = acct_name
              elsif stripped.match(/^T/)
                acct_type = line_value(stripped)
                current_tran.acct_type = acct_type
              elsif stripped == '^'
                in_acct_header = false
              end
            elsif in_type_header
              if stripped == '^'
                in_type_header = false
              end
            else
              if stripped == '^'
                if current_tran.valid?
                  transactions << current_tran
                end
                current_tran = Qiflib::Transaction.new(owner, acct_name, acct_type, source)
              else
                current_tran.add_line(stripped)
              end
            end
          end
        end
        file.close if file
      rescue => err
        puts "Exception: #{err.class.name} #{err.message} #{err.inspect}"
      end
    end

    def self.line_value(s)
      return '' if s.nil? || s.size < 1
      s[1, s.size].strip
    end

  end

end
