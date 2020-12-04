with open('3_part_one_input.txt') as f:
  content = f.read().splitlines()

result = 0
pattern_length = len(content[0])
for i in range(len(content)):
  if i == 0:
    continue

  if content[i][(i * 3) % pattern_length] == '#':
    result += 1

print(result)
