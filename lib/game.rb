class Game

  attr_accessor :board, :player_1, :player_2 #provides access to player_1, player_2, and board

  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]]

  def current_player
    @board.turn_count % 2 == 0 ? @player_1 : @player_2
  end

  def won?
#runs over WIN_COMBINATIONS to check board cells for a winning combo, where winning combo includes all X's or all O's (no blanks)
    WIN_COMBINATIONS.detect {|win| @board.cells[win[0]] != " " && @board.cells[win[0]] == @board.cells[win[1]] && @board.cells[win[1]] == @board.cells[win[2]]}
  end

  def draw?
    @board.full? && !won?
  end

  def over?
    draw? || won?
  end

  def winner
                #returns X when X won
                #returns O when O won --> if self.won? is true, it returns the winning combination so I'm looking at the index to pull the value at that winning index ( => "X" or "O")
                #returns nil when no winner --> if self.won? is falsey, then it will return nil
    self.won? ? @board.cells[self.won?[0]] : nil
  end

  def turn
                #makes valid moves
                #asks for input again after a failed validation
                #changes to player 2 after the first turn
                #self is printed below:
                #<Game:0x00000000022231a0
                     # @board=
                     #  #<Board:0x00000000022230d8
                     #   @cells=[" ", " ", " ", " ", " ", " ", " ", " ", " "]>,
                     # @player_1=#<Players::Human:0x0000000002223150 @token="X">,
                     # @player_2=#<Players::Human:0x0000000002223100 @token="O">>

#if the turn is even player 1 will go, if odd then player 2 will go; this is checked at the beginning of every turn to assign player
    self.board.turn_count.even? ? player = "player_1" : player = "player_2"

#I made variable player into a string so that I could use send() to insert the appropriate object
    input = self.send(player).move(self.board)

#the player is called upon to make a move, the move is checked for validity. If valid, then it makes the move/updates the board; otherwise, asks player to try again

    self.board.valid_move?(input) ? self.board.update(input, send(player)) : input = self.send(player).move(self.board)
  end

  def play
                #asks for players input on a turn of the game
                #checks if the game is over after every turn
                #plays the first turn of the game
                #plays the first few turns of the game
                #checks if the game is won after every turn
                #checks if the game is a draw after every turn
                #stops playing if someone has won

    until self.over?
      self.turn
      self.board.display
    end

                #congratulates the winner X
                #congratulates the winner O
                #stops playing in a draw
                #prints Cats Game on a draw
                #plays through an entire game

    if self.draw?
      puts "Cat's Game!"
    elsif self.won?
      puts "Congratulations #{self.winner}!"
    end
  end
end
