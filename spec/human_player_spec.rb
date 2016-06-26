require_relative "spec_helper"
require_relative "../lib/human_player"

module TicTacToe
  describe TicTacToe::HumanPlayer do
    context "#initialize" do
      it "initializes with a marker based on user input" do
        human_player = HumanPlayer.new("M")
        expect(human_player.marker).to eq("M")
      end

      it "initializes with a default marker" do
        human_player = HumanPlayer.new
        expect(human_player.marker).to eq("O")
      end
    end
  end
end

