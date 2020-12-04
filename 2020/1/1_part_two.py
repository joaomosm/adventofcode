with open('1_part_two_input.txt') as f:
  content = f.read().splitlines()

result = 0
i = 0
while i < len(content):
  j = i + 1
  diff1 = 2020 - int(content[i])
  while j < len(content[i:]):
    diff2 = diff1 - int(content[j])
    try:
      index = content.index(str(diff2))
      result = int(content[i]) * int(content[j]) * int(content[index])
      break
    except ValueError:
      j += 1
      continue
  i += 1


print(result)
