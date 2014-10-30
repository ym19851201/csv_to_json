module Jsonizer
  DEFAULT_INDENT_CHAR = " "
  DEFAULT_INDENT_LEVEL = 2

  def self.all_to_json(name, accounts)
    accounts_str = accounts.map {|account| account_to_json(account) }.join(",\n")
    "\"#{name}\": [\n#{indent(accounts_str)}\n]"
  end

  def self.account_to_json(account)
    hash_to_json(account.attribute_hash)
  end

  def self.hash_to_json(hash)
    content = hash.map {|k, v| "\"#{k}\": \"#{v}\"" }.join(",\n")
    "{\n#{indent(content)}\n}"
  end

  def self.indent(str, indent_char=DEFAULT_INDENT_CHAR, level=DEFAULT_INDENT_LEVEL)
    str.gsub(/^/, indent_char * level)
  end

  def self.id_to_json(id)
    "\"id\": \"#{id}\","
  end

  def self.to_data_bag_json(id, name, accounts)
    "{\n#{indent(id_to_json(id))}\n#{indent(all_to_json(name, accounts))}\n}"
  end
end
