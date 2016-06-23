require_relative "spec_helper"
require_relative "../lib/game"
require_relative "../lib/computer_player"
require_relative "../lib/human_player"
require_relative "../lib/user_interface"

module TicTacToe
  describe TicTacToe::Game do
    let(:board) { Board.new }
    let(:computer_player) { ComputerPlayer.new }
    let(:human_player) { HumanPlayer.new }
    let(:input) { StringIO.new }
    let(:output) { StringIO.new }
    let(:user_interface) { UserInterface.new(input, output) }
    let(:game) { Game.new(board: board, 
                          computer_player: computer_player, 
                          human_player: human_player,
                          user_interface: user_interface) }
                                            
    context "#initialize" do
      it "initializes a game with a board" do
        sample_board = [[nil, nil, nil],
                        [nil, nil, nil],
                        [nil, nil, nil]]
        expect(board.grid).to eq(sample_board)
        expect(board.size).to eq(3)
      end

      it "initializes a game with a computer player and human player with default markers" do
        expect(computer_player.marker).to eq("X")
        expect(human_player.marker).to eq("O")
      end

      it "initializes a game with arguments that have been passed in" do
        board = Board.new(5)
        computer_player = ComputerPlayer.new("M")
        expect(board.size).to eq(5) 
        expect(computer_player.marker).to eq("M")
        expect(human_player.marker).to eq("O")
      end
    end

    context "#select_player" do
      it "randomly selects one of the players to be the current player" do
        allow(game).to receive(:select_player).and_return(:computer_player)
        expect(game.select_player).to eq(:computer_player)
      end
    end

    context "#switch_player" do
      it "returns the other player who was not the current player" do
        game.select_player
        first_player = game.current_player
        expect(game.switch_player).to_not eq(first_player)
      end
    end

    context "#is_game_over?" do
      it "should return true if there is either a winner" do
        board.set_cell({x: 0, y: 0}, "X") 
        board.set_cell({x: 0, y: 1}, "X") 
        board.set_cell({x: 0, y: 2}, "X") 
        expect(game.is_game_over?).to eq(true)
      end

      it "should return true if there is a draw" do
        board.set_cell({x: 0, y: 0}, "X")
        board.set_cell({x: 0, y: 1}, "O")
        board.set_cell({x: 0, y: 2}, "O")
        board.set_cell({x: 1, y: 0}, "O")
        board.set_cell({x: 1, y: 1}, "X")
        board.set_cell({x: 1, y: 2}, "X")
        board.set_cell({x: 2, y: 0}, "X")
        board.set_cell({x: 2, y: 1}, "O")
        board.set_cell({x: 2, y: 2}, "O")
        expect(game.is_game_over?).to eq(true)
      end

      it "should return false if the game is still in session" do
        board.set_cell({x: 0, y: 0}, "X")
        board.set_cell({x: 0, y: 1}, "X")
        board.set_cell({x: 0, y: 2}, "O")
        expect(game.is_game_over?).to eq(false)
      end
    end

    context "#get_winner" do
      it "should return the marker of the winner" do
        board.set_cell({x: 0, y: 0}, "X") 
        board.set_cell({x: 0, y: 1}, "X") 
        board.set_cell({x: 0, y: 2}, "X") 
        expect(game.get_winner(computer_player)).to eq("X")
      end

      it "should return nil if there is no winner" do
        board.set_cell({x: 0, y: 2}, "X") 
        expect(game.get_winner(human_player)).to eq(nil)
      end
    end

    context "#play_game" do
      it "should continue to switch players while the game is continuing" do
        expect(game).to receive(:switch_player) 
        expect(game).to receive(:request_move)
        game.play_game
      end
    end

    context "#request_move" do
      it "should call on a method to display the board" do
        expect(user_interface).to receive(:display_board).with(any_args)
        game.request_move
      end

      it "should request a move from the computer player if current player is computer player" do
        allow(game).to receive(:current_player).and_return(:computer_player)
        expect(computer_player).to receive(:request_move).with(any_args)
        game.request_move
      end
    end

    context "#return_human_move" do
      it "should call a method in the User Interface class" do
        expect(user_interface).to receive(:request_move).with(any_args)
        game.return_human_move
      end
      
      it "should validate the move input by human and then return the move" do
        input.string = "5"
        expect(game.return_move).to eq(5)
      end
    end
  end
end
