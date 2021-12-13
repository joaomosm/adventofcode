require './../module_helpers.rb'

class Day12PartOne
  include Helpers

  class << self
    def run
      new.run
    end
  end

  def initialize
    @caves = {}
    @lines = read_input_chomp('12_input.txt').map do |line|
      key, value = line.split('-')
      if 'start' != value && 'end' != key
        add_path(key, value)
      end

      if 'start' != key && 'end' != value
        add_path(value, key)
      end
    end

  end

  def run
    count_paths('start', [])
  end

  def add_path(key, value)
    if @caves[key].nil?
      @caves[key] = [value]
    else
      @caves[key] << value
    end
  end

  def count_paths(current_node, visited_nodes)
    return 1 if current_node == 'end'
    return 0 if @caves[current_node].nil?
    
    result = @caves[current_node].map do |next_node|
      new_visited_nodes = visited_nodes.dup
      next if visited_nodes.include?(next_node)

      new_visited_nodes << next_node if is_small_cave?(next_node) 
      
      count_paths(next_node, new_visited_nodes)
    end.compact.sum
  end

  def is_small_cave?(cave)
    cave == cave.downcase
  end
end

puts Day12PartOne.run
