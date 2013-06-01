# encoding: utf-8

require_relative "cell"

class SeaBattle
  # It's Board of game Sea Battle
  class Board

    attr_reader :board

    def initialize(board = "1" * 100)
      @board = board.split("").map do |status|
        Cell.new(status.to_i)
      end.each_slice(10).to_a
      @horizontal = 10
      @vertical = 10

      @quantity_ships = {1 => 4, 2 => 3, 3 => 2, 4 => 1}
      check_board
    end

    def add_random_ship(length)
      if Random.rand(2) == 0
        add_random_vertical_ship(length)
      else
        add_random_vertical_ship(length)
      end
    end

    def ship_positions(row, column)
      horizontal = horizontal_ship_position(row, column)
      vertical = vertical_ship_position(row, column)
      return horizontal if horizontal.size > vertical.size
      vertical
    end

  private

    def add_random_vertical_ship(length)
      position = Random.rand(@horizontal * @vertical)
      (@horizontal * @vertical).times do |item|
        if pair_with(position).first + length < @vertical
          unless is_block_empty?(
            pair_with(position).first - 1,
            pair_with(position).last - 1,
            pair_with(position).first + (length - 1) + 1,
            pair_with(position).last + 1
          )
            length.times do |offset|
              p "bbb"
              @board[pair_with(position).first + offset][pair_with(position).last].add_ship
              return true
            end
          end
        end
      end
      nil
    end

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

    def is_block_empty?(x1, y1, x2, y2)
      vertical_range = (x1..x2).to_a & (0..@vertical).to_a
      horizontal_range = (y1..y2).to_a & (0..@horizontal).to_a
      vertical_range.each do |vertical|
        horizontal_range.each do |horizontal|
          return false if @board[vertical][horizontal].is_in_ship?
        end
      end
      true
    end

    def pair_with(position)
      @ordered_pairs ||= generate_ordered_pairs
      @ordered_pairs[position]
    end

    def generate_ordered_pairs
      result = {}
      (0...@vertical).to_a.product(
        (0...@horizontal).to_a
      ).each_with_index do |array, index|
        result[index] = array
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
