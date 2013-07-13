# encoding: utf-8

require_relative "cell"
require_relative "board"

class SeaBattle
  # User can play with computer on console
  class GUI

    def initialize
      @user_board = ::SeaBattle::Board.new
      @user_board.random_ships
      @computer_board = ::SeaBattle::Board.new
      @computer_board.random_ships
    end

    def show
      puts ""
      puts "     A   B   C   D   E   F   G   H   I   J           A   B   C   D   E   F   G   H   I   J"
      @user_board.board.each_with_index do |line, index|
        user_line = line.map do |cell|
          if cell.is_attacked? and cell.is_in_ship?
            " ⬤ "
          elsif cell.is_attacked? and not cell.is_in_ship?
            " • "
          elsif not cell.is_attacked? and cell.is_in_ship?
            " ◯ "
          else
            "   "
          end
        end.join("│")
        computer_line = @computer_board.board[index].map do |cell|
          if cell.is_attacked? and cell.is_in_ship?
            " ⬤ "
          elsif cell.is_attacked? and not cell.is_in_ship?
            " • "
          else
            "   "
          end
        end.join("│")
        puts "   ┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼       ┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼"
        puts "#{index}  │#{user_line}│    #{index}  │#{computer_line}│"
      end
    end

    def play
      while true
        system "clear"
        show
        get_input
        break if @value == "end"
        @computer_board.attack(@row, @column)
        system "clear"
        show
        sleep 1 + rand

        @user_board.attack(rand(10), rand(10))
      end
    end

    def get_input
      puts ""
      puts "Put your position into attack"
      @value = gets.chomp
      @row, @column = @value.split("")
      @column = @column.ord - 97
      @row = @row.to_i
    end

  end
end
