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
    "ID: #{@id}, ATTRIBUTES: #{@attribute_hash}"
  end
end

