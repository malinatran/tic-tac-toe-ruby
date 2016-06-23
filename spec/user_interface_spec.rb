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
        expect(user_interface).to receive(:display).with("Enter a board size:", "\n", "> ")
        expect(user_interface).to receive(:select_size)
        user_interface.display_size_options
      end
    end

    context "#select_size" do
      it "should call method when user inputs an invalid size" do
        allow(user_interface).to receive(:is_size_valid?).and_return(false, true)
        expect(user_interface).to receive(:display_size_options).with(no_args)
        user_interface.select_size
      end

      it "should return the size if input is valid" do
        size = "5"
        allow(user_interface).to receive(:is_size_valid?).and_return(true)
        allow(user_interface).to receive(:select_size).and_return(size)
      end
    end

    context "#is_size_valid?" do
      it "should return true if size is valid" do
        size = 3
        expect(user_interface.is_size_valid?(size)).to eq(true)
      end

      it "should return false if size is invalid" do
        size = 1000
        expect(user_interface.is_size_valid?(size)).to eq(false)
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
      it "should call method when user inputs an invalid marker" do
        allow(user_interface).to receive(:is_marker_valid?).and_return(false, true)
        expect(user_interface).to receive(:display_marker_options).with(no_args)
        user_interface.select_marker
      end

      it "should return the marker if input is valid" do
        marker = "O"
        allow(user_interface).to receive(:is_marker_valid?).and_return(true)
        allow(user_interface).to receive(:select_marker).and_return(marker)
      end
    end

    context "#is_marker_valid?" do
      it "should return true if marker is valid" do
        marker = "G"
        expect(user_interface.is_marker_valid?(marker)).to eq(true)
      end

      it "should return false if marker is the same as computer marker and therefore invalid" do
        marker = "X"
        expect(user_interface.is_marker_valid?(marker)).to eq(false)
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

    context "#display_move_request" do
      it "should call methods to display message and prompt user for input" do
        size = 3
        expect(user_interface).to receive(:display).with(any_args)
        expect(user_interface).to receive(:select_move)
        user_interface.display_move_request(size)
      end
    end

    context "#select_move" do
      it "should call method to ensure that move is valid" do
        move = 20
        size = 3
        allow(user_interface).to receive(:is_move_valid?).and_return(false, true)
        expect(user_interface).to receive(:display_move_request)
        user_interface.select_move(size)
      end

      it "should return the move if input is valid" do
        move = 4
        allow(user_interface).to receive(:is_move_valid?).and_return(true)
        allow(user_interface).to receive(:select_move).and_return(move)
      end
    end

    context "#is_move_valid?" do
      it "should return true if move is valid" do
        move = 1
        size = 3
        expect(user_interface.is_move_valid?(move, size)).to eq(true)
      end

      it "should return false if move is invalid" do
        move = 10
        size = 3
        expect(user_interface.is_move_valid?(move, size)).to eq(false)
      end
    end
  end
end