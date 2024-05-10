module IdGenerator
  def text_to_id(text, prepend: "", delimiter: "-")
    id = text.downcase.strip
    id = "#{prepend} #{id}" unless prepend.empty?
    id = id.gsub(/\s/, delimiter).strip
    id = id.delete_prefix(delimiter).delete_suffix(delimiter).strip
    id
  end

  def self.test!
    eval "class TestIdGenerator; include IdGenerator; end;"

    tests = [
      [["Willie Nelson"], "willie-nelson"],
      [["Willie Nelson", prepend:"prepend"], "prepend-willie-nelson"],
      [["Willie Nelson", prepend:"prepend",delimiter: "$"], "prepend$willie$nelson"],
    ]

    tests.each do |params, expected|
      got = TestIdGenerator.new.text_to_id(*params)
      if got != expected
        raise "From '#{params}' expected '#{expected}' got '#{got}'"
      end
    end
  end
end

IdGenerator.test! if __FILE__ == $PROGRAM_NAME
