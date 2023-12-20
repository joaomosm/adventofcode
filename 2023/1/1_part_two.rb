require './../helpers.rb'

def find_first_digit(line, mode = nil )
  digit_index = line.size
  digit = 0
  
  line.each_char.with_index do |char, index|
    if char.match?(/\d/)
      digit_index = index
      digit = char
      break
    end
  end

  WORD_DIGITS.each do |key, value|
    value = value.reverse if mode == :reverse

    value_index = line.index(value)
    if value_index && value_index < digit_index
      digit_index = value_index
      digit = key
    end
  end

  return digit
end

WORD_DIGITS = {
  "1" =>'one',
  "2" =>'two',
  "3" =>'three',
  "4" =>'four',
  "5" =>'five',
  "6" =>'six',
  "7" =>'seven',
  "8" =>'eight',
  "9" =>'nine'
}

lines = read_input('1_input.txt')

array = []
lines.each do |line|
  first_digit = find_first_digit(line)
  second_digit = find_first_digit(line.reverse, :reverse)
  array << [first_digit, second_digit].join.to_i
end

puts array.sum