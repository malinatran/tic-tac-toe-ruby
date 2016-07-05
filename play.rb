require_relative "lib/game"
require_relative "lib/board"
require_relative "lib/computer_player"
require_relative "lib/human_player"
require_relative "lib/user_interface"
require_relative "lib/helper"

helper = TicTacToe::Helper.new
game = TicTacToe::Game.new({board: TicTacToe::Board.new,
                            computer_player: TicTacToe::ComputerPlayer.new,
                            human_player: TicTacToe::HumanPlayer.new,
                            user_interface: TicTacToe::UserInterface.new(helper)})
game.start_game
