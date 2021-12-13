require './../module_helpers.rb'

class Day12PartTwo
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
    count_paths('start', [], nil)
  end

  def add_path(key, value)
    if @caves[key].nil?
      @caves[key] = [value]
    else
      @caves[key] << value
    end
  end

  def count_paths(current_node, visited_nodes, single_cave)
    return 1 if current_node == 'end'
    return 0 if @caves[current_node].nil?
    
    result = @caves[current_node].map do |next_node|
      new_visited_nodes = visited_nodes.dup
      new_single_cave = single_cave.dup

      next if already_visited?(next_node, visited_nodes, single_cave)

      if is_small_cave?(next_node)
        new_single_cave = next_node if new_single_cave.nil? && visited_nodes.include?(next_node)
        new_visited_nodes << next_node
      end
      
      count_paths(next_node, new_visited_nodes, new_single_cave)
    end.compact.sum
  end

  def is_small_cave?(cave)
    cave == cave.downcase
  end

  def already_visited?(next_node, visited_nodes, single_cave)
    return false unless single_cave

    visited_nodes.include?(next_node)
  end
end

puts Day12PartTwo.run
