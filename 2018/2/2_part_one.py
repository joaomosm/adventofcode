def duos_and_trios(string):
  duo = False
  trio = False
  for c in string:
    char_count = string.count(c)
    if char_count == 2:
      duo = True
    elif char_count == 3:
      trio = True
  return duo, trio

with open('2_part_one_input.txt') as f:
  content = f.read().splitlines()

duos = 0
trios = 0

for c in content:
  duo, trio = duos_and_trios(c)
  duos += int(duo)
  trios += int(trio)

print duos * trios
