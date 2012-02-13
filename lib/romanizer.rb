require "romanizer/version"
require "romanizer/arabicizes"
require "romanizer/romanizes"

module Romanizer
  extend self

  def arabicize(roman_number)
    Arabicizes.new(roman_number).arabicize
  end

  def romanize(arabic_number)
    Romanizes.new(arabic_number).romanize
  end
end
