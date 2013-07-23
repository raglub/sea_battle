require "sea_battle/version"
require "sea_battle/board"
require "sea_battle/gui"

class SeaBattle

  attr_reader :last_move

  def initialize(board_zero, board_one, last_move = nil)
    @last_move = last_move
    @board_zero = board_zero
    @board_one = board_one
  end

  def attack(player, row, column)
    return unless status_zero.eql?(:active) and status_one.eql?(:active)
    return if player == 0 and last_move == nil
    @last_move = [player, row, column].join(";")
  end

  private

    def status_zero
      @board_zero.status
    end

    def status_one
      @board_one.status
    end

end
