require './../module_helpers.rb'

class Day14PartTwo
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
    @current_pairs = {}

    @lines.each_with_index do |line, index|
      @sequence = line if index == 0

      if index > 1
        key, value = line.split(' -> ')
        @rules[key] = value
        @current_pairs[key] = 0
      end
    end

    @alphabet = {}.tap do |alphabet|
      @rules.values.uniq.each do |char|
        alphabet[char] = 0
      end
    end

    (@sequence.size - 1).times { |i| @current_pairs[@sequence[i..(i + 1)]] += 1 }
  end

  def run
    run_steps(40)

    calculate_result
  end

  def run_steps(num_steps = NUM_STEPS)
    num_steps.times { |step| apply_rules_to_sequence }
  end

  def apply_rules_to_sequence
    new_pairs = {}
    @current_pairs.each do |pair_key, pair_count|
      next if pair_count == 0

      first_pair = [pair_key[0], @rules[pair_key]].join('')
      second_pair = [@rules[pair_key], pair_key[1]].join('')

      new_pairs[first_pair] = init_or_increment_pair(new_pairs, first_pair, pair_count)
      new_pairs[second_pair] = init_or_increment_pair(new_pairs, second_pair, pair_count)
    end

    @current_pairs = new_pairs
  end

  def init_or_increment_pair(pairs, index, count)
    pairs[index].nil? ? count : pairs[index] + count
  end

  def calculate_result
    @current_pairs.each do |key, value|
      @alphabet[key[0]] += value
    end
    @alphabet[@sequence[-1]] += 1

    @alphabet.values.max - @alphabet.values.min
  end
end

puts Day14PartTwo.run
