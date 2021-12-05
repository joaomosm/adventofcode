# Helpers for the 2021 challenge in Ruby
module Helpers

  def read_input(filename)
    IO.readlines(filename)
  end

  def read_input_chomp(filename)
    IO.readlines(filename, chomp: true)
  end

  def print_debug
    3
  end

end