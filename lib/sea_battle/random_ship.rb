# encoding: utf-8


class SeaBattle
  # It's random positions for new ship
  class RandomShip

    def initialize(board, length = 1)
      @board = board.board
      @length = length
      @horizontal = board.horizontal
      @vertical = board.vertical
    end

    # Add new Ship on board
    def add
      if Random.rand(2) == 0
       return if add_vertical
       return if add_horizontal
      else
       return if add_horizontal
       return if add_vertical
      end
    end

    def ship_positions(row, column, direct)
      result = []

      @length.times do |offset|
        if direct
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
      if direct
        last_row += @length - 1
      else
        last_column += @length - 1
      end

      vertical_range = (first_row..last_row).to_a & (0..@vertical).to_a
      horizontal_range = (first_column..last_column).to_a & (0..@horizontal).to_a
      vertical_range.product(horizontal_range)
    end

    def mixed_board_positions
      offset = Random.rand(@horizontal * @vertical)
      (0...@vertical).to_a.product((0...@horizontal).to_a).rotate(offset)
    end

    def add_vertical
      mixed_board_positions.each do |row, column|
        if row + @length < @vertical
          if is_area_empty?(row, column, true)
            positions = ship_positions(row, column, true)
            positions.map do |row, column|
              @board[row][column].add_ship
            end
            return positions
          end
        end
      end
      nil
    end

    def add_horizontal
      mixed_board_positions.each do |row, column|
        if column + @length < @horizontal
          if is_area_empty?(row, column, false)
            positions = ship_positions(row, column, false)
            positions.map do |row, column|
              @board[row][column].add_ship
            end
            return positions
          end
        end
      end
      nil
    end

    def is_area_empty?(row, column, direct)
      area_ship_positions(row, column, direct).each do |row, column|
        return false if @board[row][column].is_in_ship?
      end
      true
    end

  end
end
