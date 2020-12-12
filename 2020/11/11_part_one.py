import numpy as np

with open('11_part_one_input.txt') as f:
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

def num_adjacent_occupied(matrix, i, j):
  x_min = max([0, j - 1])
  x_max = min([len(matrix[0]), j + 2])
  y_min = max([0, i - 1])
  y_max = min([len(matrix), i + 2])

  adjacents_matrix = matrix[y_min : y_max, x_min : x_max]
  count_occupied = len(adjacents_matrix[adjacents_matrix > 1])

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
