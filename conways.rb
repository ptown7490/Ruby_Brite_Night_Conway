require '~/Desktop/board.rb'

board = Board.new
board.print_grid

while (c = gets.chomp)
  board.next_generation
  board.print_grid
end
