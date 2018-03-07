def sudoku_verifier(grid)

    freq_check = -> collection {
      freq = {}
      collection.each do |num|
        if num != "."
          if freq[num]
            freq[num] += 1
          end
          if !freq[num]
            freq[num] = 1
          end
          if freq[num] > 1
            return false
          end
        end
      end
    }
    check_row = -> grid {
      grid.each do |row|
        return false if !freq_check.call(row)
      end
      true
    }
  
    check_column = -> grid {
      transposed = grid.transpose
      grid.transpose.each do |column|
        return false if !freq_check.call(column)
      end
      true
    }

    check_box = -> grid {
      box_indexes = [0,3,6,27,30,33,54,57,60]
      flat = grid.flatten
      box_indexes.each do |boxUpperLeft|
        box = [flat[boxUpperLeft..boxUpperLeft+2],flat[boxUpperLeft+9..boxUpperLeft+11],flat[boxUpperLeft+18..boxUpperLeft+20]].flatten
        # p box
        return false if !freq_check.call(box)
      end
      true
    }

    # check_box.call(grid)
    if check_row.call(grid) === true &&
       check_column.call(grid) === true && check_box.call(grid) === true
        return true
    else
      return false
    end
end

grid_true = [[".",".",".","1","4",".",".","2","."], 
             [".",".","6",".",".",".",".",".","."], 
             [".",".",".",".",".",".",".",".","."], 
             [".",".","1",".",".",".",".",".","."], 
             [".","6","7",".",".",".",".",".","9"], 
             [".",".",".",".",".",".","8","1","."], 
             [".","3",".",".",".",".",".",".","6"], 
             [".",".",".",".",".","7",".",".","."], 
             [".",".",".","5",".",".",".","7","."]]


grid_false_column = [[".",".",".","1","4",".","8","2","."], 
             [".",".","6",".",".",".",".",".","."], 
             [".",".",".",".",".",".",".",".","."], 
             [".",".","1",".",".",".",".",".","."], 
             [".","6","7",".",".",".",".",".","9"], 
             [".",".",".",".",".",".","8","1","."], 
             [".","3",".",".",".",".",".",".","6"], 
             [".",".",".",".",".","7",".",".","."], 
             [".",".",".","5",".",".",".","7","."]]

grid_false_row = [[".",".",".","1","4",".",".","2","."], 
             [".",".","6",".",".",".",".",".","."], 
             [".",".",".",".",".",".",".",".","."], 
             [".",".","1",".",".",".",".",".","."], 
             [".","6","7",".",".",".",".",".","9"], 
             [".",".",".",".",".",".","8","1","."], 
             [".","3",".",".",".",".",".",".","6"], 
             [".",".","7",".",".","7",".",".","."], 
             [".",".",".","5",".",".",".","7","."]]

grid_false_box = [[".",".",".","1","4",".",".","2","."], 
             [".",".","6",".",".",".",".",".","."], 
             [".",".",".",".",".",".",".",".","."], 
             [".",".","1",".",".",".",".",".","."], 
             [".","6","7",".",".",".",".",".","9"], 
             [".",".",".",".",".",".","8","1","."], 
             [".","3",".",".",".",".",".",".","6"], 
             [".",".",".",".",".","7",".",".","."], 
             [".",".",".","5",".","5",".","7","."]]

p sudoku_verifier(grid_true) === true
p sudoku_verifier(grid_false_row) === false
p sudoku_verifier(grid_false_column) === false
p sudoku_verifier(grid_false_box) === false