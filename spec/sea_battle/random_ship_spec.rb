# encoding: utf-8

require "sea_battle"

describe SeaBattle::RandomShip do

  let(:board) { SeaBattle::Board.new("1"*100) }

  let(:object) { klass.new(board) }

  let(:klass) { SeaBattle::RandomShip }

  context "#area_positions_with" do
    it "for vertical in centre position" do
      klass.new(board, 3).area_ship_positions(2, 3, :vertical).should eq([
        [1, 2], [1, 3], [1, 4],
        [2, 2], [2, 3], [2, 4],
        [3, 2], [3, 3], [3, 4],
        [4, 2], [4, 3], [4, 4],
        [5, 2], [5, 3], [5, 4]
      ])
    end

    it "for vertical in right position" do
      klass.new(board, 1).area_ship_positions(5, 9, :vertical).should eq([
        [4, 8], [4, 9],
        [5, 8], [5, 9],
        [6, 8], [6, 9]
      ])
    end

    it "for horizontal in centre position" do
      klass.new(board, 2).area_ship_positions(3, 4, :horizontal).should eq([
        [2, 3], [2, 4], [2, 5], [2, 6],
        [3, 3], [3, 4], [3, 5], [3, 6],
        [4, 3], [4, 4], [4, 5], [4, 6]
      ])
    end

  end

  it "should check method ship_positions for vertical" do
    klass.new(board, 3).ship_positions(2, 3, :vertical).should eq([
      [2, 3], [3, 3], [4, 3]
    ])

    klass.new(board, 3).ship_positions(2, 3, :horizontal).should eq([
      [2, 3], [2, 4], [2, 5]
    ])
  end

  it "should check method is_area_empty?" do
    klass.new(board, 2).is_area_empty?(3, 3, :vertical).should be_true
  end

  it "should check method mixed_board_positions" do
    Random.stub(:rand).with(10 * 10) { 34 }
    klass.new(board, 4).mixed_board_positions.first.should eq([3, 4])
  end

  context "for method #add_ship_of(:vertical)"do
    it "in centre of board" do
      Random.stub(:rand).with(10 * 10) { 34 }
      klass.new(board, 2).add_ship_of(:vertical).should eq([[3, 4], [4, 4]])
      board.board[4][4].is_in_ship?.should be_true
    end

    it "in bottom of board" do
      Random.stub(:rand).with(10 * 10) { 93 }
      klass.new(board, 2).add_ship_of(:vertical).should eq([[0, 0], [1, 0]])
      board.board[1][0].is_in_ship?.should be_true
    end

    it "in bottom of board" do
      Random.stub(:rand).with(10 * 10) { 93 }
      klass.new(board, 2).add_ship_of(:vertical).should eq([[0, 0], [1, 0]])
      board.board[1][0].is_in_ship?.should be_true
    end

  end

  it "should check method #add_ship_of(:horizontal)" do
    Random.stub(:rand).with(10 * 10) { 54 }
    klass.new(board, 2).add_ship_of(:horizontal).should eq([[5, 4], [5, 5]])
    board.board[5][5].is_in_ship?.should be_true
  end

  it "should check method #add_ship" do
    Random.stub(:rand).with(2) { 0 }
    Random.stub(:rand).with(10 * 10) { 54 }
    klass.new(board, 2).add_ship
    board.board[6][4].is_in_ship?.should be_true

    klass.new(board, 2).add_ship
    board.board[6][6].is_in_ship?.should be_true
  end

end
