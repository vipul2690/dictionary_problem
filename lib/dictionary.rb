require 'csv'

class Dictionary
  attr_reader :telephone_number

  def initialize(number)
    @telephone_number = number
  end

  def letter_combinations
    mapping = {'2' => %w(a b c), '3' => %w(d e f), '4' => %w(g h i), '5' => %w(j k l), '6' => %w(m n o),
               '7' => %w(p q r s), '8' => %w(t u v), '9' => %w(w x y z) }
    if is_valid?(@telephone_number)
      file_path = '../dictionary.txt'
      dictionary = %w(motortruck motor truck usual noun struck not opt puck)
      digit_to_key = @telephone_number.to_s.chars.map{|digit| mapping[digit]}
      one_word_combos = get_single_words(@telephone_number, digit_to_key, dictionary)
      two_word_combo = two_word_combo(@telephone_number, 2, dictionary, digit_to_key)
      three_word_combo = three_word_combo(digit_to_key, dictionary)
      combinations = []
      print two_word_combo
      combinations += one_word_combos
      combinations += two_word_combo
      combinations += three_word_combo
      final_words = []
      if(combinations.any?)
        combinations.each do |combo|
          result = combo.is_a?(Array) ? combo.first.to_csv.to_s.chop : combo.to_s
          final_words << result
        end
      end
      puts final_words
      final_words
    end
  end

  private
  def is_valid?(number)
    temp_arr = number.to_s.split('')
    flag = (temp_arr.include?('1') || temp_arr.include?('0')) && !(temp_arr.length == 10) ? false : true
  end

      def build_dictionary(file_path)
    dictionary = []
    File.foreach( file_path ) do |word|
      dictionary.push word.chop.to_s.downcase
    end
    dictionary
      end

  def two_word_combo(input, index, dictionary, digit_to_key_map)
    arr_length = input.to_s.length
    possible_words = []
    (index..arr_length - 3).each do |i|
      num_length = digit_to_key_map.length
      possible_words << extract_words([digit_to_key_map[0..i], digit_to_key_map[i+1..num_length-1]], dictionary)
      possible_words.reject! { |word| word.length == 0 }
    end
    possible_words
  end

    def get_single_words(input, digit_to_key_map, dictionary)
      input_length = input.to_s.length
      word_map = digit_to_key_map[0..input_length]
      words = word_map.shift.product(*word_map).map(&:join)
      words & dictionary
    end

  def three_word_combo(digit_to_key_map, dictionary)
    words = []
    words << extract_words([digit_to_key_map[0..2], digit_to_key_map[3..5], digit_to_key_map[6..9]], dictionary)
    words << extract_words([digit_to_key_map[0..2], digit_to_key_map[3..6], digit_to_key_map[7..9]], dictionary)
    words << extract_words([digit_to_key_map[0..3], digit_to_key_map[4..6], digit_to_key_map[7..9]], dictionary)
    words.reject! { |word| word.length == 0 }
  end

  def extract_words(char_array_map, dictionary)
    word_matches = []
    char_array_map.each do |char_array|
      possible_words = char_array.shift.product(*char_array).map(&:join)
      possible_words.reject! { |word| word.length < 3 }
      possible_words.reject! { |word| !dictionary.include?(word) }
      word_matches << possible_words
    end
    correct_words = []
    if word_matches.size == 2
      correct_words += word_matches[0].product(word_matches[1])
    elsif word_matches.size == 3
      correct_words += word_matches[0].product(word_matches[1]).product(word_matches[2]).map(&:flatten)
    end
    correct_words
  end
end
