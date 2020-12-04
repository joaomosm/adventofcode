def parse_input(content):
  list = []
  for c in content:
    temp1 = c.split("-")
    temp2 = temp1[1].split(" ")
    temp3 = temp2[1].split(":")

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
    count = k['password'].count(k['char'])
    if(count >= k['min'] and count <= k['max']):
      sum += 1


  return sum

with open('2_part_one_input.txt') as f:
  content = f.read().splitlines()

input_list = parse_input(content)
result = solve_puzzle(input_list)

print(result)
