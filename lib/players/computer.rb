module Players
  class Computer < Player
    def move(board)
    input = POSSIBLE_MOVES.sample(1)
    board.valid_move?(input[0]) ? input[0] : input = POSSIBLE_MOVES.sample(1)
   end

    def self.best_move(board)
      WIN_COMBINATIONS.detect do |position|  #checks all the combos to see if any player is close to a win. This could be an offensive or defensive move
        if board[position[0]] == " " && board[position[1]] == "X" && board[position[2]] == "X"
          return position[0] + 1 #added plus one because the options are 1-9
        elsif board[position[0]] == " " && board[position[1]] == "O" && board[position[2]] == "O"
          return position[0] + 1
        elsif board[position[0]] == "O" && board[position[1]] == " " && board[position[2]] == "O"
          return position[1] + 1
        elsif board[position[0]] == "X" && board[position[1]] == " " && board[position[2]] == "X"
          return position[1] + 1
        elsif board[position[0]] == "O" && board[position[1]] == "O" && board[position[2]] == " "
          return position[2] + 1
        elsif board[position[0]] == "X" && board[position[1]] == "X" && board[position[2]] == " "
          return position[2] + 1
        else
          nil #returns nil so the other cases could be met.
        end
      end
    end
 
 
    def self.corner(board)
      if (board[0] == " ")
          0 + 1 #index 0 in the array (+1 for options)
      elsif (board[2] == " ")
          2 + 1
      elsif (board[6] == " ")
          6 + 1
      elsif (board[8] == " ")
         8 + 1
      else
       nil #returns nil so the other cases could be met
      end
    end
 
   def move(board)
    if (best_move(board) != nil) #case for a defensive move or to finish the game
      self.best_move(board)
    elsif (board[4] == " ") #case to always pick middle if it is blank
       4 + 1
    elsif (corner(board) != nil)
      self.corner(board) #case to pick a corner section
    else
     input = POSSIBLE_MOVES.sample(1) #samples 1 valid input from the constant list of possible moves (in class player)
     board.valid_move?(input[0])? input[0] : input = POSSIBLE_MOVES.sample(1) #checks to see if the input (which is in an array form so need to pull out its value) is valid, if so => input value; else => chooses another input
    end
   end

 end
end
