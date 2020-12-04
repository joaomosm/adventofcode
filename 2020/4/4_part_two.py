import re

with open('4_part_two_input.txt') as f:
  content = f.read()

FIELDS = [
  'byr:[0-9a-z#]+',
  'iyr:[0-9a-z#]+',
  'eyr:[0-9a-z#]+',
  'hgt:[0-9a-z#]+',
  'hcl:[0-9a-z#]+',
  'ecl:[0-9a-z#]+',
  'pid:[0-9a-z#]+'
]

def is_byr_valid(value):
  return int(value) >= 1920 and int(value) <= 2002

def is_iyr_valid(value):
  return int(value) >= 2010 and int(value) <= 2020

def is_eyr_valid(value):
  return int(value) >= 2020 and int(value) <= 2030

def is_hgt_valid(value):
  if(len(value.split('cm')) == 2):
    return int(value.split('cm')[0]) >= 150 and int(value.split('cm')[0]) <= 193
  else:
    return int(value.split('in')[0]) >= 59 and int(value.split('in')[0]) <= 76

def is_hcl_valid(value):
  return bool(re.match('#[0-9a-f]{6}', value))

def is_ecl_valid(value):
  return value in ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth']

def is_pid_valid(value):
  return bool(re.match('^[0-9]{9}$', value))

def parse_input(content):
  splitted = re.split('\n\n', content)
  passports = [splitted[i].replace('\n', ' ') for i in range(len(splitted))]
  return passports

def solve_puzzle(passports):
  valid_passports = 0
  for p in passports:
    valid_fields = 0
    for f in FIELDS:
      fieldname = f[0:3]
      pattern = re.compile(f)
      match = pattern.search(p)
      if(bool(match) and globals()["is_{}_valid".format(fieldname)](match.group()[4:])):
        valid_fields += 1
    if(valid_fields == 7):
      valid_passports +=1
  return valid_passports


passports = parse_input(content)
result = solve_puzzle(passports)
print(result)
