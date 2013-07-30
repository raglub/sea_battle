# encoding: utf-8

require "sea_battle"
  def puts(message)
    @@content ||= ""
    @@content << message
  end

  def reset_content
    @@content = ""
  end

  def content
    @@content
  end

  def sleep(value)
  end

  def system(value)
  end

describe SeaBattle::GUI do

  it "should let user exit from game" do
    gui = SeaBattle::GUI.new
    gui.stub(:gets).and_return("e")
    reset_content
    gui.play
    content.should include("(r)andom your ships on board")
  end

  it "should let to random user's ships" do
    gui = SeaBattle::GUI.new
    gui.stub(:gets).and_return("r", "e")
    reset_content
    gui.play
    content.should include("□")
  end

  it "should let user attacked field 2b" do
    gui = SeaBattle::GUI.new
    gui.stub(:gets).and_return("a", "2b", "7c", "3a", "e")
    reset_content
    gui.play
    content.scan(/•|※/).should_not be_empty

  end

end
