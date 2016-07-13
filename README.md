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
In the `lib` folder, you will find the following files and corresponding spec files in the `spec` folder (with the exception of `play.rb` and `constants.rb`):

* `board.rb`: has functionalities related to the grid and cells
* `computer_player.rb`: makes computer moves 
* `constants.rb`: contains all stubbed string values shared across classes
* `game.rb`: is responsible for coordinating game loop and players' turns
* `game_state.rb`: handles logic for state of game and outcome
* `human_player.rb`: makes human moves by coordinating with `user_interface` 
* `input_validator.rb`: checks that user input for board size, marker, and moves are valid 
* `play.rb`: is the entry point of the game and initializes many of the classes below
* `player.rb`: serves as superclass of `computer_player` and `human_player`
* `user_interface.rb`: handles looping of menu directory and commands
* `user_interface_helper.rb`: is concerned with formatted input and output 

#### Organization
![Diagram](https://s31.postimg.org/mgt748td7/TTT_Diagram_v2.jpg)
