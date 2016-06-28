## Tic-Tac-Toe | Ruby

#### Objectives
* Build a command-line game in Ruby
* Incorporate Minimax to create an unbeatable AI
* Adhere to [SOLID princples](https://www.wikiwand.com/en/SOLID_(object-oriented_design)) and incorporate [TDD](https://www.wikiwand.com/en/Test-driven_development)

#### Play
To run the game, enter `ruby play.rb` in the root directory. 

A menu directory will give you the option to:

1. Enter customized value for the board's size between 3 to 10
2. Enter your own marker, which must be a single character that is not "X" (computer's designated marker
3. Opt into game with default values (e.g. a board size of three and a marker of "O")
4. Exit the program

Please note: the board will reset and the menu will reappear after each game is done and the outcome has been announced. 

#### Tests
To run tests, first enter `bundle install` and then `bundle exec rspec`.

#### File Structure
In the `lib` folder, you will find the following files and corresponding spec files in the `spec` folder (with the exception of `play.rb`):

* `board.rb`: has functionalities related to the grid, its cells, and winning moves
* `computer_player.rb`: enables interaction with board to retrieve cells and make moves
* `human_player.rb`: only accepts a marker provided by user input or default marker 
* `player.rb`: serves as superclass of `computer_player` and `human_player`
* `user_interface.rb`: handles methods dealing with the command line
* `helper.rb`: contains methods that are helpers or validators for `user_interface`
* `game.rb`: contains knowledge pertaining to game, including game state, players, and moves 
* `play.rb`: is the entry point of the game and initializes all of the above classes

#### Organization
![Organization](https://s32.postimg.org/xv6pqd9it/1_mteatran_Malinas_Mac_Book_Pro_vim.png =250x)
