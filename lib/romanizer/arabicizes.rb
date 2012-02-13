require "romanizer/base_numbers"
require "romanizer/arabicizes/values"

module Romanizer
  class Arabicizes
    include BaseNumbers

    def initialize(roman_number)
      @roman_number = roman_number
      @values = Values.new(values_from_digits)
    end

    def arabicize
      @values.total
    end

    def values_from_digits
      @roman_number.scan(/./).map {|r|
        roman_to_arabic_map.fetch(r)
      }
    end

    def roman_to_arabic_map
      Hash[roman_bases.zip(arabic_bases)]
    end
  end
end
