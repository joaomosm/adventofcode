require './../module_helpers.rb'

class Day10PartTwo
  include Helpers

  CHUNK_MAPPINGS = {
    '(' => ')',
    '[' => ']',
    '{' => '}',
    '<' => '>'
  }.freeze

  CHUNK_POINTS = {
    ')' => 1,
    ']' => 2,
    '}' => 3,
    '>' => 4
  }.freeze

  class << self
    def run
      new.run
    end
  end

  def initialize
    @lines = read_input_chomp('10_input.txt')
      .map { |line| line.split('') }
    
    @incomplete_lines = [] 
  end

  def run
    @lines.each { |line| analyse_line(line) }

    middle_score
  end

  def analyse_line(line)
    queue = []
    illegal = false
    
    line.each do |char|
      illegal = false
      if is_opening_char?(char)
        queue << char
      elsif queue.size.positive? && CHUNK_MAPPINGS[queue.last] == char
        queue.pop
      elsif queue.size.positive? && CHUNK_MAPPINGS[queue.last] != char
        illegal = true
        break
      end
    end

    @incomplete_lines << missing_chars(queue) if queue.size.positive? && !illegal
  end

  def middle_score
    scores = @incomplete_lines.map{ |line| calculate_line_points(line) }.sort

    scores[scores.size / 2]
  end

  def calculate_line_points(line)
    line.inject(0) do |sum, char|
      sum = (sum * 5) + CHUNK_POINTS[char]
    end
  end

  def missing_chars(queue)
    queue.map{ |char| CHUNK_MAPPINGS[char] }.reverse
  end

  def is_opening_char?(char)
    CHUNK_MAPPINGS.keys.include?(char)
  end

end

puts Day10PartTwo.run
