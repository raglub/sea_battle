# encoding: utf-8

require "sea_battle"

describe SeaBattle do

  let(:board) { SeaBattle::Board }

  it "should properly initialize class" do
    expect { SeaBattle.new(board.new, board.new) }.to_not raise_error
  end

  it "should not attack player one if game isn't active" do
    board_zero = board.new("1"*100, :prepare)
    board_one = board.new("1"*100, :prepare)
    sea_battle = SeaBattle.new(board_zero, board_one, nil)
    sea_battle.attack(0, 2, 1)
    sea_battle.last_move.should eq(nil)
  end

  context "for active game (first move)" do
    let(:board_zero) { board.new("2"*100, :active) }
    let(:board_one) { board.new("2"*100, :active) }
    let(:sea_battle) { SeaBattle.new(board_zero, board_one, nil) }

    it "should properly attack second player" do
      sea_battle.attack(1, 1, 2)
      sea_battle.last_move.should eql("1;1;2")
    end

    it "shouldn't properly attack first player" do
      sea_battle.attack(0, 1, 2)
      sea_battle.last_move.should eql(nil)
    end
  end
end
