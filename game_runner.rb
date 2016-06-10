require('./board.rb')

board = TicTacToe::Board.new

def pick_cell(x, y, marker)
  begin
    board.set_cell(x, y, marker)
  rescue
    print(marker)
  ensure
  end
end

pick_cell(0, 0, "X")
board.get_size
pick_cell(0, 0, "O")
