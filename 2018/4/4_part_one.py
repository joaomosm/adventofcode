import datetime
import numpy as np

def parse_input(content):
  list = []
  guard_id = -1
  for c in content:
    temp = c.split('] ')
    timestamp = temp[0].split('[')[1]
    parsed_timestamp = datetime.datetime.strptime(timestamp, '%Y-%m-%d %H:%M')
    sentence_words = temp[1].split(' ')
    if sentence_words[0] == 'falls':
      # print 'falls asleep'
      action = 'falls_asleep'
    elif sentence_words[0] == 'wakes':
      # print 'wakes up'
      action = 'wakes_up'
    else:
      guard_id = sentence_words[1].split('#')[1]
      # print 'is Guard'
      action = 'new_guard'

    hash = {
      'timestamp': parsed_timestamp,
      'action': action,
      'guard_id': guard_id
    }
    list.append(hash)
  return list

def populate_row(matrix, row, start_column, end_column):
  i = start_column
  while(i < end_column):
    matrix[row][i] = '#'
    i += 1

def populate_matrix(input_list):
  first = input_list[0]
  last = input_list[-1]
  diff = (last['timestamp'] - first['timestamp']).days
  matrix = np.chararray((diff + 1, 60))
  matrix[:] = '.'
  guard_presences = np.zeros(diff + 1)
  day = -1

  for i in input_list:
    print i
    if i['action'] == 'new_guard':
      day += 1
      prev_guard_id = i['guard_id']
      guard_presences[day] = prev_guard_id
      if int(i['timestamp'].hour) == 0:
        prev_time = int(i['timestamp'].minute)
      else:
        prev_time = 0
      print "new guard with ", prev_guard_id, prev_time
    elif i['action'] == 'wakes_up':
      curr_time = int(i['timestamp'].minute)
      print "will populate with # from ", prev_time, curr_time
      populate_row(matrix, day, prev_time, curr_time)
    else:
      prev_time = i['timestamp'].minute
      print "sleep again with ", prev_guard_id, prev_time

  return matrix, guard_presences

def solve_puzzle(matrix, guard_presences):
  guard_ids = np.unique(guard_presences)
  occurrences_matrix = np.zeros((len(guard_ids), 60))
  result = [0, 0]

  for i in range(len(matrix)):
    for j in range(60):
      # print i, ", ", j, matrix[i][j], matrix[i][j] == '#'
      if matrix[i][j] == '#':
        guard_id = int(guard_presences[i])
        temp = np.where(guard_ids == guard_id)
        guard_index = temp[0][0]
        occurrences_matrix[guard_index][j] += 1
        # print 'was guard', guard_id, guard_index, result[1], occurrences_matrix[guard_index][j]
        if result[1] < occurrences_matrix[guard_index][j]:
          result[0] = guard_id
          result[1] = occurrences_matrix[guard_index][j]

  # print occurrences_matrix
  sleeping_guard_id = 0
  most_minutes_slept = 0
  top_minute = -1
  top_minute_index = -1
  for i in range(len(occurrences_matrix)):
    minutes_slept = np.count_nonzero(occurrences_matrix[i])
    if most_minutes_slept <  minutes_slept:
      most_minutes_slept = minutes_slept
      sleeping_guard_id = guard_ids[i]
      top_minute = np.max(occurrences_matrix[i])
      top_minute_index = int(np.where(occurrences_matrix[i] == top_minute)[0][0])

  print sleeping_guard_id
  # print most_minutes_slept
  # print top_minute
  print top_minute_index

  return int(sleeping_guard_id * top_minute_index)


with open('4_part_one_input.txt') as f:
  content = f.read().splitlines()

content.sort()
input_list = parse_input(content)
matrix, guard_presences = populate_matrix(input_list)
print guard_presences
# result = solve_puzzle(matrix, guard_presences)

# print matrix
# print guard_presences
# print result
