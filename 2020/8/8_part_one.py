import numpy as np

with open('8_part_one_input.txt') as f:
  content = f.read().splitlines()

def parse_input(content):
  array = []
  for c in content:
    operation = c.split(' ')[0]
    argument = int(c.split(' ')[1])
    array.append({ 'operation': operation, 'argument': argument })
  return array

def solve_puzzle(array):
  result = 0
  alive = True
  index = 0
  occurences_matrix = np.zeros(len(array))
  while(alive):
    if(occurences_matrix[index] == 1):
      alive = False
      continue
    if(array[index]['operation'] == 'nop'):
      occurences_matrix[index] = 1
      index += 1
    elif(array[index]['operation'] == 'acc'):
      occurences_matrix[index] = 1
      result += array[index]['argument']
      index += 1
    elif(array[index]['operation'] == 'jmp'):
      occurences_matrix[index] = 1
      index += array[index]['argument']
  return result

array = parse_input(content)
result = solve_puzzle(array)
print(result)