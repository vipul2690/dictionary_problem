require 'rspec'
require 'dictionary'

RSpec.describe Dictionary  do

  context 'invalid input is passed' do

    it 'returns false when number contains 1 or 0' do
      dictionary = Dictionary.new(1234)
      expect(dictionary.instance_eval{ is_valid?(1234) }).to be false
      expect(dictionary.instance_eval{ is_valid?(0234) }).to be false
    end

    it 'returns false when length of number is not equal to 10' do
      dictionary = Dictionary.new(1234)
      expect(dictionary.instance_eval{ is_valid?(1234) }).to be false
      expect(dictionary.instance_eval{ is_valid?(02341234555) }).to be false
    end
  end

end