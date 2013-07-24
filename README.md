# SeaBattle

Sea Battle is a guessing game for two players

## Installation

Add this line to your application's Gemfile:

    gem 'sea_battle'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sea_battle

## Usage

Initialize board of the game

    $ require "sea_battle"

    $ board = SeaBattle::Board.new.board
    $ board[0][3].is_attacked?

Add random ship on the board

    $ require "random_ship"
    ...

    SeaBattle::RandomBoard.new(board, 3).add_ship

Play on console

    $ sea_battle

Use class SeaBattle

   $ require "sea_battle"

   $ first_board = SeaBattle::Board.new
   $ second_board = SeaBattle::Board.new
   $ SeaBattle.new(first_board, second_board)
