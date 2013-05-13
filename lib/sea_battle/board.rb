# encoding: utf-8

class SeaBattle
  # It's Board of game Sea Battle
  class Board
    def initialize(board)
      @board = board
      check_board
    end

  private

    # It should raise error when @board isn't Array
    def check_board
      raise "The board is not Array class" unless @board.class.eql?(Array)
    end

  end
end
