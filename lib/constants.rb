module TicTacToe 
  
  NEW_LINE = "\n"
  PROMPT = "> "
  OPTIONS = 
    { one: "1",
      two: "2",
      three: "3",
      four: "4" }
  COMPUTER = "Computer"
  HUMAN = "Human"
  DRAW = "Draw"
  DEPTH = 0
  DEFAULT_MESSAGES = 
    { welcome:  "Welcome to tic-tac-toe!",
      goodbye:  "Adios!",
      size:     "Enter a board size (between 3 and 10):",
      marker:   "Enter a marker (single character that is not 'X'):",
      move:     "Enter your move:",
      draw:     "Nobody won!",
      computer: "Computer won!",
      human:    "You (somehow) won!" }

end
