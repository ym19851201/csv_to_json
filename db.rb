require_relative './account'

class AccountDataBase

  def initialize(accounts)
    @accounts = accounts
  end

  def account_at(index)
    @accounts[index]
  end

  def accounts(key, value)
    @accounts.select {|e| eval "e.#{key} == value" }
  end

  def all_accounts
    @accounts
  end

  def method_missing(name, *args)
    if name.to_s =~ /accounts_(.+)_equal_to/
      accounts($1, args[0])
    else
      super
    end
  end
end

