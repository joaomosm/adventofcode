import re

with open('4_part_one_input.txt') as f:
  content = f.read()

FIELDS = [
  'byr:',
  'iyr:',
  'eyr:',
  'hgt:',
  'hcl:',
  'ecl:',
  'pid:'
]

def parse_input(content):
  splitted = re.split('\n\n', content)
  passports = [splitted[i].replace('\n', ' ') for i in range(len(splitted))]
  return passports

def solve_puzzle(passports):
  valid_passports = 0
  for p in passports:
    valid_fields = 0
    for f in FIELDS:
      pattern = re.compile(f)
      if(pattern.search(p)):
        valid_fields += 1
    if(valid_fields == 7):
      valid_passports +=1
  return valid_passports


passports = parse_input(content)
result = solve_puzzle(passports)
print(result)
