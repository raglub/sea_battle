# encoding: utf-8

require "sea_battle"

describe SeaBattle do

  let(:board) { SeaBattle::Board }

  #    ABCDEFGHIJ
  #   1        *
  #   2 ****   *
  #   3
  #   4      *  *
  #   5*  *  *
  #   6      *
  #   7
  #   8 ***
  #   9     **  *
  #  10 *       *
  let(:first_raw_board) {
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

  it "should properly initialize class" do
    expect { SeaBattle.new(board.new, board.new) }.to_not raise_error
  end

  context "for preparation game" do
    it "should not attack player one if game isn't active" do
      board_zero = board.new(first_raw_board, :initialized)
      board_one = board.new(first_raw_board, :initialized)
      sea_battle = SeaBattle.new(board_zero, board_one, nil)
      sea_battle.move(:first_player, :attack, 2, 1)
      sea_battle.last_attack_move.should eq(nil)
    end
  end

  context "for active game (first move)" do
    let(:board_zero) { board.new(first_raw_board, :activated) }
    let(:board_one) { board.new(first_raw_board, :activated) }
    let(:sea_battle) { SeaBattle.new(board_zero, board_one, nil) }

    it "should properly attack second player" do
      sea_battle.move(:first_player, :attack, 1, 2).should be_true
      sea_battle.last_attack_move.should eql("first_player;1;2")
    end

    it "shouldn't properly attack first player" do
      sea_battle.move(:second_player, :attack, 1, 2).should be_false
      sea_battle.last_attack_move.should eql(nil)
    end

    it "should get first_player" do
      sea_battle.active_user.should eql(:first_player)
    end
  end

  context "for active game and first player correctly attacked competition ship then" do
    let(:board_zero) { board.new(first_raw_board, :activated) }
    let(:board_one) { board.new(first_raw_board, :activated) }
    let(:sea_battle) { SeaBattle.new(board_zero, board_one, "first_player;1;1") }

    it "first player should properly attack second player" do
      sea_battle.move(:first_player, :attack, 1, 2).should be_true
      sea_battle.last_attack_move.should eql("first_player;1;2")
    end

    it "second player shouldn't properly attack first player" do
      sea_battle.move(:second_player, :attack, 1, 2).should be_false
      sea_battle.last_attack_move.should eql("first_player;1;1")
    end

    it "should get first_player" do
      sea_battle.active_user.should eql(:first_player)
    end

  end

  context "for method winer_is" do
    let(:first_board) { board.new(first_raw_board, :activated) }
    let(:second_board) { board.new(first_raw_board, :activated) }
    let(:sea_battle) { SeaBattle.new(first_board, second_board, nil) }

    it "should return nil if no one win of game" do
      sea_battle.winner_is.should be_nil
    end

    it "should return :first_player if first player win of game" do
      first_board.stub(:status) { :finished }
      sea_battle.winner_is.should eq(:first_player)
    end

    it "should return :second_player if second player win of game" do
      second_board.stub(:status) { :finished }
      sea_battle.winner_is.should eq(:second_player)
    end

  end

end
