require_relative "spec_helper"
require_relative "../lib/user_interface_helper"

module TicTacToe
  describe TicTacToe::Helper do
    let(:input) { StringIO.new }
    let(:output) { StringIO.new }
    let(:helper) { Helper.new(input, output) }

    context "#get_input" do
      it "prints prompt" do
        input.string = "hey"
        expect(helper).to receive(:display)
        helper.get_input
      end

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

    context "#is_size_valid?" do
      it "returns true if size is between 2 and 10" do
        size = 5
        expect(helper.is_size_valid?(size)).to eq(true)
      end

      it "returns false if size is greater than 10" do
        size = 11
        expect(helper.is_size_valid?(size)).to eq(false)
      end

      it "returns false if size is less than 3" do
        size = 1
        expect(helper.is_size_valid?(size)).to eq(false)
      end
    end

    context "#is_marker_valid?" do
      it "returns true if marker is not an 'X' and longer than a single character" do
        marker = "M"
        expect(helper.is_marker_valid?(marker)).to eq(true)
      end

      it "returns false if marker is a lowercase 'x'" do
        marker = "x"
        expect(helper.is_marker_valid?(marker)).to eq(false)
      end

      it "returns false if marker is an 'X' and longer than a single character" do
        marker = "XO"
        expect(helper.is_marker_valid?(marker)).to eq(false)
      end
    end

    context "#is_move_valid?" do
      it "returns true if move's cell number is within the board" do
        move = 2
        size = 3
        expect(helper.is_move_valid?(move, size)).to eq(true)
      end

      it "returns false if move's cell number does not exist in the board" do
        move = 10
        size = 3
        expect(helper.is_move_valid?(move, size)).to eq(false)
      end
    end
  end
end
