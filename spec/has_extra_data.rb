require 'spec_helper'

describe "Extra data models" do
  
  before :each do 
    @bank_account = BankAccount.create!
  end
  
  it "have the data method" do
    @bank_account.should respond_to(:data)
  end
  
  it "creates data with the test class" do
    @bank_account.data.id.should_not == 0
  end
  
end