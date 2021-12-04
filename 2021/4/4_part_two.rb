require './../helpers.rb'
require './../matrix.rb'

def parse_input(lines)
  matrixes = []
  lines.each_with_index do |line, index|
    next if index == 0

    if line.empty?
      matrixes << Matrix.new
      next
    else
      matrixes.last.add_row(line)
    end
  end

  matrixes
end

def solve(bingo_numbers, matrixes)
  winner_matrixes = []

  bingo_numbers.each do |bingo_number|
    matrixes.each_with_index do |matrix, index|
      next if winner_matrixes.include?(index)
      
      matrix.build_occurrences unless matrix.is_built?
      matrix.mark_number(bingo_number)

      if matrix.is_winner?
        if winner_matrixes.count == matrixes.count - 1
          return matrix.sum_unmarked_numbers * bingo_number
        else
          winner_matrixes << index
        end
      end
    end
  end

  return false
end

lines = read_input_chomp('4_part_two_input.txt')
bingo_numbers = lines.first.split(',').map{ |num| num.to_i }
matrixes = parse_input(lines)

puts solve(bingo_numbers, matrixes)
