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

### Initialize board of the game

    $ require "sea_battle"

    $ board = SeaBattle::Board.new.board
    $ board[0][3].is_attacked?

### Add random ship on the board

    $ require "random_ship"
    ...

    SeaBattle::RandomBoard.new(board, 3).add_ship

### Use class SeaBattle

    $ require "sea_battle"

    $ first_board = SeaBattle::Board.new
    $ second_board = SeaBattle::Board.new
    $ sea_battle = SeaBattle.new(first_board, second_board)

#### Game is activated?
    $ sea_battle.is_activated?

#### You can get which player is active
    $ sea_battle.active_user #=> :first_player

#### Ship on position row, column is sunken?
    $ sea_battle.is_sunken_ship?(3, 7) #=> false

#### You can attack position (row, column)
    $ sea_battle.move(:second_player, :attack, 2, 9)

#### When game is over you can see winner
    $ sea_battle.winner_is #=> :first_player

### Play on console (min 92x40)

    $ sea_battle

    #=>          SEA BATTLE

    #=>        A   B   C   D   E   F   G   H   I   J         A   B   C   D   E   F   G   H   I   J
    #=>      ┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼     ┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼
    #=>    0 │   │ • │ □ │ • │   │   │   │   │ • │   │   0 │ • │ • │ • │   │ • │ ※ │ ※ │ ※ │ ※ │ • │
    #=>      ┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼     ┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼
    #=>    1 │ • │   │   │   │   │   │   │   │   │ • │   1 │   │   │   │ ■ │   │   │ • │ • │ • │   │
    #=>      ┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼     ┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼
    #=>    2 │ □ │   │ • │ • │   │ □ │   │   │ • │   │   2 │ • │ • │ • │ ■ │   │   │   │   │   │   │
    #=>      ┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼     ┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼
    #=>    3 │ ■ │ • │   │ • │   │ □ │   │ • │ □ │ • │   3 │ • │ • │ • │ • │ • │ ※ │ • │ • │ • │ • │
    #=>      ┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼     ┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼
    #=>    4 │   │ • │   │ • │   │   │   │ • │ • │ • │   4 │ • │   │ • │   │   │   │ • │ ■ │   │   │
    #=>      ┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼     ┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼
    #=>    5 │ □ │ • │ □ │   │ □ │ □ │ ■ │ □ │   │ • │   5 │   │   │   │ ※ │ ※ │   │   │ ■ │ • │   │
    #=>      ┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼     ┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼
    #=>    6 │ □ │ • │ □ │   │   │ • │ • │   │   │   │   6 │   │   │ • │ • │ • │ • │   │   │ • │ • │
    #=>      ┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼     ┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼
    #=>    7 │   │   │ ■ │ • │ • │   │ • │   │   │   │   7 │ • │ • │   │   │   │ • │   │   │ • │ • │
    #=>      ┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼     ┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼
    #=>    8 │ • │   │   │ • │   │   │   │   │ • │ □ │   8 │   │   │ • │   │   │   │ ■ │   │ • │ • │
    #=>      ┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼     ┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼
    #=>    9 │   │ • │ ※ │   │ □ │ □ │ □ │   │ • │ • │   9 │ • │   │ • │   │ • │ • │   │   │   │   │
    #=>      ┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼     ┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼
    #=>
    #=>     11:12:50 Computer: Moved on position 0d
    #=>     11:12:50 You: Moved on position 3a
    #=>     11:12:52 Computer: Moved on position 4i
    #=>     11:12:52 You: Moved on position 4h
    #=>   ____________________________________________________________
    #=>   ※ - sunk ship; ■ - hit ship; □ - selected ship; • - mishit

    #=>   (r)andom position into attack
    #=>   4a, 8i, ... - select part of ship
    #=>   (e)xit of game
    #=>   #=>

