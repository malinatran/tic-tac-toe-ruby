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
        allow(ui_helper).to receive(:get_input)
        expect(ui_helper).to receive(:display).exactly(2).times
        user_interface.get_options
      end

      it "calls a method to select size when user provides an input" do
        user_interface.instance_variable_set(:@quit_game, true)
        input.string = "1"
        input.string.to_i
        allow(ui_helper).to receive(:get_input).and_return("1")
        expect(user_interface).to receive(:select_size)
        user_interface.get_options
      end
    end

    context "#display_error" do
      it "displays a mesage and new lines" do 
        message = "You cannot do that"
        expect(ui_helper).to receive(:display)
        user_interface.display_error(message)
      end
    end

    context "#select_size" do
      it "converts size input by user to an integer" do
        input.string = "4"
        allow(ui_helper).to receive(:display)
        expect(ui_helper.get_input.to_i).to eq(4)
      end

      it "returns the size if input is valid" do
        input.string = "3"
        allow(ui_helper).to receive(:get_input).and_return(3)
        allow(validator).to receive(:is_size_valid?).and_return(true)
        expect(user_interface.select_size).to eq(3)
      end
    end

    context "#select_marker" do
      it "returns the marker if input is valid" do
        input.string = "Y"
        allow(ui_helper).to receive(:get_input).and_return("Y")
        allow(validator).to receive(:is_marker_valid?).and_return(true)
        expect(user_interface.select_marker).to eq("Y")
      end
    end

    context "#select_move" do
      it "calls a method to translate the cell number to a hash of coordinates" do
        allow(validator).to receive(:is_move_valid?).and_return(true)
        input.string = "1"
        expect(ui_helper).to receive(:map_move)
        user_interface.select_move
      end

      it "converts move input by user to an integer" do
        input.string = "2"
        allow(ui_helper).to receive(:display)
        expect(ui_helper.get_input.to_i).to eq(2)
      end

      it "returns the move if input is valid" do
        allow(validator).to receive(:is_move_valid?).and_return(true)
        input.string = "5"
        user_interface.instance_variable_set(:@size, 3)
        allow(ui_helper).to receive(:get_input).and_return(5)
        expect(ui_helper).to receive(:map_move).and_return({x: 1, y: 1})
        user_interface.select_move
      end
    end

    context "#display_board" do
      it "calls several methods to display the baord" do
        user_interface.instance_variable_set(:@size, 3)
        expect(ui_helper).to receive(:display)
        expect(ui_helper).to receive(:draw_board)
        user_interface.display_board(board)
      end

      it "calls a method to render a board with each cell's numerical value" do
        size = 3
        expect(ui_helper).to receive(:display).and_return(
          "\n 1 | 2 | 3 \n 4 | 5 | 6 \n 7 | 8 | 9 \n\n")
          user_interface.display_board(board)
      end
    end

    context "#display_outcome" do
      it "displays message that nobody won when there is a draw" do
        outcome = "Draw" 
        expect(ui_helper).to receive(:display).exactly(2).times.and_return("Nobody won!\n")
        user_interface.display_outcome(outcome)
      end

      it "displays message about computer winning when computer wins" do
        outcome = "X"
        expect(ui_helper).to receive(:display).exactly(2).times.and_return("Computer won!\n")
        user_interface.display_outcome(outcome)
      end
    end
  end
end
