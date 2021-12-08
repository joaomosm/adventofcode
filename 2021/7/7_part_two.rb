require './../module_helpers.rb'

class Day07PartTwo
  include Helpers

  class << self
    def run
      new.run
    end
  end

  def initialize
    @numbers = read_input_chomp('7_input.txt')
      .map { |number| number.split(',') }
      .flatten
      .map(&:to_i)

    @min_distance = nil
    @sequence_numbers = Array.new(@numbers.max + 1, 0)
  end

  def run
    max_iterations = @numbers.max
    
    max_iterations.times { |iteration| calculate_distance(iteration) }

    @min_distance
  end

  def calculate_distance(iteration)
    distance = @numbers.map { |number| sequence((number - iteration).abs) }.sum

    @min_distance = distance if @min_distance.nil? || distance < @min_distance
  end

  def sequence(num)
    return @sequence_numbers[num] if @sequence_numbers[num].positive?
    
    @sequence_numbers[num] = if num == 0
      0
    elsif num == 1
      1
    else
      sequence(num - 1) + num
    end
  end
end

puts Day07PartTwo.run
