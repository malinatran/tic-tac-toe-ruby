require "spec_helper"
require "./board.rb"

module TicTacToe
  describe Board do
    context "#initialize" do
      it "initializes with a size based on user input" do
        board = Board.new(size: 5)
        expect(board.size).to eq(5)
      end
      it "initializes with a default size of three" do
        board = Board.new
        expect(board.size).to eq(3)
      end
    end

    context "#createGrid" do
      it "constructs a two-dimensional array" do
        board = Board.new
        empty_board = [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
        expect(board.grid).to eq(empty_board)
      end
    end
    
    context "#isCellEmpty?" do
      it "returns true if cell is empty" do
        board = Board.new
        expect(board.is_cell_empty?(0,0)).to eq(true)
      end
    end

    context "#getCell" do
      it "returns a cell" do
        board = Board.new
        board.set_cell(0, 2, "X")
        expect(board.get_cell(0, 2)).to eq("X")
      end
    end

    context "#setCell" do
      it "sets the value of a cell" do
        board = Board.new
        board.set_cell(1, 1, "O")
        expect(board.grid[1][1]).to eq("O")
      end
    end

    context "#clearCell" do
      it "sets the value of the cell to be empty" do
        board = Board.new
        board.grid[0][0] = "X"
        expect(board.clear_cell(0,0)).to eq(nil)
      end
    end

    context "#clearGrid" do
      it "iterates through grid and empties each cell" do
        board = Board.new
        board.grid[0][0] = "X"
        board.grid[2][1] = "O"
        board.clear_grid
        empty_board = [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]        
        expect(board.grid).to eq(empty_board)
      end
    end
  end
end
