require_relative "spec_helper"
require_relative "../lib/game"
require_relative "../lib/computer_player"
require_relative "../lib/user_interface"

module TicTacToe
  describe TicTacToe::UserInterface do

    let(:input) { StringIO.new }
    let(:output) { StringIO.new }
    let(:board) { Board.new }
    let(:user_interface) { UserInterface.new(input, output, board) }

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
      it "should receive a valid menu option as user input" do
        input.string = "3"
        expect(user_interface.display_menu).to eq("3")
      end
    end

    context "#display_board" do
      it "should render the board at each game state" do
        grid = [[nil, nil, nil],
                [nil, nil, nil],
                [nil, nil, nil]]
        expect(user_interface.display_board).to eq(grid)
      end
    end
  end
end
