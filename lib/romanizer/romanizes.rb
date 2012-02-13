require "romanizer/base_numbers"
require "romanizer/romanizes/accumulates_largest_digits"

module Romanizer
  class Romanizes
    include BaseNumbers

    def initialize(arabic_number)
      @arabic_number = arabic_number.to_i
      fail "Number too large to romanize" if @arabic_number > 3999
    end

    def romanize
      AccumulatesLargestDigits.new(self).convert(@arabic_number)
    end

    def romanize_digit(digit)
      arabic_to_roman_map.fetch(digit)
    end

    def arabic_to_roman_map
      new_keys = arabic_bases.each_with_index.map {|base,i| new_bases(base,i)}.compact

      new_keys.inject(base_arabic_to_roman_map) do |m, additional_keys|
        m.merge(additional_keys)
      end
    end

    def new_bases(a,i)
      return if mid_magnitude?(i) || last_base?(i)

      n1, n2 = arabic_bases[i+1], arabic_bases[i+2]
      original_map = base_arabic_to_roman_map
      {
        n1-a => "#{original_map[a]}#{original_map[n1]}",
        n2-a => "#{original_map[a]}#{original_map[n2]}"
      }
    end

    def mid_magnitude?(i)
      i % 2 == 1
    end

    def last_base?(i)
      i + 1 >= arabic_bases.length
    end

    def base_arabic_to_roman_map
      Hash[arabic_bases.zip(roman_bases)]
    end
  end
end
