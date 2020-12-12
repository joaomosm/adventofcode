import numpy as np

with open('11_part_two_input.txt') as f:
  content = f.read().splitlines()

def parse_input(content):
  num_rows = len(content)
  num_cols = len(content[0])
  matrix = np.zeros(( num_rows, num_cols ))
  for i in range(num_rows):
    for j in range(num_cols):
      if(content[i][j] == 'L'):
        matrix[i][j] = 1
  return matrix

def is_seat_empty(seat):
  return seat == 1

def is_seat_occupied(seat):
  return seat == 2

def is_occupied_in_direction(matrix, i, j, direction):
  if(i < 0 or i == len(matrix) or j < 0 or j == len(matrix[0])):
    return 0
  if(matrix[i][j] != 0):
    return matrix[i][j] - 1
  else:
    return is_occupied_in_direction(matrix, i + direction[0], j + direction[1], direction)

def num_adjacent_occupied(matrix, i, j):
  count_occupied = 0
  directions = [
    [0, 1],
    [1, 1],
    [1, 0],
    [1, -1],
    [0, -1],
    [-1, -1],
    [-1, 0],
    [-1, 1]
  ]
  for d in directions:
    count_occupied += is_occupied_in_direction(matrix, i + d[0], j + d[1], d)
  
  return count_occupied

def solve_puzzle(matrix):
  stable = False
  while(not(stable)):
    stable = True
    old_matrix = np.copy(matrix)
    for i in range(len(matrix)):
      for j in range(len(matrix[0])):
        if(is_seat_empty(old_matrix[i][j]) and num_adjacent_occupied(old_matrix, i, j) == 0):
          matrix[i][j] = 2
          stable = False
        elif(is_seat_occupied(old_matrix[i][j]) and num_adjacent_occupied(old_matrix, i, j) >= 5):
          matrix[i][j] = 1
          stable = False

  return len(matrix[matrix == 2])

matrix = parse_input(content)
result = solve_puzzle(matrix)
print(result)
