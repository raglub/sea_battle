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

    $ require "sea_battle"

    $ board = SeaBattle::Board.new.board
    $ board[0][3].is_attacked?
