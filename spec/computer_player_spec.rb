require "spec_helper"
require "./board"
require "./player"
require "./computer_player"

module TicTacToe
  describe TicTacToe::ComputerPlayer do
    let (:board) { Board.new }
    let (:comp_player) { ComputerPlayer.new(board: board) }

    context "#initialize" do
      it "initializes with a marker based on user input" do
        comp_player = ComputerPlayer.new(marker: "O")
        expect(comp_player.marker).to eq("O")
      end

      it "initializes with a default marker" do
        comp_player = ComputerPlayer.new
        expect(comp_player.marker).to eq("X")
      end
    end

    context "#request_move" do
      it "returns center cell as the first move for any given game" do
        expect(comp_player.request_move(board: board, size: 3, opponent_marker: "M")).to eq({x: 1, y: 1})
      end

      it "returns the winning cell that is first available and most optimal for winning" do
        board.set_cell({:x=>1, :y=>1}, "O")
        board.set_cell({:x=>0, :y=>2}, "X")
        board.set_cell({:x=>1, :y=>0}, "O")
        board.set_cell({:x=>2, :y=>0}, "O")
        expect(comp_player.request_move(board: board, size: 3, opponent_marker: "O")).to eq({x: 0, y: 0})
      end

      it "returns the first corner cell that is available" do
        board.set_cell({:x=>0, :y=>0}, "X")
        board.set_cell({:x=>1, :y=>1}, "X")
        board.set_cell({:x=>0, :y=>1}, "O")
        board.set_cell({:x=>0, :y=>2}, "X")
        board.set_cell({:x=>1, :y=>0}, "O")
        board.set_cell({:x=>2, :y=>0}, "O")
        expect(comp_player.request_move(board: board, size: 3, opponent_marker: "O")).to eq({x: 2, y: 2})
      end
    end

    context "#get_center_move" do
      it "retrieves the center cell of a 3x3 grid" do
        board = Board.new(size: 3)
        comp_player = ComputerPlayer.new
        comp_player.request_move(board: board, size: 3)
        expect(comp_player.get_center_move).to eq({x: 1, y: 1})
      end

      it "retrieves the center cell of a 5x5 grid" do
        board = Board.new
        comp_player = ComputerPlayer.new
        comp_player.request_move(board: board, size: 5)
        expect(comp_player.get_center_move).to eq({x: 2, y: 2}) 
      end
    end

    context "#get_winning_move" do
      it "retrieves the cell that would fill a row" do
        board.set_cell({:x=>0, :y=>0}, "X")
        board.set_cell({:x=>0, :y=>1}, "X")
        expect(comp_player.get_winning_move("X")).to eq({x: 0, y: 2})
      end

      it "retrieves the cell that would fill a column" do
        board.set_cell({:x=>2, :y=>2}, "X")
        board.set_cell({:x=>2, :y=>1}, "X")
        expect(comp_player.get_winning_move("X")).to eq({x: 2, y: 0})
      end

      it "returns nil if there is no center cell (e.g. 2x2) on the grid" do
        board = Board.new
        comp_player = ComputerPlayer.new
        comp_player.request_move(board: board, size: 2, opponent_marker: "O") 
        expect(comp_player.get_center_move).to eq(nil) 
      end
    end

    context "#get_winning_move" do
      it "retrieves the cell that would fill either a row, column, or diagonal" do
        board.set_cell({:x=>2, :y=>0}, "O")
        board.set_cell({:x=>2, :y=>1}, "O")
        board.set_cell({:x=>0, :y=>0}, "O")
        board.set_cell({:x=>1, :y=>0}, "X")
        expect(comp_player.get_winning_move("O")).to eq({x: 2, y: 2})
      end

      it "retrieves the cell that would fill a row" do
        comp_player.request_move(board: board)
        board.set_cell({:x=>0, :y=>0}, "X")
        board.set_cell({:x=>0, :y=>1}, "X")
        expect(comp_player.get_winning_move("X")).to eq({x: 0, y: 2})
      end

      it "retrieves the cell that would fill a column" do
        board.set_cell({:x=>2, :y=>2}, "X")
        board.set_cell({:x=>2, :y=>1}, "X")
        board.set_cell({:x=>2, :y=>0}, "O")
        board.set_cell({:x=>1, :y=>0}, "O")
        expect(comp_player.get_winning_move("O")).to eq({x: 0, y: 0})
      end

      it "retrieves the cell that would fill a diagonal" do
        board.set_cell({:x=>0, :y=>0}, "O")
        board.set_cell({:x=>1, :y=>1}, "X")
        board.set_cell({:x=>0, :y=>2}, "X")
        board.set_cell({:x=>1, :y=>2}, "O")
        expect(comp_player.get_winning_move("X")).to eq({x: 2, y: 0})
      end

      it "returns nil when there are no available winning cells" do
        expect(comp_player.get_winning_move("X")).to eq(nil)
      end
    end

    context "#get_corner_move" do
      it "retrieves one of the four corner cells of a grid" do
        expect(comp_player.get_corner_move).to eq({x: 0, y: 0})
      end

      it "retrieves another corner cell if previous cell(s) already have an marker" do
        board.set_cell({:x=>0, :y=>0}, "X")
        board.set_cell({:x=>0, :y=>2}, "O")
        expect(comp_player.get_corner_move).to eq({x: 2, y: 0})
      end

      it "returns nil if all corner cells already have an marker" do
        board = Board.new(size: 2)
        comp_player = ComputerPlayer.new(board: board)
        board.set_cell({:x=>0, :y=>0}, "X")
        board.set_cell({:x=>0, :y=>1}, "O")
        board.set_cell({:x=>1, :y=>0}, "X")
        board.set_cell({:x=>1, :y=>1}, "O")
        expect(comp_player.get_corner_move).to eq(nil)
      end
    end

    context "#get_random_move" do
      it "returns an available cell" do 
        board = Board.new(size: 2)
        board.set_cell({:x=>0, :y=>0}, "X")
        expect(comp_player.get_random_move).not_to eq({x: 0, y: 0}) 
      end
    end
  end
end
