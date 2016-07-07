require_relative "spec_helper"
require_relative "../lib/board"
require_relative "../lib/user_interface_helper"

module TicTacToe
  describe TicTacToe::UserInterfaceHelper do

    let(:board)   { Board.new }
    let(:input)   { StringIO.new }
    let(:output)  { StringIO.new }
    let(:helper)  { UserInterfaceHelper.new(input, output) }

    context "#get_string" do
      it "receives user input" do
        input.string = "hi"
        expect(input).to receive(:gets).and_return("hi")
        helper.get_string
      end
    end

    context "#get_integer" do
      it "receives user input and converts into integer" do
        input.string = "1"
        expect(input).to receive(:gets).and_return("1")
        helper.get_integer
      end
    end

    context "#display" do
      it "prints a message with a single argument" do
        message = "yo"
        helper.display(message)
        expect(output.string).to eq("yo")
      end
    end

    context "#display_outcome" do
      it "calls the display method depending on game's outcome" do
        outcome = "Draw"
        expect(helper).to receive(:display).and_return("Nobody won!\n")
        helper.display_outcome(outcome)
      end
    end

    context "#display_board" do
      it "calls the display method to draw the board" do
        board = Board.new
        expect(helper).to receive(:display).with(any_args)
        helper.display_board(board.grid, board.size)
      end
    end
  end
end
