require_relative "spec_helper"
require_relative "../lib/player"

module TicTacToe
  describe TicTacToe::Player do

    context "#initialize" do
      it "initializes a player with an optional marker that is passed in as an argument" do
        player = Player.new("M")
        expect(player.marker).to eq("M")        
      end
    end
  end
end
