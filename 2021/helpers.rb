# Helpers for the 2021 challenge in Ruby

def read_input(filename)
  IO.readlines(filename)
end

def read_input_chomp(filename)
  IO.readlines(filename, chomp: true)
end
