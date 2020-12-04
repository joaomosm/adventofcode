def parse_input(content):
  list = []
  for c in content:
    temp1 = c.split("-")
    temp2 = temp1[1].split(" ")
    temp3 = temp2[1].split(":")

    min_times = temp1[0]
    max_times = temp2[0]
    char_to_check = temp3[0]
    password_to_check = temp2[2]

    hash = {
      'min': int(temp1[0]),
      'max': int(temp2[0]),
      'char': temp3[0],
      'password' :temp2[2]
    }
    list.append(hash)
  return list

def solve_puzzle(input_list):
  sum = 0
  for k in input_list:
    char1 = k['password'][k['min'] - 1]
    char2 = k['password'][k['max'] - 1]
    temp = 0
    if(char1 == k['char']):
      temp += 1
    if(char2 == k['char']):
      temp += 1
    if(temp == 1):
      sum += 1


  return sum

with open('2_part_two_input.txt') as f:
  content = f.read().splitlines()

input_list = parse_input(content)
result = solve_puzzle(input_list)

print(result)
