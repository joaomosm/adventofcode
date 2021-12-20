require './../module_helpers.rb'

class Day13PartOne
  include Helpers

  class << self
    def run
      new.run
    end
  end

  def initialize
    @lines = read_input_chomp('13_input.txt')    
    parse_matrix_sizes
    @matrix = generate_matrix(@current_height, @current_width)

    mode = :dot_coordinates
    @folding_instructions = []
    @lines.map do |line|
      if line == ''
        mode = :folding_instructions
        next
      end

      if mode == :dot_coordinates
        i, j = line.split(',')
        @matrix[j.to_i][i.to_i] = '#'
      elsif mode == :folding_instructions
        instruction, value = line.split('=')
        _, direction = instruction.split('fold along ')

        @folding_instructions << [direction, value.to_i]
      end
    end
  end

  def run
    # print_matrix

    run_folding_instuctions(1)

    # print_matrix

    count_points
  end

  def parse_matrix_sizes
    @current_height = nil
    @current_width = nil

    @lines.each do |line|
      return if @current_height && @current_width

      instructions = line.split('=')
      next if instructions.size <= 1

      _, direction = instructions.first.split('fold along ')
      @current_height = (instructions.last.to_i * 2) + 1 if direction == 'y'
      @current_width = (instructions.last.to_i * 2) + 1 if direction == 'x'
    end
  end

  def generate_matrix(height, width)
    Array.new(height) { Array.new(width, '.') }
  end

  def run_folding_instuctions(max_iteration = nil)
    iteration = 0
    @folding_instructions.each do |instruction|
      return if max_iteration && iteration >= max_iteration
      direction = instruction.first
      value = instruction.last

      fold_paper_y(value) if direction == 'y'
      fold_paper_x(value) if direction == 'x'

      iteration += 1
    end
  end

  def fold_paper_y(value)
    new_matrix = generate_matrix(@matrix.size / 2, @matrix.first.size)
    last_index = @matrix.size - 1

    (0..value - 1).each do |i|
      (0..@matrix.first.size - 1).each do |j|
        new_matrix[i][j] = '#' if @matrix[i][j] == '#'
        new_matrix[i][j] = '#' if @matrix[last_index - i][j] == '#'
      end
    end

    @matrix = new_matrix
  end

  def fold_paper_x(value)
    new_matrix = generate_matrix(@matrix.size, @matrix.first.size / 2)
    last_index = @matrix.first.size - 1

    (0..@matrix.size - 1).each do |i|
      (0..value - 1).each do |j|
        new_matrix[i][j] = '#' if @matrix[i][j] == '#'
        new_matrix[i][j] = '#' if @matrix[i][last_index - j] == '#'
      end
    end

    @matrix = new_matrix
  end

  def count_points
    @matrix.map{ |row| row.count('#') }.sum
  end

  def print_matrix
    @matrix.each do |row|
      puts row.join('')
    end
  end
end

puts Day13PartOne.run
