require 'spec_helper'

describe "Super STI models with has_extra_data models" do
  
  before :each do 
    @bank = Bank.create!(:name => "My Bank")
    @bank_account = BankAccount.new
    @valid_bank_account_attributes = {:account_number => "12345678", :sort_code => "12 34 56", :bank => @bank}
  end
  
  it "have the data method" do
    @bank_account.should respond_to(:data)
  end

  it "can have variables set" do
    @bank_account.account_number = "12345678"
    @bank_account.sort_code = "12 34 56"
    @bank_account.bank = @bank
    @bank_account.save!
    @bank_account.data.id.should_not == 0
  end
  
  it "creates data with the test class" do
    @bank_account.attributes = @valid_bank_account_attributes
    @bank_account.save!
    @bank_account.data.id.should_not == 0
  end

  it "can read attributes" do
    @bank_account.attributes = @valid_bank_account_attributes
    @bank_account.save!
    @bank_account = BankAccount.find(@bank_account.id)
    @bank_account.account_number.should == "12345678"
  end
  
  it "can read associations" do
    @bank_account.attributes = @valid_bank_account_attributes
    @bank_account.save!
    @bank_account = BankAccount.find(@bank_account.id)
    @bank_account.bank.should == @bank
  end
  
  it "can have a specifc foreign_key" do
    obj = UnusualForeignKey.create!
    obj.data.should_not be_nil
  end
  
  it "can have any table name" do
    obj = UnusualTableName.create!
    obj.data.should_not be_nil
  end
  
  it "does not break scoped" do
    ba1 = BasicAccount.create!(:is_approved => true)
    ba2 = BasicAccount.create!(:is_approved => false)
    ba1.is_approved?.should == true
    ba2.is_approved?.should == false
    BasicAccount.approved.count.should == 1
  end
  
  it "correctly gets parent id, not data id" do
    ActiveRecord::Base.connection.execute("INSERT INTO basic_account_data('basic_account_id') VALUES (0)")
    ba = BasicAccount.create!
    ba.id.should_not == ba.data.id
    
    ba2 = BasicAccount.find(ba.id)
    ba2.id.should == ba.id
    ba2.data.id.should == ba.data.id
    ba2.id.should_not == ba2.data.id
    
    ba3 = Account.find(ba.id)
    ba3.id.should == ba.id
    ba3.data.id.should == ba.data.id
    ba3.id.should_not == ba3.data.id
  end
  
  it "doesn't break if extra data is deleted" do
    ba = BasicAccount.create!
    ActiveRecord::Base.connection.execute("DELETE FROM basic_account_data where id = #{ba.data.id}")
    
    ba2 = BasicAccount.find(ba.id)
    ba2.id.should == ba.id
    ba2.data.should be_nil
  end
  
  it "saves data on updates" do
    # Setup normal bank account
    @bank_account.attributes = @valid_bank_account_attributes
    @bank_account.save!
    @bank_account.account_number.should == "12345678"
    
    # Update attribute
    @bank_account.account_number = "87654321"
    @bank_account.save!
    
    # Check the database has been updated
    BankAccount.find(@bank_account.id).account_number.should == "87654321"
  end
  
  
end