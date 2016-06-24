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

    context "#start_game" do
      it "should start the tic-tac-toe game by selecting a player, drawing the board, and entering into game loop" do
        allow(user_interface).to receive(:start_game).and_return(true)
        expect(game).to receive(:select_player)
        expect(game).to receive(:play_game_loop)
        game.start_game
      end
    end

    context "#select_player" do
      it "randomly selects one of the players" do
        allow(game).to receive(:select_player).and_return(:computer_player)
        expect(game.select_player).to eq(:computer_player)
      end
    end

    context "#retrieve_size" do
      it "retrieves size input by the user and passes to board" do
        expect(user_interface).to receive(:select_size).with(no_args)
        game.retrieve_size
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
      it "should return the winner" do
        board.set_cell({x: 0, y: 0}, "X") 
        board.set_cell({x: 0, y: 1}, "X") 
        board.set_cell({x: 0, y: 2}, "X") 
        expect(game.get_winner(computer_player)).to eq(computer_player)
      end

      it "should return nil if there is no winner" do
        board.set_cell({x: 0, y: 2}, "X") 
        expect(game.get_winner(human_player)).to eq(nil)
      end
    end

    context "#play_game_loop" do
      it "should continue to call on method to play game while game is not over" do
        allow(game).to receive(:is_game_over?).and_return(false, true)
        expect(game).to receive(:play_game).with(no_args)
        game.play_game_loop
      end
    end

    context "#request_move" do
      it "should request a move from the computer if current player is computer player" do
        allow(game).to receive(:is_computer_the_current_player?).and_return(true, false)
        expect(game).to receive(:request_computer_move).and_return({x: 1, y: 1})
        expect(board).to receive(:set_cell).with(any_args)
        game.request_move
      end

      # error: stack level too deep
      it "should request a move from the user if current player is not computer player" do
        allow(game).to receive(:is_computer_the_current_player?).and_return(false)
        expect(game).to receive(:map_move).with(any_args)
        expect(board).to receive(:set_cell).with(any_args)
        game.request_move
      end
    end

    context "#request_computer_move" do
      it "should request a move from the computer player if current player is computer player" do
        expect(computer_player).to receive(:request_move).with(any_args)
        game.request_computer_move
      end

      it "should return a hash representing the move" do
        expect(computer_player).to receive(:request_move).and_return({x: 1, y: 1})
        game.request_computer_move
      end
    end

    context "#request_human_move" do
      it "should call a method in the User Interface class" do
        expect(user_interface).to receive(:display_move_request).with(any_args)
        game.request_human_move
      end

      it "should return a cell number representing the move" do
        # not sure how to test value
      end
    end

    context "#map_move" do
      it "should translate the move to a hash of coordinates" do
        move = 3
        expect(game.map_move(move)).to eq({x: 0, y: 2})
      end
    end

    context "#declare_outcome" do
      it "should update the UI with a message about draw" do
        allow(game).to receive(:is_game_over?).and_return(true, false)
        allow(game).to receive(:draw?).and_return(true, false)
        expect(user_interface).to receive(:declare_draw).with(no_args)
        game.declare_outcome
      end

      it "should update the UI with a message about winner" do
        allow(game).to receive(:is_game_over?).and_return(true, false)
        allow(game).to receive(:draw?).and_return(false)
        allow(game).to receive(:win?).and_return(true)
        expect(user_interface).to receive(:declare_winner).with(any_args)
        game.declare_outcome
      end
    end
  end
end
