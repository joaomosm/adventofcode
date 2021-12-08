require './../module_helpers.rb'

class Day07PartOne
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
  end

  def run
    max_iterations = @numbers.max
    
    max_iterations.times { |iteration| calculate_distance(iteration) }

    @min_distance
  end

  def calculate_distance(iteration)
    distance = @numbers.map { |number| (number - iteration).abs }.sum

    @min_distance = distance if @min_distance.nil? || distance < @min_distance
  end
end

puts Day07PartOne.run
