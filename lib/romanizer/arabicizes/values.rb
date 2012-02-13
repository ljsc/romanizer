module Romanizer
  class Arabicizes
    class Values
      def initialize(numbers)
        @collection = Array(numbers)
      end

      def with_smaller_values_flipped
        @collection.each_with_index.map do |n, i|
          negate_when_less_than_next_value(n,i)
        end
      end

      def negate_when_less_than_next_value(n,i)
        rightmost_value?(i) || greater_than_next_value?(n,i) ? n : -n
      end

      def rightmost_value?(i)
        i == (@collection.length-1)
      end

      def greater_than_next_value?(n,i)
        n >= @collection[i+1]
      end

      def sum(numbers)
        numbers.inject(0, &:+)
      end

      def total
        sum(with_smaller_values_flipped)
      end
    end
  end
end

