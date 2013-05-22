# encoding: utf-8

class SeaBattle
  # It's Board of game Sea Battle
  class Board

    attr_reader :board
    # board
    # 1 -> empty field
    # 2 -> field is part of ship
    # 4 -> attacked field
    # 6 -> attacked field and exsist ship
    def initialize(board = "0"*100)
      @board = board.split("").map(&:to_i).each_slice(10).to_a
      @quantity_ships = {1 => 4, 2 => 3, 3 => 2, 4 => 1}
      check_board
    end

    def ship_positions(row, column)
      horizontal = horizontal_ship_position(row, column)
      vertical = vertical_ship_position(row, column)
      return horizontal if horizontal.size > vertical.size
      vertical
    end

    def attack(row, column)
      true
    end

  private

    # It should raise error when @board isn't Array
    def check_board
      raise "The board is not Array class" unless @board.size == 10
    end

    # it should return array of ship position
    # for horizontal line with position [row, column]
    def horizontal_ship_position(row, column)
      result = []
      10.times do |position|
        if is_ship?(position, column)
          result << [position, column]
        else
          break if result.include?([row, column])
          result = []
        end
      end
      result
    end

    def is_ship?(row, column)
      @board[row][column] & 2 == 2
    end

    # it should return array of ship position
    # for vertical line with position [row, column]
    def vertical_ship_position(row, column)
      result = []
      10.times do |position|
        if is_ship?(row, position)
          result << [row, position]
        else
          break if result.include?([row, column])
          result = []
        end
      end
      result
    end

  end
end
