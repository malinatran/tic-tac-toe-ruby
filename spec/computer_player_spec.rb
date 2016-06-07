require "spec_helper"
require "./board.rb"
require "./computer_player.rb"

module TicTacToe
  describe ComputerPlayer do
    context "#initialize" do
      it "initializes with an identity based on user input" do
        comp_player = ComputerPlayer.new(id: "O")
        expect(comp_player.identity).to eq("O")
      end
      it "initializes with a default identity" do
        comp_player = ComputerPlayer.new
        expect(comp_player.identity).to eq("X")
      end
    end

    context "#get_identity" do
      it "retrieves the player's identity" do
        comp_player = ComputerPlayer.new
        expect(comp_player.get_identity).to eq("X")
      end
    end

    # context "#getCenterMove" do
    #   it "retrieves the center cell" do
    #     board = Board.new
    #     comp_player = ComputerPlayer.new
    #     expect(comp_player.get_center_move).to eq({x: 1, y: 1})
    #   end
    # end
  end
end