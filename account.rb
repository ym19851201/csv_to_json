class Account
  attr_writer :attribute_hash

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
    "ID: #{@id}, ATTRIBUTES: #{@attribute_hash}"
  end

  def to_json
    s = @attribute_hash.map do |k, v|
      "\"#{k}\": \"#{v}\""
    end
    s.join(",\n")
  end

  def to_json_construct
    "{\n#{indent(to_json, 2)}\n}"
  end

  def indent(s, level)
    s.gsub(/^/, ' ' * level)
  end
end

