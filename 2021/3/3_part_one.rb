require './../helpers.rb'
require './../binary.rb'

lines = read_input_chomp('3_input.txt')

counters = Array.new(lines.first.size, 0)

lines.each do |line|
  line.split('').each_with_index do |char, index|
    counters[index] += char == '1' ? 1 : -1
  end
end

gamma = counters.map { |char| char.to_i > 0 ? 1 : 0 }.join('')
epsilon = counters.map { |char| char.to_i < 0 ? 1 : 0 }.join('')

puts Binary.to_decimal(gamma) * Binary.to_decimal(epsilon)
