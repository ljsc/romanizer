module Romanizer
  module BaseNumbers
    def roman_bases
      'IVXLCDM'.split('')
    end

    def arabic_bases
      [1,5,10,50,100,500,1000]
    end
  end
end

