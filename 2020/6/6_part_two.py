import re
import numpy as np

with open('6_part_two_input.txt') as f:
  content = f.read()

ASCII_OFFSET = 97

def parse_input(content):
  splitted = re.split('\n\n', content)
  people_per_group = [len(splitted[i].split('\n')) for i in range(len(splitted))]
  forms = [splitted[i].replace('\n', '') for i in range(len(splitted))]
  return forms, people_per_group

def solve_puzzle(forms, people_per_group):
  array = np.zeros((len(forms),26))
  for i in range(len(forms)):
    for c in forms[i]:
      char_index = ord(c) - ASCII_OFFSET
      array[i][char_index] += 1

  result = 0
  for i in range(len(array)):
    result += np.count_nonzero(array[i] == people_per_group[i])
  return result

forms, people_per_group = parse_input(content)
result = solve_puzzle(forms, people_per_group)
print(result)
