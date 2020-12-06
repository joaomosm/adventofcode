import re
import numpy as np

with open('6_part_one_input.txt') as f:
  content = f.read()

ASCII_OFFSET = 97

def parse_input(content):
  splitted = re.split('\n\n', content)
  forms = [splitted[i].replace('\n', '') for i in range(len(splitted))]
  return forms

def solve_puzzle(forms):
  array = np.zeros((len(forms),26))
  for i in range(len(forms)):
    for c in forms[i]:
      char_index = ord(c) - ASCII_OFFSET
      array[i][char_index] = 1

  return int(array.sum())

forms = parse_input(content)
result = solve_puzzle(forms)
print(result)
