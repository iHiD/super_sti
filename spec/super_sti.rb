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
  
end