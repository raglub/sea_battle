# encoding: utf-8

require "sea_battle"

describe SeaBattle::RandomShip do

  let(:board) { SeaBattle::Board.new("1"*100) }

  let(:object) { klass.new(board) }

  let(:klass) { SeaBattle::RandomShip }

  it "should check method area_positions_with for vertical" do
    klass.new(board, 3).area_ship_positions(2, 3, true).should eq([
      [1, 2], [1, 3], [1, 4],
      [2, 2], [2, 3], [2, 4],
      [3, 2], [3, 3], [3, 4],
      [4, 2], [4, 3], [4, 4],
      [5, 2], [5, 3], [5, 4]
    ])
  end

  it "should check method area_positions_with for horizontal" do
    klass.new(board, 2).area_ship_positions(3, 4, false).should eq([
      [2, 3], [2, 4], [2, 5], [2, 6],
      [3, 3], [3, 4], [3, 5], [3, 6],
      [4, 3], [4, 4], [4, 5], [4, 6]
    ])
  end

  it "should check method ship_positions for vertical" do
    klass.new(board, 3).ship_positions(2, 3, true).should eq([
      [2, 3], [3, 3], [4, 3]
    ])

    klass.new(board, 3).ship_positions(2, 3, false).should eq([
      [2, 3], [2, 4], [2, 5]
    ])

  end

  it "should check method is_area_empty?" do
    klass.new(board, 2).is_area_empty?(3, 3, true).should be_true
  end

  it "should check method mixed_board_positions" do
    Random.stub(:rand).with(10 * 10) { 34 }
    klass.new(board, 4).mixed_board_positions.first.should eq([3, 4])
  end

  it "should check method add_vertical" do
    Random.stub(:rand).with(10 * 10) { 34 }
    klass.new(board, 2).add_vertical.should eq([[3, 4], [4, 4]])
    board.board[4][4].is_in_ship?.should be_true
  end

  it "should check method add_horizontal" do
    Random.stub(:rand).with(10 * 10) { 54 }
    klass.new(board, 2).add_horizontal.should eq([[5, 4], [5, 5]])
    board.board[5][5].is_in_ship?.should be_true
  end

  it "should check method add" do
    Random.stub(:rand).with(2) { 0 }
    Random.stub(:rand).with(10 * 10) { 54 }
    klass.new(board, 2).add
    board.board[6][4].is_in_ship?.should be_true

    klass.new(board, 2).add
    board.board[6][6].is_in_ship?.should be_true
  end

end
