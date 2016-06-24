## Tic-Tac-Toe | Ruby

#### Objectives
* Build a command-line game in Ruby
* Incorporate Minimax to create an unbeatable AI (TODO next week)
* Adhere to SOLID princples and incorporate TDD

#### Play
To run the game, enter `ruby play.rb` in the root directory. 

A menu directory will give you the option to `1` enter customized values for the board's size, `2` your own marker _or_ alternatively, `3` you may opt into default values (e.g. a board size of three and a marker of "O"). You may enter `4` to exit the program. The board will reset and the menu will reappear after each game is done. 

#### Tests
To run tests, enter `bundle exec rspec spec`.

#### File Structure & Organization
In the `lib` folder, you will find the following files and corresponding spec files in the `spec` folder:
* `board.rb`: has functionalities related to the grid, its cells, and winning moves
* `computer_player.rb`: enables interaction with board to retrieve cells and make moves
* `human_player.rb`: only accepts a marker provided by user input or default marker 
* `player.rb`: serves as superclass of `computer_player` and `human_player`
* `user_interface.rb`: handles methods dealing with the command line
* `game.rb`: contains knowledge pertaining to game, including game state, players, and moves 
