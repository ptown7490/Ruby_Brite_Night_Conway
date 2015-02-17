require 'set'

class Board

  def initialize
    @grid = { }
    #
    # @grid[[2, 0]] = 1
    # @grid[[0, 1]] = 1
    # @grid[[2, 1]] = 1
    # @grid[[1, 2]] = 1
    # @grid[[2, 2]] = 1
    #
    # @grid[[-4, -4]] = 1
    # @grid[[-4, -5]] = 1
    # @grid[[-5, -4]] = 1
    # @grid[[-5, -5]] = 1
  end

  def print_grid
    min_x = max_x = min_y = max_y = 0
    @grid.each do |key, value|
      if key[0] < min_x
        min_x = key[0]
      end
      if key[0] > max_x
        max_x = key[0]
      end
      if key[1] < min_y
        min_y = key[1]
      end
      if key[1] > max_y
        max_y = key[1]
      end
    end
    system "clear"
    (min_y .. max_y).each do |y|
      (min_x .. max_x).each do |x|
        print @grid.has_key?([x, y]) ? '# ' : '+ '
      end
      print "\n"
    end
  end

  def next_generation
    @next_grid = { }

    # check = Set.new(@grid.keys)
    check = @grid.keys

    @grid.each do |key, val|
      value = neighbors(key[0], key[1])
      # check.merge(value)
      check += value
    end

    # check.uniq.each do |cell|
    #   puts "cell: #{cell[0]}, #{cell[1]}"
    # end

    check.uniq.each do |cell|
      neighbors_count = live_neighbors(cell[0], cell[1])
      if ! @grid.has_key?(cell)
        if neighbors_count == 3
          @next_grid[cell] = 1
        end
      elsif neighbors_count == 2 || neighbors_count == 3
        @next_grid[cell] = 1
      end
    end

    @grid = @next_grid
  end

  def live_neighbors(x, y)
    count = 0
    neighbors(x, y).each do |cell|
      if @grid.has_key?(cell)
        count += 1
      end
    end

    # puts "x: #{x}, y: #{y}"
    # puts "count: #{count}"
    count
  end

  def neighbors(x, y)
    set = []
    (x-1 .. x+1).each do |i|
      (y-1 .. y+1).each do |j|
        set << [i, j]
      end
    end
    set.delete([x, y])
    set
  end

  def random_start
    puts "How many rows would you like?"
    rows = gets.chomp.to_i
    puts "How many columns?"
    cols = gets.chomp.to_i
    puts "How many active cells?"
    while (val = gets.chomp.to_i) > rows * cols
      puts "Please enter a valid #!!"
    end
    generate_grid(rows, cols, val)
  end

  def generate_grid(rows, cols, value)
    active = 0
    @grid = {}
    until active > value
      row = (0..(rows-1)).to_a.sample
      col = (0..(cols-1)).to_a.sample
      @grid[[row, col]] = 1
      active += 1
    end
  end
end
