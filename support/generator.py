import sys
import os


# --- Function Definitions ---
def read_arguments():
  args_len = len(sys.argv)

  if len(sys.argv) != 3:
    print 'Wrong number of arguments:', args_len - 1, 'intead of 2.'
    exit()
  # elif:
    # TODO: safely cast arguments

  puzzle_year = int(sys.argv[1])
  puzzle_day = int(sys.argv[2])
  print 'year number ->', puzzle_year,'and puzzle day ->', puzzle_day

  return puzzle_year, puzzle_day

def validate_arguments(puzzle_year, puzzle_day):
  print puzzle_year
  if puzzle_year < 2015 or puzzle_year > 2021:
    print 'Puzzle year must be between 2015 and 2021.'
    exit()
  elif puzzle_day < 1 or puzzle_day > 25:
    print 'Puzzle day must be between 1 and 25.'
    exit()
  # elif
    # TODO: prevent generating files already created

def generate_path_and_filenames(puzzle_year, puzzle_day):
  path = '{year}/{day}/'.format(year = puzzle_year, day = puzzle_day)
  filenames = [
    '{day}_answers.txt'.format(day = puzzle_day),
    '{day}_part_one_input.txt'.format(day = puzzle_day),
    '{day}_part_one.rb'.format(day = puzzle_day),
    '{day}_part_two_input.txt'.format(day = puzzle_day),
    '{day}_part_two.rb'.format(day = puzzle_day),
  ]
  try:
    os.mkdir(path)
  except OSError:
      print ("Creation of the directory %s failed" % path)
      exit()
  else:
      print ("Successfully created the directory %s " % path)

  return path, filenames

def create_file(path_and_filename, content):
  f = open(path_and_filename, 'w+')
  f.write(content)
  f.close


# --- Script ---
puzzle_year, puzzle_day = read_arguments()
validate_arguments(puzzle_year, puzzle_day)
path, filenames = generate_path_and_filenames(puzzle_year, puzzle_day)

# Create answers file
create_file(path + filenames[0], 'part_one = <answer_part_one>\npart_two = <answer_part_two>')

# Create part one input file
create_file(path + filenames[1], '')

# Create part one python file
create_file(path + filenames[2], '')

# Create part two input file
create_file(path + filenames[3], '')

# Create part two python file
create_file(path + filenames[4], '')

print 'Succefully generated ' + str(puzzle_year) + '.' + str(puzzle_day), 'files.'