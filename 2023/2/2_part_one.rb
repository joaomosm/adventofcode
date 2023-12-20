require './../helpers.rb'

MAX_CUBES = {
  red: 12,
  green: 13,
  blue: 14
}

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

def game_is_possible?(cubes)
  cubes.each do |cube|
    cube = cube.split(" ")

    number = cube[0].to_i
    color = cube[1].to_sym
  
    if number > MAX_CUBES[color]
      return false
    end
  end

  true
end

lines = read_input_chomp('2_input.txt')

ids = []
lines.each do |line|
  game_id, cubes = parse_line(line)

  if game_is_possible?(cubes)
    ids << game_id.to_i
  end
end

puts ids.sum