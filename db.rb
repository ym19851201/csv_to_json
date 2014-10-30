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

  def method_missing(name, *args)
    if name.to_s =~ /accounts_(.+)_equal_to/
      accounts($1, args[0])
    else
      super
    end
  end

  def to_json
    account_json = @accounts.map do |account|
      account.to_json_construct
    end
    account_json.join(",\n")
  end

  def to_json_construct(name)
    "\"#{name}\": [\n#{to_json}\n]"
  end

  def to_data_bag(id, name)
    "{\n\"id\": \"#{id}\",\n#{to_json_construct(name)}\n}\n"
  end
end

