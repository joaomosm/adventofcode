with open('5_part_two_input.txt') as f:
  content = f.read().splitlines()

def solve_puzzle(content):
  array = []
  for boarding_pass in content:
    min_row = 0
    max_row = 127
    min_column = 0
    max_column = 7
    for i in range(len(boarding_pass)):
      c = boarding_pass[i]
      if c == 'F':
        max_row -= 128 / (2 ** (i + 1))
      if c == 'B':
        min_row += 128 / (2 ** (i + 1))
      if c == 'R':
        min_column += 8 / (2 ** (i - 6))
      if c == 'L':
        max_column -= 8 / (2 ** (i - 6))
      
    seat_id = int(max_row * 8 + max_column)
    array.append(seat_id)
  
  array.sort()
  for i in range(len(array) - 1):
    diff = array[i + 1] - array[i]
    if diff == 2:
      return array[i] + 1


print(solve_puzzle(content))