ENV["RAILS_ENV"] ||= 'test'

require 'rails'
require 'rspec-rails'
require 'active_record'

$:.unshift File.dirname(__FILE__) + '/../lib'

# Thie first line isn't working so I have added the second...
require File.dirname(__FILE__) + '/../lib/has_extra_data'
ActiveRecord::Base.send(:extend, HasExtraData::Hook)
 
ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
 
# AR keeps printing annoying schema statements
$stdout = StringIO.new

ActiveRecord::Base.logger
ActiveRecord::Schema.define(:version => 1) do
  create_table :accounts do |t|
    t.float :balance
  end
  
  create_table :bank_account_data do |t|
    t.integer :bank_account_id, :null => false
    t.integer :bank_id, :null => false
    t.string :account_number, :null => false
    t.string :sort_code, :null => false
  end

  create_table :credit_card_data do |t|
    t.integer :credit_card_id, :null => false
    t.string :credit_card_number, :null => false
    t.date :expiry_date, :null => false
  end

  create_table :banks do |t|
    t.string :name, :null => false
  end
  
  create_table :unusual_table_name do |t|
    t.integer :unusual_table_name_id, :null => false
  end

  create_table :unusual_foreign_key_data do |t|
    t.integer :unusual_foreign_key, :null => false
  end
end

require 'test_classes'