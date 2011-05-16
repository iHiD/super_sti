require 'spec_helper'

describe "Extra data models" do
  
  before :each do 
    @bank_account = BankAccount.create!(:account_number => "12345678", :sort_code => "12 34 56", :bank => @bank)
  end
  
  it "have the data method" do
    @bank_account.should respond_to(:data)
  end
  
  it "creates data with the test class" do
    @bank_account.data.id.should_not == 0
  end
  
  it "can have associations" do
    
  end
  
end