require './../helpers.rb'

lines = read_input('1_part_two_input.txt')

window = []
increased = 0
previous = nil

lines.each do |line|
  window.slice!(0, 1) if window.size == 3
  window << line.to_i

  increased +=1 if !previous.nil? && window.sum > previous 
  
  previous = window.sum if window.size == 3
end

puts increased
