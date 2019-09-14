class Dictionary
  attr_reader :telephone_number

  def initialize(number)
    @telephone_number = number
  end

  def letter_combinations
    mapping = {'2' => %w(a b c), '3' => %w(d e f), '4' => %w(g h i), '5' => %w(j k l), '6' => %w(m n o),
               '7' => %w(p q r s), '8' => %w(t u v), '9' => %w(w x y z) }
    results = []
    if is_valid?(@telephone_number)
      dictionary = build_dictionary
      digit_to_key = @telephone_number.to_s.chars.map{|digit| mapping[digit]}
      print digit_to_key
      # num_length = digit_to_key.length
      # (2..num_length).each { |i|
      #   combo_one = digit_to_key[0..i]
      #   combo_two = digit_to_key[i+1..num_length]
      #   next if combo_one.length < 3 || combo_two.length < 3
      #   word_array_one = combo_one.shift.product(*combo_one).map(&:join)
      #   next if word_array_one.nil?
      #   word_array_two = combo_two.shift.product(*combo_two).map(&:join)
      # }
    end
  end

  private
  def is_valid?(number)
    temp_arr = number.to_s.split('')
    flag = (temp_arr.include?('1') || temp_arr.include?('0')) && !(temp_arr.length == 10) ? false : true
  end

  def build_dictionary
    dictionary = []
    file_path = '../dictionary.txt'
    File.foreach( file_path ) do |word|
      dictionary.push word.chop.to_s.downcase
    end
  end

  def helper(input, index, digit_to_key_map, dictionary)
    num_length = digit_to_key_map.length
    first_word = digit_to_key_map[0..index]
    second_word = digit_to_key_map[index+1..num_length]
    word_store = []
    if first_word.length < 3 || second_word.length < 3
      helper(input, index+1, digit_to_key_map, dictionary)
    else
      word_store_one = first_word.shift.product(*first_word).map(&:join)
      if word_store_one.nil?
        helper(input, index+1, digit_to_key_map, dictionary)
      end
      word_store_two = second_word.shift.product(*second_word).map(&:join)
    end
  end
end
