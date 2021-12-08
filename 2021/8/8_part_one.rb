require './../module_helpers.rb'

class Day08PartOne
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
    @entries.inject(0) do |sum, entry|
      sum + entry.only_digits_count
    end
  end

  class Entry
    attr_reader :signal_patterns, :output_values

    ONLY_VALUES_LENGTHS = [2, 3, 4, 7].freeze

    def initialize(line)
      before_delimiter, after_delimiter = line.split(' | ')

      @signal_patterns = before_delimiter.split(' ')
      @output_values = after_delimiter.split(' ')
    end

    def only_digits_count
      @output_values.count { |output_value| ONLY_VALUES_LENGTHS.include?(output_value.size) }
    end
  end
end

puts Day08PartOne.run
