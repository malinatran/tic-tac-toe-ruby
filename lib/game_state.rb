module TicTacToe 

  def self.is_game_over?(board, markers)
    win?(board, markers) || draw?(board, markers)
  end

  def self.win?(board, markers)
    markers.each do |marker|
      if is_winner?(board, marker)
        return true
      end
    end

    false
  end

  def self.draw?(board, markers)
    board.is_grid_filled? && !win?(board, markers)
  end

  def self.is_winner?(board, marker)
    if board.is_either_diagonal_filled?(marker)
      return true
    end

    board.size.times do |n|
      if board.is_row_filled?(n, marker) || board.is_column_filled?(n, marker)
        return true
      end
    end

    false
  end
end
