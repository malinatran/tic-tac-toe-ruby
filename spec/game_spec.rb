require "spec_helper"
require "./game"

module TicTacToe
  describe TicTacToe::Game do
    context "#initialize" do
      it "initializes the game with default values" do
        game = Game.new(board: Board.new, computer_player: ComputerPlayer.new, human_player: HumanPlayer.new)
        expect(game.board.size).to eq(3)
        expect(game.computer_player.marker).to eq("X")
        expect(game.human_player.marker).to eq("O")
      end

      it "initializes the game without arguments" do
        game = Game.new
        expect(game.board).to_not eq(nil)
        expect(game.board.size).to eq(3)
      end

      it "initializes the game with values provided by user input" do
        board = Board.new(size: 6)
        computer_player = ComputerPlayer.new(marker: "E")
        human_player = HumanPlayer.new(marker: "L")
        game = Game.new(board: board, computer_player: computer_player, human_player: human_player)
        expect(game.board.size).to eq(6)
        expect(game.computer_player.marker).to eq("E")
        expect(game.human_player.marker).to eq("L")
      end

      it "produces a mapped grid with first value always being at [0, 0]" do
        game = Game.new
        expect(game.map[1]).to eq([0, 0])
      end

      it "produces a mapped grid enumerated from left to right, top to bottom" do
        game = Game.new
        expect(game.map[5]).to eq([1, 1])
      end
    end
  end

  context "#current_player" do
    it "returns the current player" do
      game = Game.new
      expect(game.current_player).to eq(game.computer_player)
    end
  end

  context "#switch_player" do
    it "returns the other player who was previously not the current player" do
      game = Game.new
      expect(game.switch_player).to eq(game.human_player)
    end
  end

  context "#create_grid_mapping" do
    it "connects numerical values with positions in two-dimensional array representing the grid" do
      board = Board.new(size: 2)
      game = Game.new(board: board)
      mapped_grid = {1=>[0, 0], 2=>[0, 1], 3=>[1, 0], 4=>[1, 1]}
      expect(game.create_grid_mapping(board.size)).to eq(mapped_grid)
    end
  end
end
