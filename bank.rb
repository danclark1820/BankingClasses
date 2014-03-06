require 'csv'
require 'pry'

bank_data = []
CSV.foreach('bank_data.csv', headers: true) do |row|
  row["Amount"] = row["Amount"].to_f
  bank_data << row.to_hash
end

balances = []
CSV.foreach('balances.csv', headers: true) do |row|
  row["Balance"] = row["Balance"].to_f
  balances << row.to_hash
end

class BankTransaction

  attr_reader :date, :amount, :description, :account, :hash

  def initialize(hash)
    @date = hash["Date"]
    @amount = hash["Amount"]
    @description = hash["Description"]
    @account = hash["Account"]
    @amount_type
  end

  def credit_or_debit
    if self.amount > 0
       "credit"
    else
       "debit"
    end
  end

  def summary
    "$#{"%0.2f" % @amount.abs} #{self.credit_or_debit} #{date} - #{@description}"
  end

end

transactions_array = []
bank_data.each do |trans|
  transactions_array << BankTransaction.new(trans)
end


class BankAccount

  attr_reader :hash, :ending_balance, :name, :starting_balance

  def initialize(hash, array)
    @name = hash["Account"]
    @starting_balance = hash["Balance"]
    @array = array
    @ending_balance = self.ending_balance
  end

  def starting_balance
    @starting_balance
  end

  def ending_balance
    start_b = @starting_balance
    @array.each do |trans_obj|
      if trans_obj.account == name
        start_b += trans_obj.amount
      end
    end
    @ending_balance = start_b
  end


  def summary
    summaries = []
    @array.each do |trans_obj|
      if trans_obj.account == name
        summaries<<(trans_obj.summary)
      end
    end
    summaries
  end

end

bas = []
balances.each do |ba|
  bas<<BankAccount.new(ba, transactions_array)
end

bas.each do |acct|
  puts "=== #{acct.name} ==="
  puts "Starting balance: $#{"%0.2f" % acct.starting_balance}"
  puts "Ending balance:   $#{"%0.2f" % acct.ending_balance} \n "
  acct.summary.each do |sum|
    puts sum
  end
  puts "======="
end


