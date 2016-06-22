require_relative "spec_helper"
require_relative "../lib/game"
require_relative "../lib/computer_player"
require_relative "../lib/human_player"
require_relative "../lib/user_interface"

module TicTacToe
  describe TicTacToe::UserInterface do

    let(:input) { StringIO.new }
    let(:output) { StringIO.new }
    let(:board) { Board.new }
    let(:human_player) { HumanPlayer.new }
    let(:user_interface) { UserInterface.new(board: board, human_player: human_player, input: input, output: output) }

    context "#get_input" do
      it "should receive user input" do 
        input.string = "testing"
        expect(user_interface.get_input).to eq("testing")
      end
    end

    context "#display" do
      it "should print a message in the command line" do
        user_interface.display("yo")
        expect(output.string).to eq("yo")
      end

      it "should print multiple messages in the command line" do
        user_interface.display("yo\n", "hello\n")
        expect(output.string).to eq("yo\nhello\n")
      end
    end

    context "#display_menu" do
      it "should call methods to display message and allow user input" do
        expect(user_interface).to receive(:display).with(any_args)
        expect(user_interface).to receive(:select_menu)
        user_interface.display_menu
      end
    end

    context "#select_menu" do
      it "should call a method when user inputs correct value" do
        input.string = "3"
        expect(user_interface).to receive(:start_game)
        user_interface.select_menu
      end
    end
    
    context "#display_size_options" do
      it "should call methods to display message and allow user input to select board size" do
        expect(user_interface).to receive(:display).with(any_args)
        expect(user_interface).to receive(:select_size)
        user_interface.display_size_options
      end
    end

    context "#display_marker_options" do
      it "should call methods to display message and allow user input to select marker" do
        expect(user_interface).to receive(:display).with(any_args)
        expect(user_interface).to receive(:select_marker)
        user_interface.display_marker_options
      end
    end

    context "#start_game" do
      it "should select and announce a player as current player" do
      end
    end

    context "#draw_board" do
      it "should render the board with each cell's numerical value" do
        board = "1 | 2 | 3\n4 | 5 | 6\n7 | 8 | 9\n"
        expect(user_interface.draw_board).to eq(board)
      end
    end
  end
end
