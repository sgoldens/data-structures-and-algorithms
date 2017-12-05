# Selection Sort
# 
# Time Complexity: O(n^2), "Quadratic"
# 
# Selection sort can be done in-place by using three pointers. One, to 
# track the progress of the sorted portion vs the unsorted remaining 
# portion. Two, to point to the index value currently being evaluated. And 
# three, to scan each indice from the first unsorted to the last indice. 
# As the third pointer encounters values smaller than the second pointer 
# value, the two values are swapped.
#
# This version uses another array to build the sorted array, and then 
# replacing the input with the sorted version.
#
# Shovel each minimal element from the input into the sorted array and
# delete it from the input array. Do this until the input array is
# empty, which is the same as saying while the input length is greater
# than zero.
#
# Then, replace and return the input array with the sorted array.

def selection_sort(input)
  sorted_array = Array.new
  sorted_array << input.delete_at(input.index(input.min)) while input.length > 0
  input.replace(sorted_array)
end

# Unit Tests: all tests should evaluate to true
p selection_sort([3,9,1,4,7]) === [1,3,4,7,9]
# Test our selection_sort against Ruby's internal sort method
test_selection = Array.new(15) { |i| rand(100) }
test_selection2 = Array.new(150) { |i| rand(100) }
test_selection3 = Array.new(1500) { |i| rand(100) }
p selection_sort(test_selection) === test_selection.sort
p selection_sort(test_selection2) === test_selection2.sort
p selection_sort(test_selection3) === test_selection3.sort