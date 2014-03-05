# OOP Fundamentals 1
# Bank transactions challenge

require 'csv'
require 'pry'


# data import
bank_data = []
CSV.foreach('bank_data.csv', headers: true) do |row|
  row["Amount"] = row["Amount"].to_f
  bank_data << row.to_hash
end

# data import
balances = []
CSV.foreach('balances.csv', headers: true) do |row|
  row["Balance"] = row["Balance"].to_f
  balances << row.to_hash
end

# bank_data = [
# {"Date"=>"9/12/2013", "Amount"=>-493.0, "Description"=>"Awesome Coffee Inc.", "Account"=>"Purchasing Account"}
# {"Date"=>"9/14/2013", "Amount"=>5041.39, "Description"=>"Sales Deposit", "Account"=>"Purchasing Account"}
# {"Date"=>"9/18/2013", "Amount"=>-28.0, "Description"=>"Pizza Pizza", "Account"=>"Business Checking"}
# {"Date"=>"9/20/2013", "Amount"=>49.5, "Description"=>"Quickbooks Pro Subscription", "Account"=>"Business Checking"}
# {"Date"=>"9/21/2013", "Amount"=>-693.0, "Description"=>"Awesome Coffee Inc.", "Account"=>"Purchasing Account"}
# {"Date"=>"9/21/2013", "Amount"=>3033.21, "Description"=>"Sales Deposit", "Account"=>"Purchasing Account"}
# {"Date"=>"9/28/2013", "Amount"=>2200.39, "Description"=>"Sales Deposit", "Account"=>"Business Checking"}
# {"Date"=>"9/29/2013", "Amount"=>-750.0, "Description"=>"Nick's Pastry", "Account"=>"Purchasing Account"}
# {"Date"=>"9/30/2013", "Amount"=>-200.0, "Description"=>"Awesome Cofee Inc.", "Account"=>"Purchasing Account"}
# {"Date"=>"10/1/2013", "Amount"=>-19.99, "Description"=>"Staples, Inc.", "Account"=>"Business Checking"}
# {"Date"=>"10/2/2013", "Amount"=>-29.99, "Description"=>"Amazon.com", "Account"=>"Business Checking"}
# ]


# balances = [
# {"Account"=>"Business Checking",  "Balance"=>4010.0},
# {"Account"=>"Purchasing Account", "Balance"=>2030.0}
# ]

class BankTransaction

  attr_reader :date, :amount, :description, :account,

  def initialize(hash)
    @date = hash["Date"]
    @amount = hash["Amount"]
    @description = hash["Description"]
    @account = hash["Account"]
  end

  def credit_or_debit
    if amount > 0
      @amount_type = "credit"
    else
      @amount "debit"
    end
  end

  def summary
    "#{@amount.abs} #{@amount_type} #{date} - #{@description}"
  end

end

transactions_array = []
bank_data.each do |trans|
  transactions_array << BankTransaction.new(trans)
end



class BankAccount

  attr_reader :starting_bal, :account , :ending_bal

  def initialize(hash, account, description)
    @starting_balance = hash["Balance"]
    @account = account
    @ending_balance= hash["Balance"]
    @description = description
  end

  def starting_balance
    @starting_balance
  end

  def ending_balance
    @ending_balance += @starting_balance
  end

  # def summary
  #   summaries = []
  #   transactions_array.each do |trans|
  #     summaries << trans.summary
  #   end
  #   summaries
  # end
end


