c# matrix_square_diagonals.rb
#
# Input: An array of positive integers of a length that has a square root
#   which is whole number, an integer (not a fraction/decimal.)
#
# Output: All diagonals which traverse the square matrix traversing down 1 and 
#   right 1 from the top-right to the bottom-left
# 
# Example input:
#   test_matrix_array = [1,5,2,0,4,3,6,3,8,6,9,4,5,3,1,2]
#     ... which can be expressed as a square grid/matrix
#       [[1,5,2,0],
#        [4,3,6,3],
#        [8,6,9,4],
#        [5,3,1,2]]
# 
# Example output:
# 0
# 2 3
# 5 6 4
# 1 3 9 2
# 4 6 1
# 8 3
# 5

def matrix_square_diagonals(arr)

  results = []
  square_size = Math.sqrt(arr.size)

  if !square_size.to_s.include?('.0')
    return "Invalid input: Not able to create a square grid. Please use an input " + 
      "array which has size such that its square root is not a fraction."
  end 

  make_grid = lambda { |grid|
    until grid[0].is_a?(Array)
      row = grid.shift(square_size)
      grid << row
    end
    grid
  }

  grid = make_grid.call(arr)

  horizontal = 0
  vertical = 0

  diagonal = lambda { |horizontal,vertical|
    diagonal_array = []
    until vertical > square_size - 1 || horizontal < 0 do
      diagonal_array << grid[vertical][-(1 + horizontal)]
      horizontal -= 1
      vertical += 1
    end
    diagonal_array
  }

  until vertical > square_size - 1 && horizontal === square_size - 1 do
    results << diagonal.call(horizontal, vertical)
    if horizontal <= square_size - 2
      horizontal += 1
    else
      vertical += 1
    end
  end

  results.each do |row|
    p row.join(' ')
  end

  results

end

# Tests

test_matrix_array = [1,5,2,0,4,3,6,3,8,6,9,4,5,3,1,2]
test_matrix_array_2 = [1,5,2,0,4,3,6,3,8,6,9,4,5,3,1,2,1,5,2,0,4,3,6,3,8,6,9,4,5,3,1,2,1,2,3,4]
test_matrix_array_invalid = [1,5,2,0,4,3,6,3,8,6,9,4,5,3,1,2,1,5,2,0,4]

p matrix_square_diagonals(test_matrix_array_invalid) === 'Invalid input: Not able to create a square grid. Please use an input array which has size such that its square root is not a fraction.'

p matrix_square_diagonals(test_matrix_array) === [
  [0], 
  [2, 3], 
  [5, 6, 4], 
  [1, 3, 9, 2], 
  [4, 6, 1], 
  [8, 3], 
  [5]
  ]
p matrix_square_diagonals(test_matrix_array_2) === [
  [3],
  [4, 4], 
  [0, 9, 5], 
  [2, 6, 1, 3], 
  [5, 8, 2, 6, 3], 
  [1, 3, 1, 3, 5, 4], 
  [6, 3, 4, 4, 3], 
  [5, 0, 9, 2], 
  [2, 6, 1], 
  [8, 2], 
  [1]
]
