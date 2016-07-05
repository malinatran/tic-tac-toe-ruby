require_relative "spec_helper"
require_relative "../lib/input_validator"

module TicTacToe
  describe TicTacToe::InputValidator do

    let(:validator) { InputValidator.new }

    context "#is_size_valid?" do
      it "returns true if size is between 2 and 10" do
        size = 5
        expect(validator.is_size_valid?(size)).to eq(true)
      end

      it "returns false if size is greater than 10" do
        size = 11
        expect(validator.is_size_valid?(size)).to eq(false)
      end

      it "returns false if size is less than 3" do
        size = 1
        expect(validator.is_size_valid?(size)).to eq(false)
      end
    end

    context "#is_marker_valid?" do
      it "returns true if marker is not an 'X' and longer than a single character" do
        marker = "M"
        expect(validator.is_marker_valid?(marker)).to eq(true)
      end

      it "returns false if marker is a lowercase 'x'" do
        marker = "x"
        expect(validator.is_marker_valid?(marker)).to eq(false)
      end

      it "returns false if marker is an 'X' and longer than a single character" do
        marker = "XO"
        expect(validator.is_marker_valid?(marker)).to eq(false)
      end
    end

    context "#is_move_valid?" do
      it "returns true if move's cell number is within the board" do
        move = 2
        size = 3
        expect(validator.is_move_valid?(move, size)).to eq(true)
      end

      it "returns false if move's cell number does not exist in the board" do
        move = 10
        size = 3
        expect(validator.is_move_valid?(move, size)).to eq(false)
      end
    end
  end
end
