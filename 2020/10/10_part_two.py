import numpy as np

with open('10_part_two_input.txt') as f:
  content = f.read().splitlines()

def parse_input(content):
  array = []
  for c in content:
    array.append(int(c))

  array = np.array(array)
  array = np.append(array, 0)
  array = np.append(array, array.max() + 3)
  array = np.sort(array)
  return array

occurrences = {}
def calc_puzzle(array, index):
  if(index == len(array) - 1):
    return 1
  if(index in occurrences):
    return occurrences[index]
  accumulator = 0

  left_bound = index + 1
  right_bound = len(array)
  for i in range(left_bound, right_bound):
    if(array[i] - array[index] <= 3):
      accumulator += calc_puzzle(array, i)

  occurrences[index] = accumulator
  return accumulator

def solve_puzzle(array):
  accumulator = calc_puzzle(array, 0)
  return accumulator

array = parse_input(content)
result = solve_puzzle(array)
print(result)