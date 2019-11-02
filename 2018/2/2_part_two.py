def unique_characters(content):
  for i, c in enumerate(content):
    j = i + 1
    while(j < len(content)):
      diff = diff_characters(c, content[j])
      if((len(diff) + 1) == len(c)):
        return diff
      j += 1

def diff_characters(string1, string2):
  i = 0
  result = ''
  while(i < len(string1)):
    if(string1[i] == string2[i]):
      result += string1[i]
    i += 1
  return result

with open('2_part_two_input.txt') as f:
  content = f.read().splitlines()

print unique_characters(content)
