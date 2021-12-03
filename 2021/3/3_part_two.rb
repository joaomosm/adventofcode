require './../helpers.rb'
require './../binary.rb'

lines = read_input_chomp('3_part_two_input.txt')

def count_common_bits(lines, index, mode)
  sum = 0
  lines.each{ |line| sum += line[index] == '1' ? 1 : -1 }

  if mode == :most
    lines.select!{|line| sum >= 0 ? line[index] == '1' : line[index] == '0' }
  else
    lines.select!{|line| sum >= 0 ? line[index] == '0' : line[index] == '1' }
  end

  lines
end

oxygen = lines.dup
dioxide = lines.dup

oxygen.first.size.times.each do |index|
  break if oxygen.size == 1
  oxygen = count_common_bits(oxygen, index, :most)
end

dioxide.first.size.times.each do |index|
  break if dioxide.size == 1
  dioxide = count_common_bits(dioxide, index, :least)
end

puts Binary.to_decimal(oxygen.first) * Binary.to_decimal(dioxide.first)
