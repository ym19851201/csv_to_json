require_relative "./parse_csv"
require_relative "./to_json"

open("./test.txt") do |file|
  db = AccountDataBase.new(file.read)
  db.parse
  a = db.accounts
  puts Jsonizer::all_to_json("users", a)
#   puts db.accounts_name_equal_to('moriya')
end
# puts account.to_json_construct
