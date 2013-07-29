# encoding: utf-8

require_relative "support"

class SeaBattle
  # It's random positions for new ship
  class RandomShip
    include ::SeaBattle::Support

    def initialize(board, length = 1)
      @board = board.board
      @length = length
      @horizontal = board.horizontal
      @vertical = board.vertical
    end

    # Add new Ship on board
    def add_ship
      if Random.rand(2) == 0
        return if add_ship_of(:vertical)
        return if add_ship_of(:horizontal)
      else
        return if add_ship_of(:horizontal)
        return if add_ship_of(:vertical)
      end
    end

    def ship_positions(row, column, direct)
      result = []

      @length.times do |offset|
        if direct.eql?(:vertical)
          result << [row + offset, column] if row + offset < @vertical
        else
          result << [row, column + offset] if column + offset < @horizontal
        end
      end
      result
    end

    def area_ship_positions(row, column, direct)
      result = []
      first_row = row - 1
      first_column = column - 1

      last_row, last_column = row + 1, column + 1
      last_row += @length - 1 if direct.eql?(:vertical)
      last_column += @length - 1 if direct.eql?(:horizontal)

      vertical_range = (first_row..last_row).to_a & (0...@vertical).to_a
      horizontal_range = (first_column..last_column).to_a & (0...@horizontal).to_a
      vertical_range.product(horizontal_range)
    end

    def add_ship_of(direct)
      mixed_board_positions.each do |row, column|
        next if direct.eql?(:vertical) and row + @length - 1 >= @vertical
        next if direct.eql?(:horizontal) and column + @length - 1 >= @horizontal

        if is_area_empty?(row, column, direct)
          positions = ship_positions(row, column, direct)
          positions.map do |row, column|
            @board[row][column].add_ship
          end
          return positions
        end
      end
      nil
    end

    def is_area_empty?(row, column, direct)
      area_ship_positions(row, column, direct).each do |row_index, column_index|
        return false if @board[row_index][column_index].is_in_ship?
      end
      true
    end

  end
end
