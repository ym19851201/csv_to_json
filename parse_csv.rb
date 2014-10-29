class Account
  attr_accessor :attribute_hash

  def initialize(id)
    @id = id
  end

  def method_missing(name, *args)
    if @attribute_hash.key? name.to_s
      @attribute_hash[name.to_s]
    elsif @attribute_hash.key? name
      @attribute_hash[name]
    else
      super
    end
  end

  def to_s
    "#{@id}: #{@attribute_hash}"
  end

  def to_json
    s = @attribute_hash.map do |k, v|
      "\"#{k}\": \"#{v}\""
    end
    s.join(",\n")
  end

  def to_json_construct
    "{\n#{to_json}\n}"
  end
end

class AccountDataBase
  attr_reader :accounts

  def initialize(text)
    @text = text
    @accounts = []
  end
  
  def parse
    @text.each_line.with_index do |line, i|
      unless i == 0
        account = Account.new(i - 1)
        array = @column_names.zip(line.gsub("\n", "").split ',').flatten
        account.attribute_hash = Hash[*array]
        @accounts << account
      else
        @column_names = line.gsub("\n", "").split ','
      end
    end
  end

  def account_at(index)
    @accounts[index]
  end

  def accounts_that_have(key, value)
    @accounts.select {|e| eval "e.#{key} == value" }
  end

  def method_missing(name, *args)
    if name.to_s =~ /accounts_(.+)_equal_to/
      puts $1
      accounts_that_have($1, args[0])
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

