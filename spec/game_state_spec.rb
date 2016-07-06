require_relative "spec_helper"
require_relative "../lib/board"
require_relative "../lib/computer_player"
require_relative "../lib/game_state"
require_relative "../lib/human_player"

module TicTacToe
  describe TicTacToe::GameState do

    let(:board)         { Board.new }
    let(:comp_player)   { ComputerPlayer.new }
    let(:game_state)    { TicTacToe::GameState }
    let(:human_player)  { HumanPlayer.new }
    let(:markers)       { ["O", "X"] }

    context "#determine_outcome" do
      it "determines whether the game is over and if so, if it is a draw" do
        allow(game_state).to receive(:is_game_over?).and_return(true)
        expect(game_state).to receive(:draw?).and_return("Draw")
        game_state.determine_outcome(board, markers)
      end
    end

    context "#determine_winner" do
      it "returns the player's marker if there is a winner" do
        board.set_cell({x: 0, y: 0}, "O")
        board.set_cell({x: 0, y: 1}, "O")
        board.set_cell({x: 0, y: 2}, "O")
        expect(game_state.determine_winner(board, markers)).to eq("O")
      end
    end
  end
end
