require 'pp'
require './sudoku_verifier'

class SudokuSolver

  def initialize(grid)
    @grid = grid
    @board = grid.flatten.join('')
  end

  def solve!
    num_index = @board.index('0')
    return true unless num_index
    ('1'..'9').each do |possibility|
      @board[num_index] = possibility
      grid = board_to_grid(@board)
      p grid.flatten.join('')
      # p sudoku_verifier(grid)
      return @board if (sudoku_verifier(grid))
      solve! 
    end
    @board[num_index] = '0'
    false
  end

  def board_to_grid(board)
    grid = []
    board = board.split('')
    while board.size > 0
      grid << board.shift(9)
    end
    grid
  end
end

# p sudoku_verifier(grid_true) === true
# p sudoku_verifier(grid_false_row) === false
# p sudoku_verifier(grid_false_column) === false
# p sudoku_verifier(grid_false_box) === false

valid_unsolved = 
[["0", "1", "0", "0", "2", "0", "3", "0", "0"], 
 ["0", "0", "4", "0", "0", "5", "0", "6", "0"], 
 ["0", "7", "0", "0", "0", "0", "0", "0", "8"], 
 ["0", "0", "6", "9", "0", "0", "0", "7", "0"], 
 ["0", "0", "0", "1", "0", "0", "0", "0", "2"], 
 ["0", "3", "0", "0", "4", "8", "0", "0", "0"], 
 ["5", "0", "0", "0", "0", "6", "0", "4", "0"], 
 ["0", "0", "0", "8", "0", "0", "1", "0", "6"], 
 ["0", "0", "8", "0", "0", "0", "0", "0", "0"]]

# p sudoku_verifier(valid_unsolved)

sudoku_solver = SudokuSolver.new(valid_unsolved)

p sudoku_solver.solve!
 # '010020300004005060070000008006900070000100002030048000500006040000800106008000000'
