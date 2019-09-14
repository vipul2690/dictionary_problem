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
      dictionary = build_dictionary(file_path)
      digit_to_key = @telephone_number.to_s.chars.map{|digit| mapping[digit]}
      result = {}
      two_word_combo(@telephone_number, 2, digit_to_key, dictionary, result)
      result = result.sort.reverse.to_h
      combinations = get_final_words(result)
      final_words = []
      one_word_combos = get_single_words(@telephone_number, digit_to_key, dictionary)
      final_words << one_word_combos.each { |word| puts word.to_s }
      combinations.each do |combo|
        final_words << combo.to_csv.to_s.chop
      end
      print final_words
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

  def two_word_combo(input, index, digit_to_key_map, dictionary, results)
    if index == input.to_s.length
        return
    end
    num_length = digit_to_key_map.length
    first_word = digit_to_key_map[0..index]
    second_word = digit_to_key_map[index+1..num_length]
    word_store = []
    if first_word.length < 3 || second_word.length < 3
      helper(input, index+1, digit_to_key_map, dictionary, results)
    else
      word_store_one = first_word.shift.product(*first_word).map(&:join)
      if word_store_one.nil?
        helper(input, index+1, digit_to_key_map, dictionary, results)
      end
      word_store_two = second_word.shift.product(*second_word).map(&:join)
      if word_store_two.nil?
        helper(input, index+1, digit_to_key_map, dictionary,results)
      end
      results[index+1] = [(word_store_one & dictionary), (word_store_two & dictionary)]
      helper(input, index+1, digit_to_key_map, dictionary, results)
    end
  end

  def get_single_words(input, digit_to_key_map, dictionary)
    input_length = input.to_s.length
    word_map = digit_to_key_map[0..input_length]
    words = word_map.shift.product(*word_map).map(&:join)
    words & dictionary
  end

  def get_final_words(results)
    final_words = []
    results.each do |key, combinations|
      next if combinations.first.nil? || combinations.last.nil?
      combinations.first.product(combinations.last).each do |combo_words|
        final_words << combo_words
      end
    end
    final_words
  end
end
