require './../module_helpers.rb'

class Day14PartOne
  include Helpers

  class << self
    def run
      new.run
    end
  end

  NUM_STEPS = 4.freeze

  def initialize
    @lines = read_input_chomp('14_input.txt')
    @rules = {}

    @lines.each_with_index do |line, index|
      @sequence = line if index == 0

      if index > 1
        key, value = line.split(' -> ')
        @rules[key] = value
      end
    end

    @alphabet = @rules.values.uniq
  end

  def run
    run_steps(10)

    calculate_result
  end

  def run_steps(num_steps = NUM_STEPS)
    num_steps.times { |step| apply_rules_to_sequence } 
  end
  
  def apply_rules_to_sequence
    new_sequence = []

    (@sequence.size - 1).times do |i|
      pair = @sequence[i..(i + 1)]
      new_sequence << @sequence[i] if i == 0
      new_sequence << @rules[pair]
      new_sequence << @sequence[i + 1]
    end

    @sequence = new_sequence.join('')
  end

  def calculate_result
    counters = []

    @alphabet.each { |char| counters << @sequence.count(char) }

    counters.max - counters.min
  end
end

puts Day14PartOne.run
