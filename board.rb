class Board
  COLUMNS = 10
  ROWS = 7

  def initialize
    @grid = Array.new(ROWS) do
      Array.new(COLUMNS) do
        0
      end
    end

    @grid[0][2] = 1
    @grid[1][0] = 1
    @grid[1][2] = 1
    @grid[2][1] = 1
    @grid[2][2] = 1
  end

  def print_grid
    system "clear"
    @grid.each do |row|
      row.each do |cell|
        if cell == 0
          print '+ '
        elsif cell == 1
          print '# '
        end
      end
      print "\n"
    end
  end

  def next_generation
    @next_grid = Array.new(ROWS) do
      Array.new(COLUMNS) do
        0
      end
    end

    @grid.each_with_index do |row, j|
      row.each_with_index do |cell, i|
        neighbors_count = live_neighbors(i, j)
        if cell == 0 && neighbors_count == 3
          @next_grid[j][i] = 1
        elsif cell == 1
          if neighbors_count == 2 || neighbors_count == 3
            @next_grid[j][i] = 1
          end
        end
      end
    end

    @grid = @next_grid
  end

  def live_neighbors(x, y)
    count = 0
    (y-1 .. y+1).each do |j|
      (x-1 .. x+1).each do |i|
        if (i < 0 || i >= COLUMNS)
          next
        end
        if (j < 0 || j >= ROWS)
          next
        end
        unless i == x && j == y
          if @grid[j][i] == 1
            count += 1
          end
        end
      end
    end
    count
  end
end
