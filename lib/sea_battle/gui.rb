# encoding: utf-8

require_relative "board"
require_relative "version"
require_relative "../sea_battle"

class SeaBattle
  # User can play with computer on console
  class GUI

    def initialize
      @user_board = ::SeaBattle::Board.new
      @computer_board = ::SeaBattle::Board.new
      @computer_board.random_ships
      @computer_board.activated_board
      @sea_battle = ::SeaBattle.new(@user_board, @computer_board)
      set_default_keyboard
    end

    def play
      while true and not @keyboard[:exit]
        system "clear"
        show_boards
        get_input
        if @keyboard[:position]
          @sea_battle.move(:first_player, :attack, @row, @column)
          system "clear"
          show_boards
          while @sea_battle.active_user == :second_player
            sleep 1 + rand
            @sea_battle.move(:second_player, :attack, rand(10), rand(10))
            system "clear"
            show_boards
          end
          @keyboard[:position] = false
        end
      end
    end

  private

    def set_default_keyboard
      @keyboard = {
        exit: false,
        activate: false,
        position: nil
      }
    end

    def show_boards
      show_title

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

    def show_title
      puts ""
      puts "#{' '*10}SEA BATTLE ver#{VERSION}"
    end

    def get_input
      puts ""
      puts "4a, ... - select part of ship"
      unless @keyboard[:activate]
        puts "(r)andom your ships on board"
        puts "(a)ctivate your game if all ships are at properly place"
      end
      puts "(e)xit of game"
      keyboard = gets.chomp
      @keyboard[:exit] = true if keyboard == "e"
      if not @keyboard[:exit] and @keyboard[:activate]
        @keyboard[:position] = true
        @row, @column = keyboard.split("")
        @column = @column.ord - 97
        @row = @row.to_i
      end
      if keyboard == "a"

        @keyboard[:activate] = true
        @user_board.activated_board

      end
      @user_board.random_ships if keyboard == "r"
    end

  end
end
