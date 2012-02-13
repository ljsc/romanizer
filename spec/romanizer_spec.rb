require_relative 'spec_helper'
require_relative '../lib/romanizer'

describe Romanizer do
  describe "converts roman numerals to their arabic equivalents" do
    it "should directly convert simple numbers" do
      subject.arabicize('I').should == 1
      subject.arabicize('V').should == 5
      subject.arabicize('X').should == 10
      subject.arabicize('L').should == 50
      subject.arabicize('C').should == 100
      subject.arabicize('D').should == 500
      subject.arabicize('M').should == 1000
    end

    it "should add the base values for appended characters" do
      subject.arabicize('II').should == 2
      subject.arabicize('VIII').should == 8
      subject.arabicize('XXXI').should == 31
    end

    it "should subtract a number if it is less the value to the right" do
      subject.arabicize('IV').should == 4
    end

    it "should convert complex roman numerals" do
      subject.arabicize('CMII').should == 902
      subject.arabicize('MCMXCIX').should == 1999
    end
  end

  describe "converts arabic numerals to their roman equivalents" do
    it "should directly convert simple numbers" do
      subject.romanize(1).should == 'I'
      subject.romanize(5).should == 'V'
      subject.romanize(10).should == 'X'
      subject.romanize(50).should == 'L'
      subject.romanize(100).should == 'C'
      subject.romanize(500).should == 'D'
      subject.romanize(1000).should == 'M'
    end

    it "should recognize simple subtractions" do
      subject.romanize(4).should == 'IV'
      subject.romanize(9).should == 'IX'
      subject.romanize(40).should == 'XL'
      subject.romanize(90).should == 'XC'
    end

    it "should convert stringed together roman digits" do
      subject.romanize(3).should == 'III'
      subject.romanize(1999).should == 'MCMXCIX'
    end

    it "should accept strings for arabic numbers as well" do
      subject.romanize('1').should == 'I'
    end
  end

  describe "the rubyquiz examples" do
    it "should sove them" do
      subject.arabicize('III').should == 3
      subject.romanize(29).should == 'XXIX'
      subject.romanize(38).should == 'XXXVIII'
      subject.arabicize('CCXCI').should == 291
      subject.romanize(1999).should == 'MCMXCIX'
    end
  end

  describe "invalid numbers" do
    it "should throw an error when an invalid number is encountered" do
      expect { subject.arabicize('Z')}.should raise_error
    end

    it "should throw an error when it sees a value with magnitude greater than 3999" do
      expect { subject.romanize(4000)}.should raise_error
    end
  end

  describe "providing methods as a mixin" do
    let(:klass)   { Class.new }
    let(:object)  { klass.new }

    before(:each) do
      klass.send(:include, Romanizer)
    end

    it "should provide #arabicize" do
      object.should respond_to(:arabicize)
    end

    it "should provide #romanize" do
      object.should respond_to(:romanize)
    end
  end
end

