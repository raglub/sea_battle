# encoding: utf-8

require_relative "cell"
require_relative "board"
require_relative "version"

class SeaBattle
  # User can play with computer on console
  class GUI

    def initialize
      @user_board = ::SeaBattle::Board.new
      @computer_board = ::SeaBattle::Board.new
      @computer_board.random_ships
      @computer_board.activated_board
      @exit = false
      @keyboard = {
        exit: false,
        activate: false,
        position: nil
      }
      puts ""
      puts "#{' '*10}SEA BATTLE ver#{VERSION}"
    end

    def random_ships_for_user
      @user_board.random_ships
      @user_board.activated_board
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
      while true and not @keyboard[:exit]
        system "clear"
        show
        get_input
        if @keyboard[:position]
          @computer_board.attack(@row, @column)
          system "clear"
          show
          sleep 1 + rand

          @user_board.attack(rand(10), rand(10))
          @keyboard[:position] = false
        end
      end
    end

    def get_input
      puts ""
      puts "(r)andom your ships on board"
      puts "4a, ... - select part of ship"
      puts "(a)ctivate your game if all ships are at properly place"
      puts "(e)xit of game"
      keyboard = gets.chomp
      @keyboard[:exit] = true if keyboard == "e"
      if not @keyboard[:exit] and @keyboard[:activate]
        @keyboard[:position] = true
        @row, @column = keyboard.split("")
        @column = @column.ord - 97
        @row = @row.to_i
      end
      @keyboard[:activate] = true if keyboard == "a"
      @user_board.random_ships if keyboard == "r"
    end

  end
end
