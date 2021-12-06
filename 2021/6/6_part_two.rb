require './../module_helpers.rb'

class Day06PartTwo
  include Helpers

  NUM_ITERATIONS = 256

  class << self
    def run
      new.run
    end
  end


  def initialize
    @numbers = read_input_chomp('6_input.txt')
                .map{ |number| number.split(',') }
                .flatten
                .map(&:to_i)
    @fishes_ages = Array.new(9, 0)
    @numbers.each { |num| @fishes_ages[num] += 1 }
  end

  def run
    NUM_ITERATIONS.times { |iteration| @fishes_ages = create_fishes_for_a_day }

    @fishes_ages.sum
  end
  
  def create_fishes_for_a_day
    resetted_fishes = @fishes_ages.shift
    @fishes_ages[6] += resetted_fishes
    @fishes_ages << resetted_fishes
  end
end

puts Day06PartTwo.run