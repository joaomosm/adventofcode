require './../helpers.rb'

lines = read_input('2_part_two_input.txt')

operations = {
  'forward' => 0,
  'up' => 0,
  'down' => 0
}
aim = 0
depth = 0

lines.each do |line|
  direction, steps = line.split(' ')
  operations[direction] += steps.to_i

  aim += steps.to_i if direction == 'down'
  aim -= steps.to_i if direction == 'up'
  depth += steps.to_i * aim if direction == 'forward'
end

puts operations['forward'] * depth