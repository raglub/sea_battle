# encoding: utf-8

require "sea_battle"
describe SeaBattle::Board do

  let(:klass) { SeaBattle::Board }

  it "should properly initialize class" do
    expect { SeaBattle::Board.new }.to_not raise_error
  end

  it "should not properly initialize class" do
    expect { SeaBattle::Board.new("") }.to raise_error
  end

  context "should check method ship_positions"do

    it "for non-ship" do
      board = "0"*100
      board[2] = "2"
      board[3] = "2"

      klass.new(board).ship_positions(1, 2).should eq([])
    end

    it "for horizontal ship" do
      board = "1"*100
      board[2] = "2"
      board[3] = "2"
      klass.new(board).ship_positions(0, 2).should eq([[0, 2], [0, 3]])
    end

    it "for vertical ship" do
      board = "0"*100
      board[23] = "2"
      board[33] = "2"
      klass.new(board).ship_positions(2, 3).should eq([[2, 3] ,[3, 3]])
    end

  end

  context "should add new ship in random position" do

    let(:board) { klass.new }

    it "should spred randomly ships on the board" do
      board.random_ships
      result = 0
      board.board.flatten.each do |cell|
        result += 1 if cell.is_in_ship?
      end
      result.should eq(20)
    end
  end
end
