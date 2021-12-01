lines = IO.readlines("1_part_one_input.txt")

previous = nil
increased = 0
lines.each do |line|
  increased +=1 if !previous.nil? && line.to_i > previous
  
  previous = line.to_i
end

puts increased
