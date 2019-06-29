module Players
  class Computer < Player
    def move(board)
    input = POSSIBLE_MOVES.sample(1)
    board.valid_move?(input[0]) ? input[0] : input = POSSIBLE_MOVES.sample(1)
   end
 end
end
