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

class UnusualForeignKey < Account
  has_extra_data :foreign_key => "unusual_foreign_key"
end

class UnusualTableName < Account
  has_extra_data :table_name => "unusual_table_name"
end

class Bank < ActiveRecord::Base
  has_one :bank_account
end