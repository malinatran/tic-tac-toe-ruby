require_relative "spec_helper"
require_relative "../lib/computer_player"

module TicTacToe
  describe TicTacToe::ComputerPlayer do

    let (:comp_player) { ComputerPlayer.new }
    let (:board)       { Board.new }
    let (:depth)       { 0 }

    context "#initialize" do
      it "initializes with a marker based on user input" do
        comp_player = ComputerPlayer.new("O")
        expect(comp_player.marker).to eq("O")
      end

      it "initializes with a default marker" do
        comp_player = ComputerPlayer.new
        expect(comp_player.marker).to eq("X")
      end
    end

    context "#minimax" do
      it "iterates through simple board and returns move with a score of 10" do
        board = Board.new(2)
        board.set_cell({x: 0, y: 0}, "X")
        board.set_cell({x: 1, y: 0}, "X")
        expect(comp_player.minimax(board, depth, "X", "O")).to eq(10)
      end

      it "iterates through relatively complex board and returns move with a score minus depth" do
        board.set_cell({x: 0, y: 0}, "O")
        board.set_cell({x: 0, y: 1}, "O")
        board.set_cell({x: 0, y: 2}, "X")
        board.set_cell({x: 1, y: 1}, "X")
        expect(comp_player.minimax(board, depth, "X", "O")).to eq(8)
      end
    end

    context "#score" do
      it "returns a score of 10 if the winner is the AI" do
        board.set_cell({x: 0, y: 0}, "X")
        board.set_cell({x: 1, y: 0}, "X")
        board.set_cell({x: 2, y: 0}, "X")
        expect(comp_player.score(board, depth, "O")).to eq(10)
      end
      
      it "returns a score of -10 if the winner is the human player" do
        board.set_cell({x: 0, y: 0}, "O")
        board.set_cell({x: 1, y: 0}, "O")
        board.set_cell({x: 2, y: 0}, "O")
        expect(comp_player.score(board, depth, "O")).to eq(-10)
      end
      
      it "returns 0 if there is no winner and the game is not a draw" do
        board.set_cell({x: 1, y: 0}, "O")
        board.set_cell({x: 0, y: 0}, "X")
        board.set_cell({x: 0, y: 1}, "O")
        expect(comp_player.score(board, depth, "X")).to eq(0)
      end

      it "returns 0 if the game is a draw" do
        board.set_cell({x: 0, y: 0}, "X")
        board.set_cell({x: 0, y: 1}, "O")
        board.set_cell({x: 0, y: 2}, "X")
        board.set_cell({x: 1, y: 0}, "O")
        board.set_cell({x: 1, y: 1}, "X")
        board.set_cell({x: 1, y: 2}, "X")
        board.set_cell({x: 2, y: 0}, "O")
        board.set_cell({x: 2, y: 1}, "X")
        board.set_cell({x: 2, y: 2}, "O")
        expect(comp_player.score(board, depth, "O")).to eq(0)
      end
    end

    context "#switch" do
      it "switches current player mark to other player and returns that value" do
        player_marker = "X"
        opponent_marker = "O"
        expect(comp_player.switch(player_marker, opponent_marker)).to eq("O")
      end
    end

    context "#best_move" do
      it "returns the most optimal move for AI" do
        scores = {{x: 0, y: 0} => 10,
          {x: 1, y: 2} => -10}
        expect(comp_player.best_move("X", scores)).to eq([{x: 0, y: 0}, 10])
      end
    end
  end
end
