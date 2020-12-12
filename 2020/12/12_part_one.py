with open('12_part_one_input.txt') as f:
  content = f.read().splitlines()

OPERATIONS = ['N', 'E', 'S', 'W']

def perform_operation(operation, value, current_dir):
  if(operation == 'N'):
    current_pos[1] += value
  elif(operation == 'E'):
    current_pos[0] += value
  elif(operation == 'S'):
    current_pos[1] -= value
  elif(operation == 'W'):
    current_pos[0] -= value
  elif(operation == 'F'):
    perform_operation(current_dir, value, current_dir)
  elif(operation == 'R'):
    current_index = OPERATIONS.index(current_dir)
    num_dir_changes = value / 90
    current_dir = OPERATIONS[int((current_index + num_dir_changes) % 4)]
  elif(operation == 'L'):
    current_index = OPERATIONS.index(current_dir)
    num_dir_changes = value / 90
    current_dir = OPERATIONS[int((current_index - num_dir_changes) % 4)]
  return current_dir

def solve_puzzle(array):
  current_dir = 'E'
  for command in array:
    operation = command[0]
    value = int(command[1:])
    current_dir = perform_operation(operation, value, current_dir)
  return abs(current_pos[0]) + abs(current_pos[1])

current_pos = [0, 0]
array = content
result = solve_puzzle(array)
print(result)