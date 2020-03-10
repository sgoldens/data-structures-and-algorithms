# source: https://gist.github.com/JohnathanWeisner/d2e09ce5a90518945fef

class SudokuSolver
  def initialize(board)
      @board = board
  end

  # def make_grid(board)
  #   board = board.split('')
  #   board.each do |char|
  #     board << char.to_i
  #     board.shift(1)
  #   end
  #   until board[0].is_a?(Array)
  #     row = board.shift(9)
  #     board << row
  #   end
  #   board
  # end

  def solve!
    num_index = @board.index('0')
    return true unless num_index
    ('1'..'9').each do |possibility|
      @board[num_index] = possibility
      return @board if (board_valid? num_index) && solve! 
    end
    @board[num_index] = '0'
    false
  end

  def board_valid? num_index
    num = @board[num_index]
    return false unless valid_row? num, num_index
    return false unless valid_col? num, num_index
    return false unless valid_box? num, num_index
    true
  end

  def valid_row? num, num_index
    row = num_index / 9
    start = row * 9
    (start..(start + 8)).each do |check_i|
      return false unless valid? check_i, num, num_index
    end
    true    
  end

  def valid_col? num, num_index
    col = num_index%9
    start = 0
    (1..9).each do |x|
      check_i = start + col
      return false unless valid? check_i, num, num_index
      start += 9
    end
    true
  end

  def valid_box? num, num_index
    col_start, row_start = (((num_index%9)/3) * 3), ((num_index/27) * 27)
    3.times do
      (col_start..(col_start+2)).each do |col|
        return false unless valid? col + row_start, num, num_index
      end
      row_start += 9
    end
  end

  def valid? index, num, num_index
    return false if index != num_index && num == @board[index]
    true
  end

end

board_input = '010020300004005060070000008006900070000100002030048000500006040000800106008000000'
p board_input.size
solver = SudokuSolver.new(board_input)
# p solver.board => 
[[0, 1, 0, 0, 2, 0, 3, 0, 0], 
 [0, 0, 4, 0, 0, 5, 0, 6, 0], 
 [0, 7, 0, 0, 0, 0, 0, 0, 8], 
 [0, 0, 6, 9, 0, 0, 0, 7, 0], 
 [0, 0, 0, 1, 0, 0, 0, 0, 2], 
 [0, 3, 0, 0, 4, 8, 0, 0, 0], 
 [5, 0, 0, 0, 0, 6, 0, 4, 0], 
 [0, 0, 0, 8, 0, 0, 1, 0, 6], 
 [0, 0, 8, 0, 0, 0, 0, 0, 0]]
p solver.solve!

# Sudoku can be solved using a backtracking metaheuristic (source: https://en.wikipedia.org/wiki/Backtracking)
# - incrementally builds candidates to the solution
# - abandons invalid candidates as it tests for them, making
#   it usually faster than a brute force enumeration of 
#   all possible candidates
# - 