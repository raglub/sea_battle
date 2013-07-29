# encoding: utf-8

class SeaBattle
  # Common methods
  module Support

    def mixed_board_positions
      offset = Random.rand(@horizontal * @vertical)
      (0...@vertical).to_a.product(
        (0...@horizontal).to_a
      ).rotate(offset)
    end

  end
end
