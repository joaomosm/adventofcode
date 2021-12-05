require './../module_helpers.rb'

class Day05PartTwo
  include Helpers

  MAX_HEIGHT = 1000.freeze
  MAX_WIDTH = 1000.freeze

  class << self
    def run
      new.run
    end
  end

  def initialize
    @raw_lines = read_input_chomp('5_input.txt').map{ |line| line.split(' -> ') }
    @lines = create_line_points
    @occurrences = Array.new(MAX_HEIGHT) { Array.new(MAX_WIDTH, 0) }
  end

  def run
    populate_matrix
  end

  def create_line_points
    @raw_lines.map do |line|
      Line.new(Point.new(line.first), Point.new(line.last))
    end
  end

  def populate_matrix
    @lines.each do |line|
      line.cover_points.each do |cover_point|
        @occurrences[cover_point.x][cover_point.y] += 1
      end
    end

    sum = 0
    @occurrences.each do |row|
      sum += row.count{ |num| num >= 2 }
    end

    sum
  end


  class Point
    attr_reader :x, :y
  
    def initialize(string)
      @x, @y = string.split(",").map(&:to_i)
    end

    def to_s
      inspect
    end

    def inspect
      "(#{@x}, #{@y})"
    end
  end

  class Line
    attr_reader :starting_point, :ending_point, :cover_points

    def initialize(starting_point, ending_point)
      @starting_point = starting_point
      @ending_point = ending_point
      @cover_points ||= generate_cover_points
    end

    def horizontal?
      @starting_point.y == @ending_point.y
    end

    def vertical?
      @starting_point.x == @ending_point.x
    end

    def diagonal?
      !horizontal? && !vertical?
    end

    def generate_cover_points
      return horizontal_cover_points if horizontal?
      return vertical_cover_points if vertical?
      return diagonal_cover_points if diagonal?

      []
    end

    def horizontal_cover_points
      range(@starting_point.x, @ending_point.x).to_a.map do |i|
        point_string = "#{i},#{@starting_point.y}"
        Point.new(point_string)
      end
    end

    def vertical_cover_points
      range(@starting_point.y, @ending_point.y).to_a.map do |j|
        point_string = "#{@starting_point.x},#{j}"
        Point.new(point_string)
      end
    end

    def diagonal_cover_points
      if @starting_point.x < @ending_point.x && @starting_point.y < @ending_point.y
        increasing_diagonal_cover_points
      elsif @starting_point.x > @ending_point.x && @starting_point.y > @ending_point.y
        increasing_diagonal_cover_points
      else
        decreasing_diagonal_cover_points
      end
    end

    def increasing_diagonal_cover_points
      diagonal_starting_point, diagonal_ending_point = if @starting_point.x < @ending_point.x
        [@starting_point, @ending_point]
      else
        [@ending_point, @starting_point]
      end

      [].tap do |cover_points|
        (diagonal_ending_point.x - diagonal_starting_point.x + 1).times do |i|
          point_string = "#{diagonal_starting_point.x + i},#{diagonal_starting_point.y + i}"
          cover_points << Point.new(point_string)
        end
      end
    end

    def decreasing_diagonal_cover_points
      diagonal_starting_point, diagonal_ending_point = if @starting_point.x < @ending_point.x
        [@starting_point, @ending_point]
      else
        [@ending_point, @starting_point]
      end

      [].tap do |cover_points|
        (diagonal_ending_point.x - diagonal_starting_point.x + 1).times do |i|
          point_string = "#{diagonal_starting_point.x + i},#{diagonal_starting_point.y - i}"
          cover_points << Point.new(point_string)
        end
      end
    end

    def range(ord_a, ord_b)
      return Range.new(ord_a, ord_b) if ord_a < ord_b

      Range.new(ord_b, ord_a)
    end
  end
end

puts Day05PartTwo.run
