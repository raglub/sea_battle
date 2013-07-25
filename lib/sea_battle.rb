require "sea_battle/version"
require "sea_battle/board"
require "sea_battle/gui"

class SeaBattle

  def initialize(first_board, second_board, last_attack_move = nil)
    @last_attack_move = last_attack_move.split(";") unless last_attack_move.nil?
    @first_board = first_board
    @second_board = second_board
  end

  def active_user
    return :first_player if @last_attack_move.nil?
    player, row, column = @last_attack_move
    if player.to_sym == :first_player
      if @second_board.is_in_ship?(row.to_i, column.to_i)
        return :first_player
      else
        return :second_player
      end
    else
      if @first_board.is_in_ship?(row.to_i, column.to_i)
        return :second_player
      else
        return :first_player
      end
    end
  end

  def last_attack_move
    return if @last_attack_move.nil?
    @last_attack_move.join(";")
  end

  def move(player, type, row, column)
    return false unless [:first_player, :second_player].include?(player)
    return false unless [:choose, :attack, :mark].include?(type)

    case type
    when :attack
      return false unless active_user == player
      return false unless first_status.eql?(:activated) and second_status.eql?(:activated)
      if player == :first_player
        @second_board.attack(row, column)
      else
        @first_board.attack(row, column)
      end
      @last_attack_move = [player, row, column]
    else
    end
    true
  end

  private

    def first_status
      @first_board.status
    end

    def second_status
      @second_board.status
    end

end
