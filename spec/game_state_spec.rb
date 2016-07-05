require_relative "spec_helper"
require_relative "../lib/game_state"
require_relative "../lib/computer_player"
require_relative "../lib/human_player"
require_relative "../lib/board"

module TicTacToe

  comp_player = ComputerPlayer.new
  human_player = HumanPlayer.new
  markers = ["O", "X"]

  context "#is_game_over?" do
    it "should return true if there is a win or draw" do
      board = Board.new
      board.set_cell({x: 0, y: 0}, "O")
      board.set_cell({x: 0, y: 1}, "O")
      board.set_cell({x: 0, y: 2}, "O")
      expect(TicTacToe.is_game_over?(board, markers)).to eq(true)
    end

    it "should return false if the game is still continuing" do
      board = Board.new(2)
      board.set_cell({x: 0, y: 0}, "O")
      expect(TicTacToe.is_game_over?(board, markers)).to eq(false)
    end
  end

  context "#win?" do
    it "should return true if there is a winner in the game" do
      board = Board.new
      board.set_cell({x: 0, y: 0}, "X")
      board.set_cell({x: 0, y: 1}, "X")
      board.set_cell({x: 0, y: 2}, "X")
      expect(TicTacToe.win?(board, markers)).to eq(true)
    end

    it "should return false if there is no winner" do
      board = Board.new
      board.set_cell({x: 0, y: 0}, "X")
      board.set_cell({x: 0, y: 1}, "X")
      expect(TicTacToe.win?(board, markers)).to eq(false)
    end
  end

  context "#draw?" do
    it "should return true if there is a tie in the game" do
      board = Board.new
      board.set_cell({x: 0, y: 0}, "O")
      board.set_cell({x: 0, y: 1}, "X")
      board.set_cell({x: 0, y: 2}, "O")
      board.set_cell({x: 1, y: 0}, "X")
      board.set_cell({x: 1, y: 1}, "O")
      board.set_cell({x: 1, y: 2}, "O")
      board.set_cell({x: 2, y: 0}, "X")
      board.set_cell({x: 2, y: 1}, "O")
      board.set_cell({x: 2, y: 2}, "X")
      expect(TicTacToe.draw?(board, markers)).to eq(true)
    end

    it "should return false if there isn't a tie in the game" do
      board = Board.new
      board.set_cell({x: 0, y: 0}, "X")
      board.set_cell({x: 2, y: 2}, "X")
      expect(TicTacToe.draw?(board, markers)).to eq(false)
    end
  end

  context "#is_winner?" do
    it "should return true if winner passed in argument is the winner" do
      board = Board.new
      board.set_cell({x: 0, y: 0}, "X")
      board.set_cell({x: 0, y: 1}, "X")
      board.set_cell({x: 0, y: 2}, "X")
      expect(TicTacToe.is_winner?(board, "X")).to eq(true)
    end

    it "should return false if there is no winner" do
      board = Board.new
      board.set_cell({x: 0, y: 0}, "O")
      board.set_cell({x: 0, y: 1}, "X")
      board.set_cell({x: 0, y: 2}, "X")
      expect(TicTacToe.is_winner?(board, "X")).to eq(false)
    end
  end
end
