with open('10_part_one_input.txt') as f:
  content = f.read().splitlines()

def parse_input(content):
  array = []
  for c in content:
    array.append(int(c))

  array.sort()
  return array

def solve_puzzle(array):
  joltage_diffs = [0, 0, 0]
  last_jolt = 0
  for i in array:
    jolt_diff = i - last_jolt
    joltage_diffs[jolt_diff - 1] += 1
    last_jolt = i
  return joltage_diffs[0] * (joltage_diffs[2] + 1)


array = parse_input(content)
result = solve_puzzle(array)
print(result)