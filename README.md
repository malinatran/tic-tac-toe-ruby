## Tic-Tac-Toe | Ruby

### Objectives
* Build a command-line game in Ruby
* Incorporate Minimax to create an unbeatable AI
* Adhere to SOLID princples and incorporate TDD

To run tests, run `bundle exec rspec spec`.

#### Organization
In the `lib` folder, you will find the following files and corresponding spec files in the `spec` folder:
* `board.rb`: board functionalities related to the grid, its cells, and winning moves, including setting cell, retrieving all empty cells on grid, and clearing grid 
* `computer_player.rb`: AI-related functionalities that enable interaction with the board and retrieving cells to make move
* `human_player.rb`: currently only accepts a marker provided by user input or default marker 
* `player.rb`: superclass of `computer_player` and `human_player`
