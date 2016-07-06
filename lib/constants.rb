module TicTacToe 

  DRAW = "Draw"

  FORMAT = 
    { line:     "\n",
      prompt:   "> " }

  MARKER =
    { computer: "X",
      human:    "O" }

  MESSAGE = 
    { welcome:  "Welcome to tic-tac-toe!",
      goodbye:  "Adios!",
      size:     "Enter a board size (between 3 and 10):",
      marker:   "Enter a marker (single character that is not 'X'):",
      move:     "Enter your move:",
      draw:     "Nobody won!",
      computer: "Computer won!",
      human:    "You (somehow) won!" }

end
