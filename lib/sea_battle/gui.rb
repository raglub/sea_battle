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
      @computer_board.activate_board
      @sea_battle = ::SeaBattle.new(@user_board, @computer_board)
      set_default_keyboard
      push_message("Initialized SeaBattle")
    end

    def play
      while true and not @keyboard[:exit]
        update_screen
        user_command
        next if @keyboard[:error]
        if @keyboard[:position]
          attack_on(@row, @column, :first_player)
          break unless @sea_battle.winner_is.nil?
          while @sea_battle.active_user == :second_player
            sleep 1 + rand
            row, column = @computer_board.random_position
            attack_on(row, column, :second_player)
          end
          break unless @sea_battle.winner_is.nil?
          @keyboard[:position] = false
        end
      end
    end

  private

    def all_positions
      (0..9).to_a.product(
        (0..9).to_a.map do |column|
          (column + 97).chr
        end
      ).map { |row, column| "#{row}#{column}" }
    end

    def attack_on(row, column, active_player)
      player_name = (active_player == :first_player ? "You" : "Computer")
      @sea_battle.move(active_player, :attack, row, column)
      push_message("Moved on position #{row}#{(97 + column).chr}", player_name)
      if @sea_battle.is_sunken_ship?(row, column, active_player)
        push_message("Sunk ship", player_name)
      end
      if @sea_battle.winner_is == active_player
        push_message("WIN!!!", player_name)
      end
      update_screen
    end

    def board_line(board, index, player)
      board.board[index].map do |cell|
        if cell.is_attacked? and cell.is_in_ship?
          unless cell.is_sunk?
            " ■ "
          else
            " ※ "
          end
        elsif cell.is_attacked? and not cell.is_in_ship?
          " • "
        elsif not cell.is_attacked? and cell.is_in_ship? and player == :first_player
          " □ "
        else
          "   "
        end
      end.join("│")
    end

    def info_command
      puts "※ - sunk ship; ■ - hit ship; □ - selected ship; • - mishit"
      puts ""
      unless @sea_battle.is_activated?
        puts "(r)andom your ships on board"
        puts "(a)ctivate your game if all ships are at properly place"
      else
        puts "(r)andom position into attack"
        puts "4a, 8i, ... - select part of ship"
      end
      puts "(e)xit of game"
      print "#=> "
    end

    def set_default_keyboard
      @keyboard = {
        exit: false,
        position: nil,
        error: false
      }
    end

    def update_screen
      system "clear"
      show_title
      column_position = "A   B   C   D   E   F   G   H   I   J"
      end_of_board = "┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼"

      puts "     #{column_position}         #{column_position}"
      (0..9).each do |index|
        user_line = board_line(@user_board, index, :first_player)
        computer_line = board_line(@computer_board, index, :second_player)
        puts "   #{end_of_board}     #{end_of_board}"
        puts " #{index} │#{user_line}│   #{index} │#{computer_line}│"
      end
      puts "   #{end_of_board}     #{end_of_board}\n \n"
      show_messages
    end

    def show_title
      puts ""
      puts "#{' '*10}SEA BATTLE ver#{VERSION}"
      puts ""
    end

    def user_command
      info_command
      keyboard = gets.chomp
      @keyboard[:exit] = true if keyboard == "e"
      if @sea_battle.is_activated?
        @keyboard[:error] = false
        if all_positions.include?(keyboard)
          @row, @column = keyboard.split("")
          @column = @column.ord - 97
          @row = @row.to_i
          @keyboard[:position] = true
          #if @computer_board.is_attacked?(@row, @column)
          #  @keyboard[:error] = true
          #  @keyboard[:position] = false
          #  push_message("Used incorrect command: #{keyboard}")
          #end
        elsif keyboard == "r"
          @row, @column = @computer_board.random_position
          @keyboard[:position] = true
        else
          @keyboard[:error] = true
          push_message("Used incorrect command: #{keyboard}")
        end
      else
        if keyboard == "a"
          if @user_board.activate_board
            push_message("Activated game")
          else
            push_message("Don't activated game!!!")
          end
        end

        if keyboard == "r"
          @user_board.random_ships
          push_message("Random ships")
        end
      end
    end

    def push_message(message, player = "You")
      @messages ||= []
      @messages = @messages.rotate(1)
      @messages[3] = "  #{Time.now.strftime("%H:%M:%S")} #{player}: #{message}"
    end

    def show_messages
      @messages ||= []
      puts @messages.compact.join("\n")
      puts "_"*60
    end

  end
end
