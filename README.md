Adds an has_extra_data method to ActiveRecord that invisibly includes an extra data table. Use with STI to keep your database clean. It removes the need to have lots of nullable columns.

Usage
---------
Use in Rails 3 app. Add to bundler:
gem 'super_sti', :git => "git://github.com/ihid/super_sti.git"

Tests
---------
Uses rspec for testing.
Run tests with rspec spec/*

Todo
---------
* Automatically load extra data class with main class.
* Automatically load associations in main class.
* Automatically pass attributes through to main class.

Example
---------

Usage:

    Account.each do |account|
      puts account.balance
    end

    BankAccount.each do |bank_account|
      puts bank_account.balance
      puts bank_account.bank.name
    end

Classes:

    class Account < ActiveRecord::Base
      before_create :set_initial_balance
  
    private
      def set_initial_balance
        self.balance = 0
        true
      end
    end

    class BankAccount < Account
      has_extra_data do
        belongs_to :bank
      end
    end

    class CreditCard < Account
      has_extra_data
    end

    class Bank < ActiveRecord::Base
      has_one :bank_account
    end

Database Schema:

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
