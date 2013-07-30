# encoding: utf-8

require "sea_battle"

describe SeaBattle::Board do

  let(:klass) { SeaBattle::Board }

  let(:raw_board) {
    "1111111121" +
    "1222211121" +
    "1111111111" +
    "1111112112" +
    "2112112111" +
    "1111112111" +
    "1111111111" +
    "1222111111" +
    "1111122112" +
    "1211111112"
  }

  let(:board) { SeaBattle::Board.new(raw_board) }

  it "should properly initialize class" do
    expect { SeaBattle::Board.new }.to_not raise_error
  end

  it "should not properly initialize class" do
    expect { SeaBattle::Board.new("") }.to raise_error
  end

  context "should check method #activate_board" do
    it "for empty board" do
      SeaBattle::Board.new.activate_board.should be_false
    end

    it "for properly arranged ships on board" do
      SeaBattle::Board.new(raw_board).activate_board.should be_true
    end
  end

  context "should check method ship_positions"do

    it "for non-ship" do
      board.ship_positions(6, 2).should eq([])
    end

    it "for horizontal ship" do
      board.ship_positions(7, 2).should eq([[7, 1], [7, 2], [7, 3]])
    end

    it "for vertical ship" do
      board.ship_positions(5, 6).should eq([[3, 6] ,[4, 6], [5, 6]])
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

  context "should check method attack"do

    it "for non-ship" do
      board.activate_board
      board.attack(0, 8)
      board.board[0][8].is_sunk?.should be_false
      board.attack(1, 8)
      board.board[0][8].is_sunk?.should be_true
      board.board[1][8].is_sunk?.should be_true
    end

  end

  context "should random new position into attack" do
    let(:active_board) do
      result = raw_board
      result[12] = "6"
      result
    end

    let(:board) { SeaBattle::Board.new(active_board) }

    it "for simply type" do
      board.activate_board
      Random.stub(:rand) { 12 }
      board.random_position.should eql([1, 3])
    end

  end

end
