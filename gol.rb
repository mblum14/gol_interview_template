class Gol
  attr_accessor :board, :height, :width

  def initialize(*rows)
    @board = rows
    @height = rows.length
    @width = rows.first.length
  end

  def next!
    @board.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        cell.neighbors = calculate_neighbors(cell, y, x)
      end
    end
    @board.each do |row|
      row.each do |cell|
        cell.next!
      end
    end
  end

  private

  def calculate_neighbors(cell, y, x)
    [
      [-1, -1], [-1, 0], [-1, 1],
      [0, -1], [0, 1],
      [1, -1], [1, 0], [1, 1]
    ].inject(0) do |sum, offsets|
      y_offset, x_offset = offsets
      pos_y = (y + y_offset)
      pos_x = (x + x_offset)
      next sum if pos_y < 0 || pos_x < 0
      next sum if pos_y >= @height || pos_x >= @width
      sum ||= 0
      sum + @board[pos_y][pos_x].to_i
    end
  end

end

class Cell
  attr_accessor :alive, :neighbors

  def initialize(is_alive)
    @alive = !!is_alive
  end

  def alive?
    @alive
  end

  def next!
    @alive = @alive ? (2..3) === @neighbors : 3 == @neighbors
  end

  def to_s
    alive? ? 'o' : 'x'
  end

  def to_i
    alive? ? 1 : 0
  end

  def ==(cell)
    alive? == cell.alive?
  end
end
