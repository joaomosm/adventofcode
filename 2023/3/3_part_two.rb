require './../module_helpers.rb'

class Day03PartTwo
  include Helpers

  REGEX = /\*/.freeze

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
    find_gears.sum
  end

  def find_gears
    gears = {}

    lines.each_with_index do |row, row_index|
      row.to_enum(:scan, /\d+/).map { Regexp.last_match }.each do |match|
        number, start_index, end_index = parse_number_metadata(match, lines, row_index)
        column_index = match.begin(0)

        if gear_coordinates = check_adjacents(start_index, end_index, row_index, number.to_i)
          key = "#{gear_coordinates[0]}_#{gear_coordinates[1]}".to_sym
          gears[key] = gears.fetch(key, []) << number.to_i
        end
      end
    end
    
    apply_ratios(gears)
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

  def check_adjacents(start_index, end_index, row_index, number = 0)
    if row_index > 0
      matched_data = lines[row_index - 1][min_x_index(start_index)..max_x_index(end_index)].match(REGEX)
      if matched_data
        return [row_index - 1, min_x_index(start_index) + matched_data.begin(0)] 
      end
    end

    if row_index < height - 1
      matched_data = lines[row_index + 1][min_x_index(start_index)..max_x_index(end_index)].match(REGEX)
      if matched_data
        return [row_index + 1, min_x_index(start_index) + matched_data.begin(0)]
      end
    end

    if start_index > 0
      matched_data = lines[row_index][(start_index - 1)..end_index].match(REGEX)
      if matched_data
        return [row_index, start_index - 1] 
      end
    end

    if end_index < width - 1
      matched_data = lines[row_index][(start_index)..(end_index + 1)].match(REGEX)
      if matched_data
        return [row_index, end_index + 1] 
      end
    end

    return false
  end

  def apply_ratios(gears)
    gears.filter!{ |_, numbers| numbers.size == 2 }
    gears.values.map{ |numbers| numbers.inject(:*) }
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

puts Day03PartTwo.run