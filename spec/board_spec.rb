require "spec_helper"
require "./board"

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

    context "#getGrid" do
      it "retrieves the grid" do
        board = Board.new(size: 2)
        two_by_two_board = [[nil, nil], [nil, nil]]
        expect(board.get_grid).to eq(two_by_two_board)
      end
    end

    context "#getSize" do
      it "retrieves the grid's size" do
        board = Board.new(size: 8)
        expect(board.get_size).to eq(8)
      end
    end
    
    context "#isCellEmpty?" do
      it "returns true if cell is empty" do
        board = Board.new
        expect(board.is_cell_empty?(0,0)).to eq(true)
      end
    end

    context "#getEmptyCells" do
      it "returns only cells without any values" do
        board = Board.new(size: 2)
        board.set_cell(0, 0, "O")
        board.set_cell(0, 1, "X")
        board.set_cell(1, 0, "O")
        expect(board.get_empty_cells).to eq([{x: 1, y: 1}])
      end
    end

    context "#isGridFilled" do
      it "returns true if all cells have values" do
        board = Board.new(size: 2)
        board.set_cell(0, 0, "O")
        board.set_cell(0, 1, "X")
        board.set_cell(1, 0, "O")
        board.set_cell(1, 1, "X")
        expect(board.is_grid_filled?).to eq(true)
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

    context "#isRowFilled" do
      it "returns true if each cell in a row is filled with player's identity" do
        board = Board.new(size: 3)
        board.set_cell(0, 0, "X")
        board.set_cell(0, 1, "X")
        board.set_cell(0, 2, "X")
        expect(board.is_row_filled?(0, "X")).to eq(true)
      end
      it "returns false if a cell in a row is nil" do 
        board = Board.new
        board.set_cell(0, 0, "X")
        board.set_cell(0, 2, "X")
        expect(board.is_row_filled?(0, "X")).to eq(false)
      end
      it "returns false if a cell in a row is not filled with player's identity" do 
        board = Board.new
        board.set_cell(0, 0, "O")
        board.set_cell(0, 1, "X")
        board.set_cell(0, 2, "X")
        expect(board.is_row_filled?(0, "X")).to eq(false)
      end
    end

    context "#isColumnFilled" do
      it "returns true if each cell in a column is filled with player's identity" do
        board = Board.new
        board.set_cell(0, 0, "O")
        board.set_cell(1, 0, "O")
        board.set_cell(2, 0, "O")
        expect(board.is_column_filled?(0, "O")).to eq(true)
      end
      it "returns false if a cell in a column is nil" do
        board = Board.new
        board.set_cell(0, 1, "O")
        board.set_cell(1, 1, "O")
        expect(board.is_column_filled?(1, "O")).to eq(false)
      end
      it "returns false if a cell in a column is not filled with player's identity" do
        board = Board.new
        board.set_cell(0, 2, "X")
        board.set_cell(1, 2, "X")
        board.set_cell(2, 2, "O")
        expect(board.is_column_filled?(2, "X")).to eq(false)
      end
    end

    context "#isBackwardDiagonalFilled" do
      it "returns true if each cell in the backward diagonal is filled with player's identity" do
        board = Board.new
        board.set_cell(0, 0, "X")
        board.set_cell(1, 1, "X")
        board.set_cell(2, 2, "X")
        expect(board.is_backward_diagonal_filled?("X")).to eq(true)
      end
      it "returns false if a cell in the backward diagonal is empty" do
        board = Board.new
        board.set_cell(0, 0, "O")
        board.set_cell(2, 2, "O")
        expect(board.is_backward_diagonal_filled?("O")).to eq(false)
      end
      it "returns false if a cell in the backward diagonal is not filled with player's identity" do
        board = Board.new
        board.set_cell(0, 0, "O")
        board.set_cell(1, 1, "O")
        board.set_cell(2, 2, "X")
        expect(board.is_backward_diagonal_filled?("O")).to eq(false)
      end
    end
    
    context "#isForwardDiagonalFilled" do
      it "returns true if each cell in the forward diagonal is filled with player's identity" do
        board = Board.new
        board.set_cell(0, 2, "X")
        board.set_cell(1, 1, "X")
        board.set_cell(2, 0, "X")
        expect(board.is_forward_diagonal_filled?("X")).to eq(true)
      end
      it "returns false if a cell in the forward diagonal is empty" do
        board = Board.new
        board.set_cell(0, 2, "O")
        board.set_cell(1, 1, "O")
        expect(board.is_forward_diagonal_filled?("O")).to eq(false)
      end
      it "returns false if a cell in the forward diagonal is not filled with player's identity" do
        board = Board.new
        board.set_cell(0, 2, "O")
        board.set_cell(1, 1, "X")
        board.set_cell(2, 0, "O")
        expect(board.is_forward_diagonal_filled?("O")).to eq(false)
      end
    end
  end
end
