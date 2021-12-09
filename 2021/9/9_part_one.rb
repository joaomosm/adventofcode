require './../module_helpers.rb'

class Day09PartOne
  include Helpers

  class << self
    def run
      new.run
    end
  end

  def initialize
    @matrix = read_input_chomp('9_input.txt')
      .map { |line| line.split('').map(&:to_i) }

    @low_points = []
  end

  def run
    @matrix.each_with_index do |row, i|
      row.each_with_index do |element, j|
        @low_points << element + 1 if is_low_point?(i, j)
      end
    end

    @low_points.sum
  end

  def is_low_point?(i, j)
    lower_than_up(i, j) &&
    lower_than_right(i, j) &&
    lower_than_down(i, j) &&
    lower_than_left(i, j)
  end

  def lower_than_up(i, j)
    return true if i == 0

    @matrix[i][j] < @matrix[i - 1][j]
  end

  def lower_than_right(i, j)
    return true if j == @matrix.first.size - 1

    @matrix[i][j] < @matrix[i][j + 1]
  end

  def lower_than_down(i, j)
    return true if i == @matrix.size - 1

    @matrix[i][j] < @matrix[i + 1][j]
  end

  def lower_than_left(i, j)
    return true if j == 0

    @matrix[i][j] < @matrix[i][j - 1]
  end
end

puts Day09PartOne.run
