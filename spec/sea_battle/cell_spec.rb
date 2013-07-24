# encoding: utf-8

require "sea_battle"

describe SeaBattle::Cell do

  let(:klass) { SeaBattle::Cell }

  it "should properly initialize class" do
    expect { klass.new(1) }.to_not raise_error
  end

  it "should check method is_attacted?" do
    klass.new(1).is_attacked?.should be_false
    klass.new(4).is_attacked?.should be_true
  end

  it "should check method attack" do
    cell = klass.new(1)
    cell.is_attacked?.should be_false
    cell.attack
    cell.is_attacked?.should be_true
  end

  it "should check method is_empty?" do
    klass.new(1).is_empty?.should be_true
    klass.new(5).is_empty?.should be_true
  end

  it "should check method is_in_ship?" do
    klass.new(1).is_in_ship?.should be_false
    klass.new(2).is_in_ship?.should be_true
    klass.new(3).is_in_ship?.should be_true
  end

  it "should check method is_selected?" do
    klass.new(1).is_selected?.should be_false
    klass.new(2).is_selected?.should be_false
    klass.new(8).is_selected?.should be_true
  end

  it "should check method switch_select" do
    cell = klass.new(1)
    cell.is_selected?.should be_false
    cell.switch_select
    cell.is_selected?.should be_true
    cell.switch_select
    cell.is_selected?.should be_false
  end

end
