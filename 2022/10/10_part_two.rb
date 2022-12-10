require './../helpers.rb'

@matrix = [
  "",
  "",
  "",
  "",
  "",
  ""
]
@current_cycle = 0
@current_sprite = "###....................................."

def update_matrix(x, y)
  return @matrix[x][y] = "#" if @current_sprite[y] == "#"
  
  @matrix[x][y] = "."
end

def update_sprite(value)
  @current_sprite =
    @current_sprite
      .split('')
      .rotate(-1 * value)
      .join
end

def perform_cycle(line)
  x = (@current_cycle / 40.0).floor
  y = @current_cycle % 40
  @current_cycle += 1

  update_matrix(x, y)

  if line != 'noop'
    x = (@current_cycle / 40.0).floor
    y = @current_cycle % 40
    @current_cycle += 1
    update_matrix(x, y)

    line_value = line.split(' ')[1].to_i
    update_sprite(line_value)
  end
end

lines = read_input_chomp('10_input.txt')
lines.each{| line| perform_cycle(line) }

puts @matrix