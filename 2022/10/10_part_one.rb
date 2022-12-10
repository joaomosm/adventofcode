require './../helpers.rb'

@current_value = 1
@current_cycle = 0
@strength_values = []

def check_cycles
  special_cycles = [20, 60, 100, 140, 180, 220]
  if special_cycles.include?(@current_cycle)
    @strength_values << @current_value * @current_cycle 
  end
end

def perform_cycle(line)
  @current_cycle += 1
  check_cycles

  if line != 'noop'
    @current_cycle += 1
    check_cycles

    line_value = line.split(' ')[1].to_i
    @current_value += line_value
  end
end

lines = read_input_chomp('10_input.txt')

lines.each{| line| perform_cycle(line) }

puts @strength_values.sum