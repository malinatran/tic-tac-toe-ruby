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
      it "prints a prompt sign and receives user input" do
        input.string = "hi"
        expect(helper).to receive(:print_prompt)
        expect(input).to receive(:gets).and_return("hi")
        helper.get_string
      end
    end

    context "#get_integer" do
      it "calls a method to print a prompt sign" do
        input.string = "1"
        expect(helper).to receive(:print_prompt)
        helper.get_integer
      end

      it "returns the value of user input as an integer" do
        input.string = "2"
        expect(helper).to receive(:print_prompt)
        expect(helper.get_integer).to eq(2)
      end
    end

    context "#display" do
      it "prints a message with a single argument" do
        message = "yo"
        helper.display(message)
        expect(output.string).to eq("yo\n")
      end

      it "prints a message with several arguments" do
        prompt = "\n"
        greeting = "aloha"
        helper.display(prompt, greeting)
        expect(output.string).to eq("\naloha\n")
      end
    end

    context "#display_board" do
      it "calls the display method to draw the board" do
        expect(helper).to receive(:display).with(any_args)
        helper.display_board(board.grid, board.size)
      end
    end
  end
end
