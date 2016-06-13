require "spec_helper"
require "./human_player"

module TicTacToe
  describe TicTacToe::HumanPlayer do
    context "#initialize" do
      it "initializes with an identity based on user input" do
        human_player = HumanPlayer.new(id: "MT")
        expect(human_player.identity).to eq("MT")
      end

      it "initializes with a default identity" do
        human_player = HumanPlayer.new
        expect(human_player.identity).to eq("O")
      end
    end
  end
end

