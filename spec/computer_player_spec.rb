require_relative "spec_helper"
require_relative "../lib/computer_player"

module TicTacToe
  describe TicTacToe::ComputerPlayer do

    let(:comp_player)     { ComputerPlayer.new }
    let(:board)           { Board.new }
    let(:depth)           { 0 }
    let(:current_marker)  { "X" }
    let(:human_marker)    { "O" }

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

    context "#make_move" do
      it "calls a method to select center or top-left cell if the computer is the first player" do
        allow(comp_player).to receive(:is_board_empty?).and_return(true)
        expect(comp_player).to receive(:make_first_move)
        comp_player.make_move(board: board, current_marker: current_marker, human_marker: human_marker)
      end

      it "calls a method to run through minimax algorithm if computer is not the first player" do
        allow(comp_player).to receive(:is_board_empty?).and_return(false)
        expect(comp_player).to receive(:make_minimax_move)
        comp_player.make_move(board: board, current_marker: current_marker, human_marker: human_marker)
      end
    end
  end
end
