require './../module_helpers.rb'

class Day09PartTwo
  include Helpers

  class << self
    def run
      new.run
    end
  end

  def initialize
    @matrix = read_input_chomp('9_input.txt')
      .map { |line| line.split('').map(&:to_i) }

    @basins = []
    @occurrences = Array.new(@matrix.size) { Array.new(@matrix.first.size, 0) }
  end

  def run
    @matrix.each_with_index do |row, i|
      row.each_with_index do |element, j|
        @basins << calculate_basin(i, j) if is_low_point?(i, j)
      end
    end

    product_of_the_three_largest_basins
  end

  def product_of_the_three_largest_basins
    @basins.sort.reverse[0..2].inject(:*)
  end

  def calculate_basin(i, j)
    return 0 if @occurrences[i][j].positive?
    @occurrences[i][j] = 1
    
    1 +
    basin_up(i, j) +
    basin_right(i, j) +
    basin_down(i, j) +
    basin_left(i, j)
  end

  def basin_up(i, j)
    return 0 if i == 0
    return 0 if @matrix[i - 1][j] == 9
    return 0 unless @matrix[i][j] < @matrix[i - 1][j]

    calculate_basin(i - 1, j)
  end

  def basin_right(i, j)
    return 0 if j == @matrix.first.size - 1
    return 0 if @matrix[i][j + 1] == 9
    return 0 unless @matrix[i][j] < @matrix[i][j + 1]

    calculate_basin(i, j + 1)
  end

  def basin_down(i, j)
    return 0 if i == @matrix.size - 1
    return 0 if @matrix[i + 1][j] == 9
    return 0 unless @matrix[i][j] < @matrix[i + 1][j]

    calculate_basin(i + 1, j)
  end

  def basin_left(i, j)
    return 0 if j == 0
    return 0 if @matrix[i][j - 1] == 9
    return 0 unless @matrix[i][j] < @matrix[i][j - 1]

    calculate_basin(i, j - 1)
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

puts Day09PartTwo.run
