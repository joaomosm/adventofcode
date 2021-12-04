require './../helpers.rb'

lines = read_input('2_input.txt')

operations = {
  'forward' => 0,
  'up' => 0,
  'down' => 0
}

lines.each do |line|
  direction, steps = line.split(' ')
  operations[direction] += steps.to_i
end

puts operations['forward'] * (operations['down'] - operations['up'])