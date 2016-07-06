require_relative "spec_helper"
require_relative "../lib/board"
require_relative "../lib/human_player"
require_relative "../lib/user_interface"

module TicTacToe
  describe TicTacToe::HumanPlayer do

    let(:board)           { Board.new }
    let(:human_player)    { HumanPlayer.new }
    let(:ui_helper)       { UserInterfaceHelper.new }
    let(:user_interface)  { UserInterface.new(ui_helper, validator) }
    let(:validator)       { InputValidator.new }

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

    context "#make_move" do
      it "calls methods to display board and and select move" do
        expect(user_interface).to receive(:display_board)
        expect(user_interface).to receive(:select_move)
        human_player.make_move(user_interface: user_interface, board: board)
      end
    end
  end
end

