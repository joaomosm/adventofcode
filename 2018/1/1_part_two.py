with open('1_part_two_input.txt') as f:
  content = f.read().splitlines()

my_sum = 0
in_loop = True
my_list = []
while in_loop:
  for c in content:
    my_sum += int(c)
    if my_sum not in my_list:
      my_list.append(my_sum)
    else:
      in_loop = False
      break


print my_sum
