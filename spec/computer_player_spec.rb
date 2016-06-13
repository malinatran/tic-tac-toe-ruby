require "spec_helper"
require "./board"
require "./player"
require "./computer_player"

module TicTacToe
  describe TicTacToe::ComputerPlayer do
    context "#initialize" do
      it "initializes with a marker based on user input" do
        comp_player = ComputerPlayer.new(marker: "O", board: Board.new)
        expect(comp_player.marker).to eq("O")
      end
      
      it "initializes with a default marker" do
        comp_player = ComputerPlayer.new(board: Board.new)
        expect(comp_player.marker).to eq("X")
      end
    end

    context "#get_center_move" do
      it "retrieves the center cell of a 3x3 grid" do
        comp_player = ComputerPlayer.new(board: Board.new)
        expect(comp_player.get_center_move).to eq({x: 1, y: 1})
      end
    
      it "retrieves the center cell of a 5x5 grid" do
        comp_player = ComputerPlayer.new(board: Board.new(size: 5))
        expect(comp_player.get_center_move).to eq({:x=>2, :y=>2})
      end

      it "returns nil if there is no center cell (e.g. 2x2) on the grid" do
        comp_player = ComputerPlayer.new(board: Board.new(size: 2))
        expect{comp_player.get_center_move}.to raise_error(NoCenterCellError)
      end
    end

    context "#get_winning_move" do
      it "retrieves the cell that would fill either a row, column, or diagonal" do
        board = Board.new
        comp_player = ComputerPlayer.new(board: board)
        board.set_cell(2, 0, "O")
        board.set_cell(2, 1, "O")
        board.set_cell(0, 0, "X")
        board.set_cell(1, 0, "X")
        expect(comp_player.get_winning_move("O")).to eq({x: 2, y: 2})
      end

      it "retrieves the cell that would fill a row" do
        board = Board.new
        comp_player = ComputerPlayer.new(board: board)
        board.set_cell(0, 0, "X")
        board.set_cell(0, 1, "X")
        board.set_cell(1, 0, "X")
        board.set_cell(1, 1, "O")
        board.set_cell(1, 2, "X") 
        board.set_cell(2, 0, "O")
        expect(comp_player.get_winning_move("X")).to eq({x: 0, y: 2})
      end

      it "retrieves the cell that would fill a column" do
        board = Board.new
        comp_player = ComputerPlayer.new(board: board)
        board.set_cell(2, 2, "X")
        board.set_cell(2, 1, "X")
        board.set_cell(2, 0, "O")
        board.set_cell(1, 0, "O")
        expect(comp_player.get_winning_move("O")).to eq({x: 0, y: 0})
      end

      it "retrieves the cell that would fill a diagonal" do
        board = Board.new
        comp_player = ComputerPlayer.new(board: board)
        board.set_cell(0, 0, "O")
        board.set_cell(1, 1, "X")
        board.set_cell(0, 2, "X")
        board.set_cell(1, 2, "O")
        expect(comp_player.get_winning_move("X")).to eq({x: 2, y: 0})
      end
    end

    context "#get_corner_move" do
      it "retrieves one of the four corner cells of a grid" do
        comp_player = ComputerPlayer.new(board: Board.new)
        expect(comp_player.get_corner_move).to eq({x: 0, y: 0})
      end

      it "retrieves another corner cell if previous cell(s) already have an marker" do
        board = Board.new
        comp_player = ComputerPlayer.new(board: board)
        board.set_cell(0, 0, "X")
        board.set_cell(0, 2, "O")
        expect(comp_player.get_corner_move).to eq({x: 2, y: 0})
      end

      it "returns nil if all corner cells already have an marker" do
        board = Board.new(size: 2)
        comp_player = ComputerPlayer.new(board: board)
        board.set_cell(0, 0, "X")
        board.set_cell(0, 1, "O")
        board.set_cell(1, 0, "X")
        board.set_cell(1, 1, "O")
        expect(comp_player.get_corner_move).to eq(nil)
      end
    end

    context "#get_random_move" do
      it "returns an available cell" do 
        board = Board.new(size: 2)
        comp_player = ComputerPlayer.new(board: board)
        board.set_cell(0, 0, "X")
        expect(comp_player.get_random_move).not_to eq({x: 0, y: 0}) 
      end
    end
  end
end
