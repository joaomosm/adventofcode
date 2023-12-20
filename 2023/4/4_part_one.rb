require './../module_helpers.rb'

class Day04PartOne
  include Helpers

  attr_reader :cards

  class << self
    def run
      new.run
    end
  end

  def initialize
    @cards = read_input_chomp('4_input.txt')
      .map { |line| Card.new(line) }
  end

  def run
    cards.inject(0) do |sum, card|
      sum + card.points
    end
  end

  class Card
    attr_reader :winning_numbers, :game_numbers

    def initialize(line)
      ignore_card_id_prefix = line.split(': ')[1]
      before_delimiter, after_delimiter = ignore_card_id_prefix.split(' | ')

      @winning_numbers = before_delimiter.split(' ')
      @game_numbers = after_delimiter.split(' ')
    end

    def points
      count = count_winning_numbers_occurences

      if count == 0
        return 0
      else
        return 2 ** (count - 1)
      end
    end

    private

    def count_winning_numbers_occurences
      winning_numbers.map do |winning_number|
        game_numbers.include?(winning_number)
      end.count(true)
    end
  end
end

puts Day04PartOne.run