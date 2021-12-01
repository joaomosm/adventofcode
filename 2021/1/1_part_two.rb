lines = IO.readlines("1_part_two_input.txt")

window = []
increased = 0
previous = nil
lines.each do |line|
  if window.size < 3
    window << line.to_i
  else
    window.slice!(0, 1)
    window << line.to_i
  end

  increased +=1 if !previous.nil? && window.sum > previous 
  
  previous = window.sum if window.size == 3
end

puts increased
