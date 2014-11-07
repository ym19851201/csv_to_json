require_relative './account'

class AccountDataBase

  def initialize(accounts)
    @accounts = DBArray.new(accounts)
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
    if name.to_s =~ /accounts_(.+)=/
      accounts($1, args[0])
    else
      super
    end
  end
end

class DBArray < Array
  def or(c1, c2)
    self.select(&c1) | self.select(&c2)
  end

  def and(c1, c2)
    self.select(&c1) & self.select(&c2)
  end
end

