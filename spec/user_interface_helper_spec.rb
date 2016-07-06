require_relative "spec_helper"
require_relative "../lib/user_interface_helper"

module TicTacToe
  describe TicTacToe::UserInterfaceHelper do

    let(:input) { StringIO.new }
    let(:output) { StringIO.new }
    let(:helper) { UserInterfaceHelper.new(input, output) }

    context "#get_input" do
      it "receives user input" do
        input.string = "hi"
        expect(input).to receive(:gets).and_return("hi")
        helper.get_input
      end
    end

    context "#display" do
      it "prints a message with a single argument" do
        message = "yo"
        helper.display(message)
        expect(output.string).to eq("yo")
      end
    end

    context "#map_move" do
      it "returns the coordinates of the cell number" do
        move = 5
        size = 3
        expect(helper.map_move(move, size)).to eq({x: 1, y: 1})
      end
    end
 
    context "#draw_board" do
      it "renders a board as a string with each cell's numerical value" do
        board = [[nil, nil], [nil, nil]]
        size = 2
        mapped_board = " 1 | 2 \n 3 | 4 \n"
        expect(helper.draw_board(board, size)).to eq(mapped_board)
      end
    end
  end
end
