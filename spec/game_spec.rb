require_relative "spec_helper"
require_relative "../lib/game"
require_relative "../lib/computer_player"
require_relative "../lib/human_player"

module TicTacToe
  describe TicTacToe::Game do
    let(:board) { Board.new }
    let(:computer_player) { ComputerPlayer.new }
    let(:human_player) { HumanPlayer.new }
    let(:game) { Game.new(board: board, 
                          computer_player: computer_player, 
                          human_player: human_player) }

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
  end
end
