require "spec_helper"
require "./game"

module TicTacToe
  describe TicTacToe::Game do
    let(:game) { Game.new }
    before :each do
      srand(1)
    end

    context "#initialize" do
      it "initializes the game with default values" do
        game = Game.new(board: Board.new, computer_player: ComputerPlayer.new, human_player: HumanPlayer.new)
        expect(game.board.size).to eq(3)
        expect(game.computer_player.marker).to eq("X")
        expect(game.human_player.marker).to eq("O")
      end

      it "initializes the game without arguments" do
        expect(game.board).to_not eq(nil)
        expect(game.board.size).to eq(3)
        expect(game.computer_player).to_not eq(nil)
        expect(game.computer_player.marker).to eq("X")
        expect(game.human_player).to_not eq(nil)
        expect(game.human_player.marker).to eq("O")
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
    end

    context "#select_random_player" do
      it "selects one of the players" do
        game = Game.new
        game.select_random_player
        expect(game.current_player).to_not eq(game.opponent_player)
        expect(game.opponent_player).to_not eq(game.current_player)
      end
    end

    context "#switch_player" do
      it "returns the other player who was previously not the current player" do
        game = Game.new
        game.select_random_player
        first_player = game.current_player 
        expect(game.switch_player).to_not eq(first_player)
      end
    end

    context "#winner" do
      it "returns the winner's marker if there is a backward diagonal win" do
        board = Board.new
        game = Game.new(board: board)
        game.select_random_player
        board.set_cell({:x=>0, :y=>0}, "O")
        board.set_cell({:x=>1, :y=>1}, "O")
        board.set_cell({:x=>2, :y=>2}, "O")
        expect(game.winner).to eq("O")
      end

      it "returns the winner's marker if there is a forward diagonal win" do
        board = Board.new
        game = Game.new(board: board)
        game.select_random_player
        board.set_cell({:x=>0, :y=>2}, "X")
        board.set_cell({:x=>1, :y=>1}, "X")
        board.set_cell({:x=>2, :y=>0}, "X")
        expect(game.winner).to eq("X")
      end

      it "returns the winner's marker if there is a row or horizontal win" do
        board = Board.new
        game = Game.new(board: board)
        game.select_random_player
        board.set_cell({:x=>1, :y=>0}, "X")
        board.set_cell({:x=>1, :y=>1}, "X")
        board.set_cell({:x=>1, :y=>2}, "X")
        expect(game.winner).to eq("X")
      end

      it "returns the winner's marker if there is a column or vertical win" do
        board = Board.new
        game = Game.new(board: board)
        game.select_random_player
        board.set_cell({:x=>0, :y=>0}, "O")
        board.set_cell({:x=>0, :y=>1}, "O")
        board.set_cell({:x=>0, :y=>2}, "O")
        expect(game.winner).to eq("O")
      end 

      it "returns nil if there is no winner" do
        board = Board.new
        game = Game.new(board: board)
        game.select_random_player
        board.set_cell({:x=>0, :y=>0}, "O")
        board.set_cell({:x=>0, :y=>1}, "O")
        expect(game.winner).to eq(nil)
      end
    end
  end
end
