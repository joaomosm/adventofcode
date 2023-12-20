def read_input(filename)
  IO.readlines(filename)
end

def read_input_chomp(filename)
  IO.readlines(filename, chomp: true)
end
