with open('3_part_two_input.txt') as f:
  content = f.read().splitlines()

result = 1
def count_trees(content, step_right, step_down):
  sum = 0
  pattern_length = len(content[0])
  for i in range(0, len(content), step_down):
    if i == 0:
      continue

    if content[i][(int(i / step_down) * step_right) % pattern_length] == '#':
      sum += 1
  return sum


tupples = [(1,1), (3,1), (5,1), (7,1), (1,2)]
for i in range(len(tupples)):
  result *= count_trees(content, tupples[i][0], tupples[i][1])

print(result)
