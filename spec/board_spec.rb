require "spec_helper"
require "./board"

module TicTacToe
  describe TicTacToe::Board do
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

    context "#create_grid" do
      it "constructs a two-dimensional array based on size determined by user" do
        board = Board.new(size: 2)
        empty_board = [[nil, nil], [nil, nil]]
        expect(board.grid).to eq(empty_board)
      end

      it "constructs a two-dimension array with a default size of three" do
        board = Board.new
        empty_board = [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
        expect(board.grid).to eq(empty_board)
      end
    end

    context "#get_grid" do
      it "retrieves the grid" do
        board = Board.new(size: 2)
        two_by_two_board = [[nil, nil], [nil, nil]]
        expect(board.get_grid).to eq(two_by_two_board)
      end
    end

    context "#get_size" do
      it "retrieves the grid's size" do
        board = Board.new(size: 8)
        expect(board.get_size).to eq(8)
      end
    end
    
    context "#is_cell_empty?" do
      it "returns true if cell is empty" do
        board = Board.new
        expect(board.is_cell_empty?(0,0)).to eq(true)
      end

      it "returns false if cell has an identity" do
        board = Board.new
        board.set_cell(0, 1, "X")
        expect(board.is_cell_empty?(0, 1)).to eq(false)
      end
    end

    context "#get_empty_cells" do
      it "returns only cells without any values" do
        board = Board.new(size: 2)
        board.set_cell(0, 0, "O")
        board.set_cell(0, 1, "X")
        board.set_cell(1, 0, "O")
        expect(board.get_empty_cells).to eq([{x: 1, y: 1}])
      end
      
      it "returns all empty cells in array" do
        board = Board.new(size: 2)
        board.set_cell(0, 0, "X")
        board.set_cell(0, 1, "O")
        expect(board.get_empty_cells).to eq([{x: 1, y: 0}, {x: 1, y: 1}])
      end
    end

    context "#is_grid_filled" do
      it "returns true if all cells have values" do
        board = Board.new(size: 2)
        board.set_cell(0, 0, "O")
        board.set_cell(0, 1, "X")
        board.set_cell(1, 0, "O")
        board.set_cell(1, 1, "X")
        expect(board.is_grid_filled?).to eq(true)
      end
      
      it "returns false if one or some cells have values" do
        board = Board.new(size: 2)
        board.set_cell(0, 0, "O")
        board.set_cell(0, 1, "X")
        expect(board.is_grid_filled?).to eq(false)
      end
    end

    context "#get_cell" do
      it "returns a cell that has a value" do
        board = Board.new
        board.set_cell(0, 2, "X")
        expect(board.get_cell(0, 2)).to eq("X")
      end
      
      it "returns a cell that does not have a value" do
        board = Board.new
        expect(board.get_cell(1, 1)).to eq(nil)
      end
    end

    context "#set_cell" do
      it "sets the value of a cell if it does not already have a value" do
        board = Board.new
        expect(board.set_cell(1, 1, "O")).to eq("O")
      end
      
      it "raises an exception if a cell already has a value" do
        board = Board.new
        board.set_cell(0, 0, "X")
        expect{board.set_cell(0, 0, "O")}.to raise_error(CellIsFilledError)
      end
    end

    context "#clear_cell" do
      it "sets the value of the cell to be empty" do
        board = Board.new
        board.set_cell(0, 0, "X")
        expect(board.clear_cell(0,0)).to eq(nil)
      end
    end

    context "#clear_grid" do
      it "iterates through grid and empties the value of each cell" do
        board = Board.new
        board.set_cell(0, 0, "X")
        board.set_cell(2, 1, "O")
        board.clear_grid
        empty_board = [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]        
        expect(board.grid).to eq(empty_board)
      end
    end

    context "#is_row_filled?" do
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

    context "#is_column_filled" do
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

    context "#is_backward_diagonal_filled?" do
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
    
    context "#is_forward_diagonal_filled?" do
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
