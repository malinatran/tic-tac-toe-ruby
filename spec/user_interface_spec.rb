require_relative "spec_helper"
require_relative "../lib/user_interface"
require_relative "../lib/board"

module TicTacToe
  describe TicTacToe::UserInterface do

    let(:input) { StringIO.new }
    let(:output) { StringIO.new }
    let(:user_interface) { UserInterface.new(input, output) }

    context "#get_input" do
      it "should receive user input" do
        example = "testing"
        input.string = example
        expect(user_interface.get_input).to eq("testing")
      end
    end

    context "#display_menu" do
      it "should call methods to display message and allow user input" do
        size = 3
        marker = "O"
        expect(user_interface).to receive(:display).with(any_args)
        expect(user_interface).to receive(:select_menu)
        user_interface.display_menu(size, marker)
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

    context "#select_size" do
      it "should return a size if size is valid" do
        size = "8"
        input.string = size
        expect(user_interface.select_size).to eq(8)
      end
    end

    context "#display_marker_options" do
      it "should call methods to display message and allow user input to select marker" do
        expect(user_interface).to receive(:display).with(any_args)
        expect(user_interface).to receive(:select_marker)
        user_interface.display_marker_options
      end
    end

    context "#select_marker" do
      it "should return a marker if marker is valid" do
        marker = "O"
        input.string = marker
        expect(user_interface.select_marker).to eq("O")
      end
    end

    context "#display_board" do
      board = TicTacToe::Board.new

      it "should call a method to display the baord" do
        expect(user_interface).to receive(:display).with(any_args)
        user_interface.display_board(board)
      end

      it "should render a default 3x3 board with each cell's numerical value" do
        expect(user_interface).to receive(:display).with("The board:", "\n", "1 | 2 | 3\n4 | 5 | 6\n7 | 8 | 9\n")
        user_interface.display_board(board)
      end
    end

    context "#request_move" do
      it "should call methods to display message and prompt user for input" do
        size = 3
        expect(user_interface).to receive(:display).with(any_args)
        expect(user_interface).to receive(:select_move)
        user_interface.request_move(size)
      end
    end

    context "#select_move" do
      it "should call method to ensure that move is valid" do
        size = 3
        move = "1"
        input.string = move
        expect(user_interface.select_move(size)).to eq(1)
      end
    end
  end
end
