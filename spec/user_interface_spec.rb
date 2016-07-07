require_relative "spec_helper"
require_relative "../lib/board"
require_relative "../lib/user_interface"

module TicTacToe
  describe TicTacToe::UserInterface do

    let(:input)           { StringIO.new }
    let(:output)          { StringIO.new }
    let(:ui_helper)       { UserInterfaceHelper.new(input, output) }
    let(:validator)       { InputValidator.new }
    let(:user_interface)  { UserInterface.new(ui_helper, validator) }
    let(:board)           { Board.new.grid }

    context "#initialize" do
      it "receives an argument and sets instance variables" do
        expect(user_interface.instance_variable_get(:@ui_helper)).to eq(ui_helper)
        expect(user_interface.instance_variable_get(:@size)).to eq(3)
        expect(user_interface.instance_variable_get(:@marker)).to eq("O")
      end
    end

    context "#get_options" do
      it "displays welcome message and menu" do
        user_interface.instance_variable_set(:@quit_game, true)
        input.string = "1"
        input.string.to_i
        allow(ui_helper).to receive(:get_integer)
        expect(user_interface).to receive(:display).exactly(2).times
        user_interface.get_options
      end

      it "calls a method to select size when user provides an input" do
        user_interface.instance_variable_set(:@quit_game, true)
        input.string = "1"
        input.string.to_i
        allow(ui_helper).to receive(:get_integer).and_return(1)
        expect(user_interface).to receive(:select_size)
        user_interface.get_options
      end
    end

    context "#get_move" do
      it "calls a method to translate the cell number to a hash of coordinates" do
        allow(validator).to receive(:is_move_valid?).and_return(true)
        input.string = "1"
        expect(validator).to receive(:translate_move)
        user_interface.get_move(board)
      end

      it "takes in the move that user input and returns an integer" do
        allow(user_interface).to receive(:display_board)
        allow(validator).to receive(:is_move_valid?).and_return(true)
        input.string = "5"
        expect(ui_helper).to receive(:get_integer).and_return(5)
        user_interface.get_move(board)
      end

      it "translates the move into a hash of coordinates" do
        allow(user_interface).to receive(:display_board)
        allow(validator).to receive(:is_move_valid?).and_return(true)
        input.string = "5"
        size = 3
        move = input.string.to_i
        expect(validator).to receive(:translate_move).and_return({x: 1, y: 1})
        user_interface.get_move(board)
      end
    end

    context "#display_error" do
      it "displays a mesage and new lines" do 
        error = "You cannot do that"
        expect(user_interface).to receive(:display)
        user_interface.display_error(error)
      end
    end

    context "#display_board" do
      it "calls several methods to display the baord" do
        expect(ui_helper).to receive(:display_board)
        user_interface.display_board(board)
      end

      it "calls a method to render a board with each cell's numerical value" do
        size = 3
        expect(ui_helper).to receive(:display_board).and_return(
          "\n 1 | 2 | 3 \n 4 | 5 | 6 \n 7 | 8 | 9 \n\n")
          user_interface.display_board(board)
      end
    end

    context "#display_outcome" do
      it "displays message that nobody won when there is a draw" do
        outcome = "Draw" 
        expect(ui_helper).to receive(:display_outcome).and_return("Nobody won!\n")
        user_interface.display_outcome(outcome)
      end

      it "displays message about computer winning when computer wins" do
        outcome = "X"
        expect(ui_helper).to receive(:display_outcome).and_return("Computer won!\n")
        user_interface.display_outcome(outcome)
      end
    end
  end
end
