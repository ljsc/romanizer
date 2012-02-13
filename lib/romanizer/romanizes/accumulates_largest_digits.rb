require "romanizer/romanizes"

module Romanizer
  class Romanizes
    class AccumulatesLargestDigits
      def initialize(romanizes)
        @romanizes = romanizes
        @stack = @romanizes.arabic_to_roman_map.keys.sort.reverse
      end
      
      def convert(arabic_number)
        @remaining = arabic_number
        record_next_digit while more_to_try?
        roman_digits
      end

      def record_next_digit
        if should_add_digit?
          add_roman_digit
          decrement_remaining
        else
          advance_to_next_value
        end
      end

      def should_add_digit?
        value_to_try and @remaining >= value_to_try
      end

      def more_to_try?
        value_to_try and @remaining > 0
      end

      def decrement_remaining
        @remaining -= value_to_try
      end

      def advance_to_next_value
        @value = @stack.shift
      end

      def value_to_try
        @value ||= advance_to_next_value
      end

      def roman_digits
        @roman_digits ||= ''
      end

      def add_roman_digit
        roman_digits << @romanizes.romanize_digit(value_to_try)
      end
    end
  end
end
