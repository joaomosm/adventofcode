require './../module_helpers.rb'

class Day08PartTwo
  include Helpers

  class << self
    def run
      new.run
    end
  end

  def initialize
    @entries = read_input_chomp('8_input.txt')
      .map { |line| Entry.new(line) }
  end

  def run
    @entries.map { |entry| entry.decode }.sum
  end

  class Entry
    attr_reader :signal_patterns, :output_values

    ONLY_VALUES_LENGTHS = [2, 3, 4, 7].freeze

    def initialize(line)
      before_delimiter, after_delimiter = line.split(' | ')

      @signal_patterns = before_delimiter.split(' ')
      @output_values = after_delimiter.split(' ')
      @ordered_patterns = @signal_patterns.sort_by(&:size)
      @digits_patterns = Array.new(10, nil)
    end

    def only_digits_count
      @output_values.count { |output_value| ONLY_VALUES_LENGTHS.include?(output_value.size) }
    end

    def decode
      first_iteration
      second_iteration
      third_iteration

      decode_output_values
    end

    def decode_output_values
      @output_values.map do |output_value|
        convert_to_digit(output_value)
      end.join('').to_i
    end

    private

    def string_sorted_by_chars(string)
      string.split('').sort.join('')
    end

    def convert_to_digit(output_value)
      sorted_output_value = string_sorted_by_chars(output_value)

      @digits_patterns.find_index { |digital_pattern| string_sorted_by_chars(digital_pattern) == sorted_output_value }
    end

    def first_iteration
      @digits_patterns[1] = get_element_by_length(2)
      remove_from_ordered_patterns(@digits_patterns[1])

      @digits_patterns[7] = get_element_by_length(3)
      remove_from_ordered_patterns(@digits_patterns[7])

      @digits_patterns[4] = get_element_by_length(4)
      remove_from_ordered_patterns(@digits_patterns[4])

      @digits_patterns[8] = get_element_by_length(7)
      remove_from_ordered_patterns(@digits_patterns[8])
    end

    def second_iteration
      @digits_patterns[6] = get_digit_six
      remove_from_ordered_patterns(@digits_patterns[6])

      @digits_patterns[9] = get_digit_nine
      remove_from_ordered_patterns(@digits_patterns[9])

      @digits_patterns[0] = get_digit_zero
      remove_from_ordered_patterns(@digits_patterns[0])
    end

    def third_iteration
      @digits_patterns[5] = get_digit_five
      remove_from_ordered_patterns(@digits_patterns[5])

      @digits_patterns[3] = get_digit_three
      remove_from_ordered_patterns(@digits_patterns[3])

      @digits_patterns[2] = get_digit_two
      remove_from_ordered_patterns(@digits_patterns[2])
    end

    def get_digit_six
      get_elements_by_length(6).each do |pattern|
        return pattern if (@digits_patterns[1].split('') - pattern.split('')).size == 1
      end
    end

    def get_digit_nine
      get_elements_by_length(6).each do |pattern|
        return pattern if (@digits_patterns[4].split('') - pattern.split('')).size == 0
      end
    end

    def get_digit_zero
      get_element_by_length(6)
    end

    def get_digit_five
      get_elements_by_length(5).each do |pattern|
        return pattern if (@digits_patterns[6].split('') - pattern.split('')).size == 1
      end
    end

    def get_digit_three
      get_elements_by_length(5).each do |pattern|
        return pattern if (@digits_patterns[9].split('') - pattern.split('')).size == 1
      end
    end

    def get_digit_two
      get_element_by_length(5)
    end

    def get_element_by_length(length)
      @ordered_patterns.find { |pattern| pattern.size == length }
    end

    def get_elements_by_length(length)
      @ordered_patterns.select { |pattern| pattern.size == length }
    end

    def remove_from_ordered_patterns(digit_pattern)
      @ordered_patterns.delete(digit_pattern)
    end
  end
end

puts Day08PartTwo.run
