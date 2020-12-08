import re

MAIN_BAG_REGEX = '(\w+ \w+) bags? contain'
UNDER_BAG_REGEX = '\d+ (\w+ \w+) bags?|(no other bags)'

with open('7_part_one_input.txt') as f:
  content = f.read().splitlines()

def parse_input(content):
  main_bag_pattern = re.compile(MAIN_BAG_REGEX)
  under_bag_pattern = re.compile(UNDER_BAG_REGEX)
  bags = {}
  for c in content:
    main_match = main_bag_pattern.search(c)
    under_match = under_bag_pattern.findall(c)
    bags[main_match.group(1)] = [u[0] for u in under_match]
  return bags

def solve_puzzle(bags, key):
  if(key == ''):
    return 0
  if('shiny gold' in bags[key]):
    return 1
  else:
    partial_result = 0
    for under_bag in bags[key]:
      partial_result += solve_puzzle(bags, under_bag)
    return partial_result

bags = parse_input(content)
result = 0
for bag in bags:
  if(solve_puzzle(bags, bag) > 0):
    result += 1
print(result)