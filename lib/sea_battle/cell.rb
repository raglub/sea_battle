# encoding: utf-8

class SeaBattle
  # It's Cell of Board
  class Cell

    attr_reader :status

    # status value:
    # 1 -> empty field
    # 2 -> field is part of ship
    # 4 -> attacked field
    # 8 -> is only selected by user
    #16 -> is sunk
    # 6 -> attacked field and exsist ship
    def initialize(status = 1)
      @status = status
    end

    def add_ship
      @status += 2 unless is_in_ship?
    end

    def attack
      @status += 4 unless is_attacked?
    end

    def sunk
      @status += 16 unless is_sunk?
    end

    def switch_select
      is_selected? ? @status -= 8 : @status += 8
    end

    def is_attacked?
      @status & 4 == 4
    end

    def is_empty?
      @status & 1 == 1
    end

    def is_in_ship?
      @status & 2 == 2
    end

    def is_selected?
      @status & 8 == 8
    end

    def is_sunk?
      @status & 16 == 16
    end

    def reset_cell
      @status = 1
    end
  end
end
