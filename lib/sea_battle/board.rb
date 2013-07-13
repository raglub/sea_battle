# encoding: utf-8

require_relative "cell"
require_relative "random_ship"

class SeaBattle
  # It's Board of game Sea Battle
  class Board

    attr_reader :board, :vertical, :horizontal

    def initialize(board = "1" * 100)
      @board = board.split("").map do |status|
        Cell.new(status.to_i)
      end.each_slice(10).to_a
      @horizontal = 10
      @vertical = 10

      @quantity_ships = {1 => 4, 2 => 3, 3 => 2, 4 => 1}
      check_board
    end

    def attack(row, column)
      board[row][column].attack
    end

    # Set ships on the board (random positions)
    def random_ships
      [1, 1, 1, 1, 2, 2, 2, 3, 3, 4].each do |length|
        RandomShip.new(self, length).add_ship
      end
    end

    # Return array of position ship if it will be on position [row, column]
    def ship_positions(row, column)
      horizontal = horizontal_ship_position(row, column)
      vertical = vertical_ship_position(row, column)
      return horizontal if horizontal.size > vertical.size
      vertical
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
        if @board[position][column].is_in_ship?
          result << [position, column]
        else
          break if result.include?([row, column])
          result = []
        end
      end
      result
    end

    # it should return array of ship position
    # for vertical line with position [row, column]
    def vertical_ship_position(row, column)
      result = []
      10.times do |position|
        if @board[row][position].is_in_ship?
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
