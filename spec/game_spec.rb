require "spec_helper"
require "./game"

module TicTacToe
  describe TicTacToe::Game do
    context "#initialize" do
      it "initializes the game with default values" do
        board = Board.new
        computer_player = ComputerPlayer.new(board: board)
        human_player = HumanPlayer.new
        game = Game.new(board, computer_player, human_player)
        expect(game.board.size).to eq(3)
        expect(game.computer_player.marker).to eq("X")
        expect(game.human_player.marker).to eq("O")
      end

      it "initializes the game with values provided by user input" do
        board = Board.new(size: 6)
        computer_player = ComputerPlayer.new(board: board, marker: "E")
        human_player = HumanPlayer.new(marker: "L")
        game = Game.new(board, computer_player, human_player)
        expect(game.board.size).to eq(6)
        expect(game.computer_player.marker).to eq("E")
        expect(game.human_player.marker).to eq("L")
      end

      it "produces a mapped grid" do
        board = Board.new(size: 6)
        computer_player = ComputerPlayer.new(board: board, marker: "E")
        human_player = HumanPlayer.new(marker: "L")
        game = Game.new(board, computer_player, human_player)
        expect(game.map[1]).to eq([0, 0])
      end
    end
  end

  context "#current_player" do
    it "returns the current player" do
      board = Board.new
      computer_player = ComputerPlayer.new(board: board)
      human_player = HumanPlayer.new
      game = Game.new(board, computer_player, human_player)
      expect(game.current_player).to eq(computer_player)
    end
  end

  context "#switch_player" do
    it "returns the other player who was previously not the current player" do
      board = Board.new
      computer_player = ComputerPlayer.new(board: board)
      human_player = HumanPlayer.new
      game = Game.new(board, computer_player, human_player)
      expect(game.switch_player).to eq(human_player)
    end
  end

  context "#create_grid_mapping" do
    it "connects numerical values with positions in two-dimensional array representing the grid" do
      board = Board.new(size: 2)
      computer_player = ComputerPlayer.new(board: board)
      human_player = HumanPlayer.new
      game = Game.new(board, computer_player, human_player)
      mapped_grid = {1=>[0, 0], 2=>[0, 1], 3=>[1, 0], 4=>[1, 1]}
      expect(game.create_grid_mapping(board.size)).to eq(mapped_grid)
    end
  end
end
