require './../module_helpers.rb'

class Day04PartTwo
  include Helpers

  attr_reader :cards, :winning_games_per_card, :times_to_play_per_card

  class << self
    def run
      new.run
    end
  end

  def initialize
    @cards = read_input_chomp('4_input.txt')
      .map { |line| Card.new(line) }
    @winning_games_per_card = Array.new(cards.size, -1)
    @times_to_play_per_card = Array.new(cards.size, 1)
  end

  def run
    results = []

    cards.each_with_index do |card, index|
      card.number_of_repeated_cards.times do |i|
        winning_games = card.total_winning_numbers

        winning_games.times do |j|
          cards[index + j + 1].number_of_repeated_cards += 1
        end
      end

      results << card.number_of_repeated_cards
    end

    results.sum
  end

  class Card
    attr_accessor :winning_numbers, :game_numbers, :total_winning_numbers, :number_of_repeated_cards

    def initialize(line)
      ignore_card_id_prefix = line.split(': ')[1]
      before_delimiter, after_delimiter = ignore_card_id_prefix.split(' | ')

      @winning_numbers = before_delimiter.split(' ')
      @game_numbers = after_delimiter.split(' ')

      @total_winning_numbers = count_winning_numbers_occurences
      @number_of_repeated_cards = 1
    end

    def count_winning_numbers_occurences
      winning_numbers.map do |winning_number|
        game_numbers.include?(winning_number)
      end.count(true)
    end
  end
end

puts Day04PartTwo.run