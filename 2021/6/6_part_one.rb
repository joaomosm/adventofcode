require './../module_helpers.rb'

class Day06PartOne
  include Helpers

  NUM_ITERATIONS = 80

  class << self
    def run
      new.run
    end
  end


  def initialize
    @fishes = read_input_chomp('6_input.txt')
                .map{ |number| number.split(',') }
                .flatten
                .map(&:to_i)
  end

  def run
    NUM_ITERATIONS.times { |iteration| @fishes = create_fishes_for_a_day }

    @fishes.count
  end

  def create_fishes_for_a_day
    new_fishes = []

    old_fishes = [].tap do |old_fishes|
      @fishes.each do |fish|
        if fish > 0
          old_fishes << fish - 1
        else
          old_fishes << 6
          new_fishes << 8
        end
      end
    end

    old_fishes << new_fishes

    old_fishes.flatten
  end
end

puts Day06PartOne.run