import numpy as np

def parse_input(content):
  list = []
  for c in content:
    temp1 = c.split(" @ ")
    temp2 = temp1[1].split(": ")

    id = temp1[0].split("#")[1]
    offset_y, offset_x = temp2[0].split(',')
    size_y, size_x = temp2[1].split('x')

    hash = {
      'id': int(id),
      'offset_x': int(offset_x),
      'offset_y': int(offset_y),
      'size_x': int(size_x),
      'size_y': int(size_y)
    }
    list.append(hash)
  return list

def solve_puzzle(input_list):
  matrix = np.zeros((1000,1000))
  free_ids = []

  for k in input_list:
    dont_overlap = True
    for i in range(k['size_x']):
      for j in range(k['size_y']):       
        current_value = matrix[k['offset_x'] + i][k['offset_y'] + j]
        if current_value == 0:
          matrix[k['offset_x'] + i][k['offset_y'] + j] = k['id']
        else:
          dont_overlap = False
          matrix[k['offset_x'] + i][k['offset_y'] + j] = -1
          if current_value in free_ids:
            free_ids.remove(int(current_value))
          

    if dont_overlap == True:
      free_ids.append(k['id'])
  return free_ids, matrix


with open('3_part_two_input.txt') as f:
  content = f.read().splitlines()

input_list = parse_input(content)
result, matrix = solve_puzzle(input_list)

print result[0]
