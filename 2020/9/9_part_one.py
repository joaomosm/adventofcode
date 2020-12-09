import numpy as np

PREAMBLE_LENGTH = 25

with open('9_part_one_input.txt') as f:
  content = f.read().splitlines()

def parse_input(content):
  raw_array = []
  for c in content:
    raw_array.append(int(c))
  return np.array(raw_array)

def solve_puzzle(array):
  current_number = PREAMBLE_LENGTH
  found = False
  while(not(bool(found)) and current_number < len(array)):
    left_boundary = current_number - PREAMBLE_LENGTH
    preamble_array = array[left_boundary + 1 : left_boundary + PREAMBLE_LENGTH]
    in_preamble = False
    for i in range(left_boundary, current_number):
      diff = array[current_number] - array[i]
      if(len(np.where(preamble_array == diff)[0]) == 1):
        in_preamble = True
        break
    if(not(bool(in_preamble))):
      found = array[current_number]
    current_number += 1
  return found


array = parse_input(content)
result = solve_puzzle(array)
print(result)
