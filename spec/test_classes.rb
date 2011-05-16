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

class SillyAccount < Account
  has_extra_data :table_name => "silly_table_name" 
end

class Bank < ActiveRecord::Base
  has_one :bank_account
end