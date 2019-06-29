module Players
  class Human < Player

     def move(board)
      puts "Please enter a number (1-9) to move"
      gets.chomp
    end
    
  end
end
