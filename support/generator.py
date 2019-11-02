import sys
import os

args_len = len(sys.argv)

if len(sys.argv) != 3:
  print 'Wrong number of arguments (', args_len - 1, 'intead of 2).'
# elif:
  # TODO: safely cast arguments

puzzle_year = int(sys.argv[1])
puzzle_day = int(sys.argv[2])

print 'year number ->', puzzle_year,'and puzzle day ->', puzzle_day

if puzzle_year < 2015 or puzzle_year > 2019:
  print 'Puzzle year must be between 2015 and 2019.'
elif puzzle_day < 1 or puzzle_day > 25:
  print 'Puzzle day must be between 1 and 25.'
# elif
  # TODO: prevent generating files already created

path = '{year}/{day}/'.format(year = puzzle_year, day = puzzle_day)
filenames = [
  '{day}_answers.txt'.format(day = puzzle_day),
  '{day}_part_one_input.txt'.format(day = puzzle_day),
  '{day}_part_one.py'.format(day = puzzle_day),
  '{day}_part_two_input.txt'.format(day = puzzle_day),
  '{day}_part_two.py'.format(day = puzzle_day),
]

try:
    os.mkdir(path)
except OSError:
    print ("Creation of the directory %s failed" % path)
else:
    print ("Successfully created the directory %s " % path)

# Create answers file
f0 = open(path + filenames[0],"w+")
f0.write('part_one = <answer_part_one>\npart_two = <answer_part_two>')
f0.close

# Create part one input file
f1 = open(path + filenames[1],"w+")
f1.close

# Create part one python file
f2 = open(path + filenames[2],"w+")
f2.close

# Create part two input file
f3 = open(path + filenames[3],"w+")
f3.close

# Create part two python file
f4 = open(path + filenames[4],"w+")
f4.close
