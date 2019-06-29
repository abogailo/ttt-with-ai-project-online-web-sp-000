class Player
  attr_reader :token
  #added possible moves for computer & human to inherit
	 POSSIBLE_MOVES = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

   def initialize(token = "X")
    @token = token
  end
end
