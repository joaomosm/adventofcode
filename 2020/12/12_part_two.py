with open('12_part_two_input.txt') as f:
  content = f.read().splitlines()

OPERATIONS = ['N', 'E', 'S', 'W']
OPERATIONS2 = [
  { 'char': 'N', 'command': [0, 1]},
  { 'char': 'E', 'command': [1, 0]},
  { 'char': 'S', 'command': [0, -1]},
  { 'char': 'W', 'command': [-1, 0]},
]

def rotate_waypoint(operation, n_times):
  global waypoint_offset
  if(n_times == 0):
    return 1
  else:
    if(operation == 'R'):
      waypoint_offset = [
        waypoint_offset[1],
        -waypoint_offset[0]
      ]
    else:
      waypoint_offset = [
        -waypoint_offset[1],
        waypoint_offset[0]
      ]
    rotate_waypoint(operation, n_times - 1)

def move_to_waypoint(n_times):
  global waypoint_offset
  global current_dir
  current_pos[0] += waypoint_offset[0] * n_times
  current_pos[1] += waypoint_offset[1] * n_times

def perform_operation(operation, value):
  global current_dir
  if(operation == 'N'):
    waypoint_offset[1] += value
  elif(operation == 'E'):
    waypoint_offset[0] += value
  elif(operation == 'S'):
    waypoint_offset[1] -= value
  elif(operation == 'W'):
    waypoint_offset[0] -= value
  elif(operation == 'F'):
    move_to_waypoint(value)
  elif(operation == 'R'):
    current_index = OPERATIONS.index(current_dir)
    num_dir_changes = value // 90
    current_dir = OPERATIONS[int((current_index + num_dir_changes) % 4)]
    rotate_waypoint(operation, num_dir_changes)
  elif(operation == 'L'):
    current_index = OPERATIONS.index(current_dir)
    num_dir_changes = value // 90
    current_dir = OPERATIONS[int((current_index - num_dir_changes) % 4)]
    rotate_waypoint(operation, num_dir_changes)

def solve_puzzle(array):
  for command in array:
    operation = command[0]
    value = int(command[1:])
    perform_operation(operation, value)
  return abs(current_pos[0]) + abs(current_pos[1])

current_pos = [0, 0]
current_dir = 'E'
waypoint_offset = [10, 1]
array = content
result = solve_puzzle(array)
print(result)