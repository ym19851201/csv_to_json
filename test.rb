require_relative "./parse_csv"

open("./test.txt") do |file|
  db = AccountDataBase.new(file.read)
  db.parse
#   puts db.to_data_bag("account_data", "users")
  puts db.accounts_name_equal_to('moriya')
end
# account = Account.new(1)
# account.attribute_hash = {"name"=>"miyazaki", "age"=>"28", "value"=>"value_miyazaki"}

# puts account.to_json_construct
