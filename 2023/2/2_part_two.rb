require './../helpers.rb'

def parse_game_id(line)
  line.split(" ")[1].split(":")[0]
end

def parse_cubes(line)
  [].tap do |array|
    array << line.scan(/\d+ red/)
    array << line.scan(/\d+ green/)
    array << line.scan(/\d+ blue/)
  end.flatten
end

def parse_line(line)
  [
    parse_game_id(line),
    parse_cubes(line)
  ]
end

def restart_min_cubes
  {
    red: 0,
    green: 0,
    blue: 0
  }
end

def power_of_cubes(cubes)
  min_cubes = restart_min_cubes

  cubes.each do |cube|
    cube = cube.split(" ")

    number = cube[0].to_i
    color = cube[1].to_sym
  
    min_cubes[color] = number  if number > min_cubes[color]
  end

  min_cubes.values.inject(:*)
end

lines = read_input_chomp('2_input.txt')

results = []
lines.each do |line|
  game_id, cubes = parse_line(line)

  results << power_of_cubes(cubes)
end

puts results.sum