module TicTacToe 

  DEFAULT_SIZE = 3

  DRAW = "Draw"

  MARKER =
    { computer: "X",
      human:    "O" }

  MESSAGE = 
    { welcome:  "Welcome to tic-tac-toe!",
      goodbye:  "Adios!",
      size:     "Enter a board size (between 3 and 10):",
      marker:   "Enter a marker (any single letter except 'X'):",
      move:     "Enter your move:",
      draw:     "Nobody won!",
      computer: "Computer won!",
      human:    "You (somehow) won!" }

end
