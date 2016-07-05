require_relative "spec_helper"
require_relative "../lib/board"

module TicTacToe
  describe TicTacToe::Board do

    let(:board) { Board.new }

    context "#initialize" do
      it "initializes with a size based on user input" do
        board = Board.new(5)
        expect(board.size).to eq(5)
      end

      it "initializes with a default size of three" do
        expect(board.size).to eq(3)
      end
    end

    context "#size" do
      it "sets the size and creates a new grid based on that size" do
        size = 5
        board.size=(size)
        expect(board.size).to eq(5)
        expect(board.grid.size).to eq(5)
      end
    end

    context "#create_grid" do
      it "constructs a two-dimensional array based on size determined by user" do
        board = Board.new(2)
        empty_board = [[nil, nil], 
                       [nil, nil]]
        expect(board.grid).to eq(empty_board)
      end

      it "constructs a two-dimension array with a default size of three" do
        empty_board = [[nil, nil, nil],
                       [nil, nil, nil], 
                       [nil, nil, nil]]
        expect(board.grid).to eq(empty_board)
      end
    end

    context "#is_cell_empty?" do
      it "returns true if cell is empty" do
        expect(board.is_cell_empty?({x: 0, y: 0})).to eq(true)
      end

      it "returns false if cell has an identity" do
        board.set_cell({x: 0, y: 1}, "X")
        expect(board.is_cell_empty?({x: 0, y: 1})).to eq(false)
      end
    end

    context "#get_empty_cells" do
      let(:board) { Board.new(2) }
      it "returns only cells without any values" do
        board.set_cell({x: 0, y: 0}, "O")
        board.set_cell({x: 0, y: 1}, "X")
        board.set_cell({x: 1, y: 1}, "O")
        expect(board.get_empty_cells).to eq([{x: 1, y: 0}])
      end
      
      it "returns all empty cells in array" do
        board.set_cell({x: 0, y: 0}, "X")
        board.set_cell({x: 0, y: 1}, "O")
        expect(board.get_empty_cells).to eq([{x: 1, y: 0}, {x: 1, y: 1}])
      end
    end

    context "#is_grid_filled" do
      let(:board) { Board.new(2) }
      it "returns true if all cells have values" do
        board.set_cell({x: 0, y: 0}, "O")
        board.set_cell({x: 0, y: 1}, "X")
        board.set_cell({x: 1, y: 0}, "O")
        board.set_cell({x: 1, y: 1}, "X")
        expect(board.is_grid_filled?).to eq(true)
      end
      
      it "returns false if one or some cells have values" do
        board.set_cell({x: 0, y: 0}, "O")
        board.set_cell({x: 0, y: 1}, "X")
        expect(board.is_grid_filled?).to eq(false)
      end
    end

    context "#set_cell" do
      it "sets the value of a cell if it does not already have a value" do
        expect(board.set_cell({x: 1, y: 1}, "O")).to eq("O")
      end
      
      it "raises an exception if a cell already has a value" do
        board.set_cell({x: 0, y: 0}, "X")
        expect{board.set_cell({x: 0, y: 0}, "O")}.to raise_error("Cell already has a value.")
      end
    end

    context "#clear_cell" do
      it "sets the value of the cell to be empty" do
        board.set_cell({x: 0, y: 0}, "X")
        expect(board.clear_cell({x: 0, y: 0})).to eq(nil)
      end
    end

    context "#clear_grid" do
      it "iterates through grid and empties the value of each cell" do
        board.set_cell({x: 0, y: 0}, "X")
        board.set_cell({x: 2, y: 1}, "O")
        board.clear_grid
        empty_board = [[nil, nil, nil], 
                       [nil, nil, nil], 
                       [nil, nil, nil]]        
        expect(board.grid).to eq(empty_board)
      end
    end

    context "#retrieve_cells" do
      it "retrieves a single cell with player's marker" do
        board = Board.new(2)
        board.set_cell({x: 0, y: 0}, "X")
        expect(board.retrieve_cells("X")).to eq([{x: 0, y: 0}])
      end

      it "retrieves multiple cells with a player's marker" do
        board.set_cell({x: 1, y: 1}, "X")
        board.set_cell({x: 1, y: 2}, "m")
        board.set_cell({x: 2, y: 0}, "m")
        expect(board.retrieve_cells("m")).to eq([{x: 1, y: 2}, {x: 2, y: 0}])
      end
    end 

    context "#is_row_filled?" do
      it "returns true if each cell in a row is filled with player's identity" do
        board.set_cell({x: 0, y: 0}, "X")
        board.set_cell({x: 0, y: 1}, "X")
        board.set_cell({x: 0, y: 2}, "X")
        expect(board.is_row_filled?(0, "X")).to eq(true)
      end
      
      it "returns false if a cell in a row is nil" do 
        board.set_cell({x: 0, y: 0}, "X")
        board.set_cell({x: 0, y: 2}, "X")
        expect(board.is_row_filled?(0, "X")).to eq(false)
      end

      it "returns false if a cell in a row is not filled with player's identity" do 
        board.set_cell({x: 0, y: 0}, "O")
        board.set_cell({x: 0, y: 1}, "X")
        board.set_cell({x: 0, y: 2}, "X")
        expect(board.is_row_filled?(0, "X")).to eq(false)
      end
    end

    context "#is_column_filled?" do
      it "returns true if each cell in a column is filled with player's identity" do
        board.set_cell({x: 0, y: 0}, "O")
        board.set_cell({x: 1, y: 0}, "O")
        board.set_cell({x: 2, y: 0}, "O")
        expect(board.is_column_filled?(0, "O")).to eq(true)
      end
      
      it "returns false if a cell in a column is nil" do
        board.set_cell({x: 0, y: 1}, "O")
        board.set_cell({x: 1, y: 1}, "O")
        expect(board.is_column_filled?(1, "O")).to eq(false)
      end

      it "returns false if a cell in a column is not filled with player's identity" do
        board.set_cell({x: 0, y: 2}, "X")
        board.set_cell({x: 1, y: 2}, "X")
        board.set_cell({x: 2, y: 2}, "O")
        expect(board.is_column_filled?(2, "X")).to eq(false)
      end
    end

    context "#is_backward_diagonal_filled?" do
      it "returns true if each cell in the backward diagonal is filled with player's identity" do
        board.set_cell({x: 0, y: 0}, "X")
        board.set_cell({x: 1, y: 1}, "X")
        board.set_cell({x: 2, y: 2}, "X")
        expect(board.is_backward_diagonal_filled?("X")).to eq(true)
      end
      
      it "returns false if a cell in the backward diagonal is empty" do
        board.set_cell({x: 0, y: 0}, "O")
        board.set_cell({x: 2, y: 2}, "O")
        expect(board.is_backward_diagonal_filled?("O")).to eq(false)
      end
      
      it "returns false if a cell in the backward diagonal is not filled with player's identity" do
        board.set_cell({x: 0, y: 0}, "O")
        board.set_cell({x: 1, y: 1}, "O")
        board.set_cell({x: 2, y: 2}, "X")
        expect(board.is_backward_diagonal_filled?("O")).to eq(false)
      end
    end
    
    context "#is_forward_diagonal_filled?" do
      it "returns true if each cell in the forward diagonal is filled with player's identity" do
        board.set_cell({x: 0, y: 2}, "X")
        board.set_cell({x: 1, y: 1}, "X")
        board.set_cell({x: 2, y: 0}, "X")
        expect(board.is_forward_diagonal_filled?("X")).to eq(true)
      end
      
      it "returns false if a cell in the forward diagonal is empty" do
        board.set_cell({x: 0, y: 2}, "O")
        board.set_cell({x: 1, y: 1}, "O")
        expect(board.is_forward_diagonal_filled?("O")).to eq(false)
      end
      
      it "returns false if a cell in the forward diagonal is not filled with player's identity" do
        board.set_cell({x: 0, y: 2}, "O")
        board.set_cell({x: 1, y: 1}, "X")
        board.set_cell({x: 2, y: 0}, "O")
        expect(board.is_forward_diagonal_filled?("O")).to eq(false)
      end
    end
  end
end
