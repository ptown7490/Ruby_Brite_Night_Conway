require './board.rb'

board = Board.new
board.random_start
board.print_grid

while (c = gets.chomp)
  board.next_generation
  board.print_grid
end
