# encoding: utf-8

require_relative "cell"
require_relative "random_ship"
require_relative "support"

class SeaBattle
  # It's Board of game Sea Battle
  class Board
    include ::SeaBattle::Support

    attr_reader :board, :vertical, :horizontal, :status

    def initialize(board = "1" * 100, status = :initialized)
      @board = board.split("").map do |status|
        Cell.new(status.to_i)
      end.each_slice(10).to_a
      @horizontal = 10
      @vertical = 10

      @status = status
      check_board
    end

    def activated_board
      @status = :activated
    end

    def attack(row, column)
      if @status == :activated
        board[row][column].attack
        is_sunken_ship?(row, column)
        is_finished?
      end
    end

    def is_attacked?(row, column)
      board[row][column].is_attacked?
    end

    def is_in_ship?(row, column)
      board[row][column].is_in_ship?
    end

    # Return true if on position (row, column) is the ship which is sunked
    # Return false if on position (row, column) is not the ship which is sunked
    # or don't exist the ship
    def is_sunken_ship?(row, column)
      positions = ship_positions(row, column)
      return false if positions.empty?
      is_sunk = true
      positions.each do |position_row, position_column|
        is_sunk = false unless board[position_row][position_column].is_attacked?
      end
      if is_sunk
        positions.each do |position_row, position_column|
          board[position_row][position_column].sunk
        end
      end
      is_sunk
    end

    # Return position to attack (have not attacked)
    def random_position
      mixed_board_positions.each do |row, column|
        return [row, column] unless is_attacked?(row, column)
      end
    end

    # Set ships on the board (random positions)
    def random_ships
      return unless @status == :initialized
      reset_board
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

    def is_finished?
      is_finished = true
      board.each do |line|
        line.each do |cell|
          is_finished = false if cell.is_in_ship? and not cell.is_sunk?
        end
      end
      @status = :finished if is_finished
      is_finished
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

    def reset_board
      board.each do |line|
        line.each do |cell|
          cell.reset_cell
        end
      end
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
