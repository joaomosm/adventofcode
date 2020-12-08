import re

MAIN_BAG_REGEX = '(\w+ \w+) bags? contain'
UNDER_BAG_REGEX = '(\d+) (\w+ \w+) bags?|(no other bags)'

with open('7_part_two_input.txt') as f:
  content = f.read().splitlines()

def parse_input(content):
  main_bag_pattern = re.compile(MAIN_BAG_REGEX)
  under_bag_pattern = re.compile(UNDER_BAG_REGEX)
  bags = {}
  for c in content:
    main_match = main_bag_pattern.search(c)
    under_match = under_bag_pattern.findall(c)
    under_bags = []
    for u in under_match:
      if(u[0] != ''):
        under_bags.append((int(u[0]), u[1]))
      else:
        under_bags = ''
    
    bags[main_match.group(1)] = under_bags
  return bags

def solve_puzzle(bags, key):
  under_bags = bags[key]
  if(under_bags == ''):
    return 0
  else:
    partial_result = 0
    for u in under_bags:
      partial_result += u[0] + u[0] * solve_puzzle(bags, u[1])
    return partial_result

bags = parse_input(content)
result = solve_puzzle(bags, 'shiny gold')
print(result)
