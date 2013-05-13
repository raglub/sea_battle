# encoding: utf-8

require "sea_battle"

describe SeaBattle::Board do

  it "should properly initialize class" do
    expect { SeaBattle::Board.new([]) }.to_not raise_error
  end

  it "should not properly initialize class" do
    expect { SeaBattle::Board.new("") }.to raise_error
  end
end
