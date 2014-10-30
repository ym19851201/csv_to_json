module Jsonize
  def to_json(attribute_hash)
    s = attribute_hash.map do |k, v|
      "\"#{k}\": \"#{v}\""
    end
    s.join(",\n")
  end
end
