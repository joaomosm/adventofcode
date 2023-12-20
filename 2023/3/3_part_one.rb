require './../module_helpers.rb'

class Day03PartOne
  include Helpers

  REGEX = /[^\d.]/.freeze

  attr_reader :lines, :height, :width

  class << self
    def run
      new.run
    end
  end

  def initialize
    @lines = read_input_chomp('3_input.txt')
    @height = lines.size
    @width = lines[0].size
  end

  def run
    find_part_numbers.sum
  end

  def find_part_numbers
    [].tap do |part_numbers|
      lines.each_with_index do |row, row_index|
        row.to_enum(:scan, /\d+/).map { Regexp.last_match }.each do |match|
          number, start_index, end_index = parse_number_metadata(match, lines, row_index)

          part_numbers << number.to_i if check_adjacents(start_index, end_index, row_index)
        end
      end
    end
  end

  def parse_number_metadata(match, lines, row_index)
    number = match.to_s
    start_index = match.begin(0)
    end_index = match.end(0) - 1

    [
      number,
      start_index,
      end_index
    ]
  end

  def check_adjacents(start_index, end_index, row_index)
    if row_index > 0
      return true unless lines[row_index - 1][min_x_index(start_index)..max_x_index(end_index)].match(REGEX).nil?
    end

    if row_index < height - 1
      return true unless lines[row_index + 1][min_x_index(start_index)..max_x_index(end_index)].match(REGEX).nil?
    end

    if start_index > 0
      return true unless lines[row_index][(start_index - 1)..end_index].match(REGEX).nil?
    end

    if end_index < width - 1
      return true unless lines[row_index][(start_index)..(end_index + 1)].match(REGEX).nil?
    end

    return false
  end

  def min_x_index(index)
    return index - 1 if index > 0
    
    0
  end

  def max_x_index(index)
    return index + 1 if index < width
    
    lines.size
  end
end

puts Day03PartOne.run