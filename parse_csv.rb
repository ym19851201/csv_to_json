require_relative './account'

class CSVParser
  def initialize(text)
    @text = text
  end

  def parse
    accounts = []
    @text.gsub!(/#.+\n/, "")
    @text.each_line.with_index do |line, i|
      unless i == 0
        account = Account.new(i - 1)
        array = @column_names.zip(line.gsub("\n", "").split ',').flatten
        account.attribute_hash = Hash[*array]
        accounts << account
      else
        @column_names = line.gsub("\n", "").split ','
      end
    end

    return accounts
  end
end
