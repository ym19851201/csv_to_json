require_relative "./parse_csv"
require_relative "./db"

open("./test.txt") do |file|
  db = AccountDataBase.new(CSVParser.new(file.read).parse)
#   db.parse
#   puts db.to_data_bag("account_data", "users")
  db.accounts_age_equal_to('50').each do |account|
    puts account.to_json_construct
  end
end
# account = Account.new(1)
# account.attribute_hash = {"name"=>"miyazaki", "age"=>"28", "value"=>"value_miyazaki"}

# puts account.to_json_construct
