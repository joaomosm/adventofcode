with open('1_part_one_input.txt') as f:
  content = f.read().splitlines()

result = 0
for c in content:
  try:
    diff = 2020 - int(c)
    index = content.index(str(diff))
    result = int(c) * int(content[index])
    break
  except ValueError:
    continue


print(result)
