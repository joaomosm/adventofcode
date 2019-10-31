with open('1_part_one_input.txt') as f:
  content = f.read().splitlines()

sum = 0
for c in content:
	sum += int(c)

print sum
