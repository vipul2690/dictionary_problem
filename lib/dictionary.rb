class Dictionary
  attr_reader :telephone_number

  def initialize(number)
    @telephone_number = number
  end

  def letter_combinations
    mapping = { 2 => 'abc', 3 => 'def', 4 => 'ghi', 5 => 'jkl', 6 => 'mno',
                7 => 'pqrs', 8 => 'tuv', 9 => 'wxyz' }

    results = []
    if self.is_valid?(@telephone_number)

    end
  end

  private
  def is_valid?(number)
    temp_arr = number.to_s.split('')
    flag = (temp_arr.include?('1') || temp_arr.include?('0')) && !(temp_arr.length == 10) ? false : true
  end
end
