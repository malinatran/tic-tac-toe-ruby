require "spec_helper"
require "./board"
require "./computer_player"

module TicTacToe
  describe ComputerPlayer do
    context "#initialize" do
      it "initializes with an identity based on user input" do
        comp_player = ComputerPlayer.new(id: "O", board: Board.new)
        expect(comp_player.identity).to eq("O")
      end
      it "initializes with a default identity" do
        comp_player = ComputerPlayer.new(board: Board.new)
        expect(comp_player.identity).to eq("X")
      end
    end

    context "#getIdentity" do
      it "retrieves the player's identity" do
        comp_player = ComputerPlayer.new(board: Board.new)
        expect(comp_player.get_identity).to eq("X")
      end
    end

    context "#getCenterMove" do
      it "retrieves the center cell of a 3x3 grid" do
        comp_player = ComputerPlayer.new(board: Board.new)
        expect(comp_player.get_center_move).to eq({:x=>1, :y=>1})
      end
      it "retrieves the center cell of a 5x5 grid" do
        comp_player = ComputerPlayer.new(board: Board.new(size: 5))
        expect(comp_player.get_center_move).to eq({:x=>2, :y=>2})
      end
      it "returns nil if there is no center cell (e.g. 2x2) on the grid" do
        comp_player = ComputerPlayer.new(board: Board.new(size: 2))
        expect(comp_player.get_center_move).to eq(nil)
      end
    end

    context "#getCornerMove" do
      it "retreives one of the four corner cells of a grid" do
        comp_player = ComputerPlayer.new(board: Board.new)
        expect(comp_player.get_corner_move).to eq({:x=>0, :y=>0})
      end
      it "retrieves another corner cell if previous cell(s) already have an identity" do
        board = Board.new
        comp_player = ComputerPlayer.new(board: board)
        board.set_cell(0, 0, "X")
        board.set_cell(0, 2, "O")
        expect(comp_player.get_corner_move).to eq({:x=>2, :y=>0})
      end
      it "returns nil if all corner cells already have an identity" do
        board = Board.new(size: 2)
        comp_player = ComputerPlayer.new(board: board)
        board.set_cell(0, 0, "X")
        board.set_cell(0, 1, "O")
        board.set_cell(1, 0, "X")
        board.set_cell(1, 1, "O")
        expect(comp_player.get_corner_move).to eq(nil)
      end
    end
  end
end
