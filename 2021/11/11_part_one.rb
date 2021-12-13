require './../module_helpers.rb'

class Day11PartOne
  include Helpers

  class << self
    def run
      new.run
    end
  end

  FLASHING_VALUE = 10.freeze

  def initialize
    @matrix = read_input_chomp('11_input.txt')
      .map { |line| line.split('').map(&:to_i) }
    
    @num_flashes = 0
  end

  def run
    # print_matrix

    100.times do |step|
      run_step(step)
      replace_ten_by_zero
    end

    @num_flashes
  end

  def run_step(step)
    @matrix.each_with_index do |row, i|
      row.each_with_index do |_cell, j|
        increment_energy(i, j)
      end
    end
  end

  def replace_ten_by_zero
    @matrix.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        @matrix[i][j] = 0 if cell == 10
      end
    end
  end

  def increment_energy(i, j, options = {})
    return if i < 0 || i >= @matrix.size
    return if j < 0 || j >= @matrix.first.size
    return if @matrix[i][j] == 10

    @matrix[i][j] = [@matrix[i][j] + 1, FLASHING_VALUE].min

    flash_adjacent(i, j) if is_flashing?(@matrix[i][j])
  end

  def is_flashing?(cell)
    flashed = cell == 10

    @num_flashes += 1 if flashed

    flashed
  end

  def flash_adjacent(i, j)
    increment_energy(i - 1, j - 1)
    increment_energy(i - 1, j)
    increment_energy(i - 1, j + 1)
    increment_energy(i, j - 1)
    increment_energy(i, j + 1)
    increment_energy(i + 1, j - 1)
    increment_energy(i + 1, j)
    increment_energy(i + 1, j + 1)
  end

  def reset_energy(i, j)
    @matrix[i][j] = 0 if @matrix[i][j] == FLASHING_VALUE
  end
end

puts Day11PartOne.run
