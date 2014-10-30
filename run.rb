require_relative "./parse_csv"
require_relative "./db"
require_relative "./to_json"

puts "input csv file path. ex) ./xxx.csv"
file_path = STDIN.gets.chomp

open(file_path) do |file|
  accounts = CSVParser.new(file.read).parse
  db = AccountDataBase.new(accounts)
  puts <<-EOS
  input attribute condition.
   ex) type \"age 30\" if you need data whose attribute \"age\" equal to \"30\".
       if you dont, just press Enter"
  EOS
  attr_condition = STDIN.gets.chomp.split " "
  if attr_condition.length <= 1
    data = db.all_accounts
  else
    data = eval "db.accounts_#{attr_condition[0]}_equal_to(\"#{attr_condition[1]}\")"
    puts "db.accounts_#{attr_condition[0]}_equal_to(\"#{attr_condition[1]}\")"
  end

  puts 'input data bag id.'
  id = STDIN.gets.chomp

  puts 'input name of data construct.'
  name = STDIN.gets.chomp

  puts id, name ,data
  puts Jsonizer::to_data_bag_json(id, name, data)

end
