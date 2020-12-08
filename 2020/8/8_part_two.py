import numpy as np

with open('8_part_two_input.txt') as f:
  content = f.read().splitlines()

def parse_input(content):
  array = []
  for c in content:
    operation = c.split(' ')[0]
    argument = int(c.split(' ')[1])
    array.append({ 'operation': operation, 'argument': argument })
  return array

def solve_puzzle(array):
  reversed_array = array[::-1]
  completed = False
  result = 0
  i = len(reversed_array) - 1
  while(i >= 0 and not(completed)):
    if(reversed_array[i]['operation'] == 'nop'):
      reversed_array[i]['operation'] = 'jmp'
      [result, completed] = try_puzzle_combination(array)
      reversed_array[i]['operation'] = 'nop'
    elif(reversed_array[i]['operation'] == 'jmp'):
      reversed_array[i]['operation'] = 'nop'
      [result, completed] = try_puzzle_combination(array)
      reversed_array[i]['operation'] = 'jmp'
    i -= 1
    
  return result


def try_puzzle_combination(array):
  result = 0
  alive = True
  index = 0
  completed = False
  occurences_matrix = np.zeros(len(array))
  while(alive):
    if(index >= len(array)):
      alive = False
      completed = True
      continue
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
  return [result, completed]

array = parse_input(content)
result = solve_puzzle(array)
print(result)

  