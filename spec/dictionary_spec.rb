require 'rspec'
require 'rspec/mocks'
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

  context 'returns word combinations for number when input is valid' do

    response_one = %w(catamounts act,amounts act,contour cat,amounts cat,contour acta,mounts act,boot,our cat,boot,our)
    response_two = %w(motortruck noun,struck motor,truck motor,usual not,opt,puck)

    it 'returns combination of words as array when input is 2282668687' do
      dictionary = Dictionary.new(2282668687)
      allow(dictionary).to receive(:is_valid?).with(2282668687).and_return(true)
      allow(dictionary).to receive(:build_dictionary).with(any_args).and_return( %w(catamounts acta mounts act amounts act contour cat boot our))
      expect(dictionary.letter_combinations).to eql(response_one)
    end

    it 'returns combination of words as array when input is 6686787825' do
      dictionary = Dictionary.new(6686787825)
      allow(dictionary).to receive(:is_valid?).with(6686787825).and_return(true)
      allow(dictionary).to receive(:build_dictionary).with(any_args).and_return( %w( motortruck motor truck usual noun struck not opt puck))
      expect(dictionary.letter_combinations).to eql(response_two)
    end
  end

end