require './../helpers.rb'

def find_first_digit(line)
  line.each_char do |char|
    return char if char.match?(/\d/)
  end
end

lines = read_input('1_input.txt')

array = []
lines.each do |line|
  first_digit = find_first_digit(line)
  second_digit = find_first_digit(line.reverse)
  array << [first_digit, second_digit].join.to_i
end

puts array.sum