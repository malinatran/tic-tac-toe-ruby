require_relative "spec_helper"
require_relative "../lib/computer_player"

module TicTacToe
  describe TicTacToe::ComputerPlayer do

    let (:comp_player) { ComputerPlayer.new }
    let (:board)       { Board.new }

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
        expect(comp_player.minimax(board, "X", "O")).to eq(10)
      end

      it "iterates through relatively complex board and returns move with a score of 10" do
        board.set_cell({x: 0, y: 0}, "O")
        board.set_cell({x: 0, y: 1}, "O")
        board.set_cell({x: 0, y: 2}, "X")
        board.set_cell({x: 1, y: 1}, "X")
        expect(comp_player.minimax(board, "X", "O")).to eq(10)
      end
    end

    context "#score" do
      it "returns score based on whether game winner is AI or human player" do
        board.set_cell({x: 0, y: 0}, "X")
        board.set_cell({x: 1, y: 0}, "X")
        board.set_cell({x: 2, y: 0}, "X")
        expect(comp_player.score(board, "X", "O")).to eq(10)
      end

      it "returns 0 if there is no winner" do
        board.set_cell({x: 0, y: 0}, "X")
        board.set_cell({x: 0, y: 1}, "O")
        board.set_cell({x: 0, y: 2}, "X")
        board.set_cell({x: 1, y: 0}, "O")
        board.set_cell({x: 1, y: 1}, "X")
        board.set_cell({x: 1, y: 2}, "X")
        board.set_cell({x: 2, y: 0}, "O")
        board.set_cell({x: 2, y: 1}, "X")
        board.set_cell({x: 2, y: 2}, "O")
        expect(comp_player.score(board, "X", "O")).to eq(0)
      end
    end

    context "#switch" do
      it "switches current player mark to other player and returns that value" do
        player_marker = "X"
        expect(comp_player.switch(player_marker)).to eq("O")
      end
    end

    context "#best_move" do
      it "returns the most optimal move for AI" do
        scores = {{x: 0, y: 0} => 10,
          {x: 1, y: 2} => -10}
        expect(comp_player.best_move("X", scores)).to eq([{x: 0, y: 0}, 10])
      end
    end

    context "#is_game_over?" do
      it "returns true if there is a win" do
        board.set_cell({x: 0, y: 0}, "X")
        board.set_cell({x: 1, y: 0}, "X")
        board.set_cell({x: 2, y: 0}, "X")
        expect(comp_player.is_game_over?(board, "X")).to eq(true)  
      end

      it "returns true if there is a draw" do
        board.set_cell({x: 0, y: 0}, "X")
        board.set_cell({x: 0, y: 1}, "O")
        board.set_cell({x: 0, y: 2}, "X")
        board.set_cell({x: 1, y: 0}, "O")
        board.set_cell({x: 1, y: 1}, "X")
        board.set_cell({x: 1, y: 2}, "X")
        board.set_cell({x: 2, y: 0}, "O")
        board.set_cell({x: 2, y: 1}, "X")
        board.set_cell({x: 2, y: 2}, "O")
        expect(comp_player.is_game_over?(board, "X")).to eq(true)
      end

      it "returns false if game is not over" do
        board.set_cell({x: 0, y: 0}, "X")
        board.set_cell({x: 1, y: 0}, "O")
        board.set_cell({x: 1, y: 1}, "X")
        expect(comp_player.is_game_over?(board, "O")).to eq(false)
      end
    end

    context "#request_move" do
      it "calls method to get empty cells and rank moves" do
        opponent_marker = "O"
        expect(board).to receive(:get_empty_cells)
        expect(comp_player).to receive(:rank_moves)
        expect(comp_player).to receive(:select_optimal_move)
        comp_player.request_move(board, opponent_marker)
      end
    end

    context "#rank_moves" do
      it "iterates through list of moves and returns array of hashes" do
        board.set_cell({x: 0, y: 0}, "X")
        board.set_cell({x: 1, y: 0}, "X")
        board.set_cell({x: 0, y: 1}, "O")
        board.set_cell({x: 1, y: 1}, "O")
        moves = [{x: 0, y: 2}, {x: 1, y: 2}, {x: 2, y: 0}, {x: 2, y: 1}, {x: 2, y: 2}] 
        scores = {{x: 2, y: 0} => 10,
          {x: 2, y: 1} => -10,
          {x: 0, y: 2} => 0,
          {x: 1, y: 2} => 0,
          {x: 2, y: 2} => 0}
        expect(comp_player.rank_moves(board, moves, "O")).to eq(scores)
      end
    end

    context "#select_optimal_move" do
      it "returns a move with a score of 10 to secure win" do
        scores = {{x: 2, y: 1} => -10,
          {x: 0, y: 2} => 0,
          {x: 2, y: 0} => 10,
          {x: 1, y: 2} => 0,
          {x: 2, y: 2} => 0}
        expect(comp_player.select_optimal_move(scores)).to eq({x: 2, y: 0})
      end

      it "returns a blocking move with a score of -10, if a winning move is unavailable" do
        scores = {{x: 2, y: 1} => -10,
          {x: 0, y: 2} => 0,
          {x: 1, y: 2} => 0,
          {x: 2, y: 2} => 0}
        expect(comp_player.select_optimal_move(scores)).to eq({x: 2, y: 1})
      end

      it "returns a move with a score of 0, if a blocking move is unavailable" do
        scores = {{x: 0, y: 2} => 0,
          {x: 1, y: 2} => 0,
          {x: 2, y: 2} => 0}
        expect(comp_player.select_optimal_move(scores)).to eq({x: 0, y: 2})
      end
    end

    context "#is_winning_move?" do
      it "returns true if cell fills a row" do
        board.set_cell({x: 0, y: 0}, "X")
        board.set_cell({x: 0, y: 1}, "X")
        move = {x: 0, y: 2}
        marker = "X"
        expect(comp_player.is_winning_move?(board, move, marker)).to eq(true)
      end

      it "returns true if cell fills a column" do
        board.set_cell({x: 0, y: 1}, "X")
        board.set_cell({x: 1, y: 1}, "X")
        move = {x: 2, y: 1}
        marker = "X"
        expect(comp_player.is_winning_move?(board, move, marker)).to eq(true)
      end

      it "returns true if cell fills a diagonal" do
        board.set_cell({x: 0, y: 0}, "O")
        board.set_cell({x: 2, y: 2}, "O")
        move = {x: 1, y: 1}
        marker = "O"
        expect(comp_player.is_winning_move?(board, move, marker)).to eq(true)
      end
    end
  end
end
