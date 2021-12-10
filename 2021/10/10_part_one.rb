require './../module_helpers.rb'

class Day10PartOne
  include Helpers

  CHUNK_MAPPINGS = {
    '(' => ')',
    '[' => ']',
    '{' => '}',
    '<' => '>'
  }.freeze

  CHUNK_POINTS = {
    ')' => 3,
    ']' => 57,
    '}' => 1197,
    '>' => 25137
  }.freeze

  class << self
    def run
      new.run
    end
  end

  def initialize
    @lines = read_input_chomp('10_input.txt')
      .map { |line| line.split('') }
  end

  def run
    illegals = []
    @lines.each do |line|
      queue = []
      line.each do |char|
        if is_opening_char?(char)
          queue << char
        elsif queue.size.positive? && CHUNK_MAPPINGS[queue.last] == char
          queue.pop
        elsif queue.size.positive? && CHUNK_MAPPINGS[queue.last] != char
          illegals << char
          break
        end

      end
    end

    illegals.map{|char| CHUNK_POINTS[char]}.sum
  end

  def is_opening_char?(char)
    CHUNK_MAPPINGS.keys.include?(char)
  end

end

puts Day10PartOne.run
