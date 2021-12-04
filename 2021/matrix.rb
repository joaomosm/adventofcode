class Matrix
  def initialize
    @numbers = []
    @occurrences = []
    @build_completed = false
  end

  def add_row(row)
    @numbers << row.split(' ').map { |num| num.to_i }
  end

  def build_occurrences
    @x = @numbers.count
    @y = @numbers.first.count
    @occurrences = Array.new(@x) { Array.new(@y, 0) }
    @build_completed = true
  end

  def is_built?
    @build_completed
  end

  def is_winner?
    @occurrences.each { |row| return true if row.sum == 5 }

    @occurrences.first.size.times do |index|
      return true if @occurrences.map { |row| row[index] }.sum == 5
    end

    return false
  end

  def mark_number(new_number)
    @numbers.each_with_index do |row, i|
      j = row.find_index(new_number)

      if !j.nil?
        @occurrences[i][j] = 1 unless j.nil?
        return 
      end
    end
  end

  def sum_unmarked_numbers
    sum = 0

    @occurrences.each_with_index do |row, i|
      row.each_with_index do |element, j|
        sum += @numbers[i][j] if element == 0
      end
    end

    return sum
  end
end
