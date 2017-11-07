# Bubble Sort in Ruby
# Time Complexity: O(n^2), "Quadratic" 
# Auxiliary Space Complexity: O(1), "Constant" 

# Bubble sort is a simple, but inefficient sorting method, being of quadratic
#   time complexity - O(n^2) -  at worst.

# It works by beginning a sorted portion at the end of the list, index n-1.
#   A loop runs to continually compare the current index and its neighbor. When
#   it is larger than its next index value, the values are swapped. This 
#   results in the sorted portion forming at the end of the array with the 
#   largest values being "bubbled up" first.

def bubblesort(input)  
  # Loop through the list
  input.each do |j|
    # Compare each element to the rest of the elements, and
    input.length.times do |indice|
      # While the element ahead of it both exists and is smaller
      while input[indice+1] != nil && input[indice] > input[indice+1]
        # Swap the elements, so the larger element "bubbles up" to its sorted position
        input[indice], input[indice+1] = input[indice+1], input[indice]
      end
    end
  end
  # Return the now sorted list as result
  input
end

p bubblesort([3,9,1,4,7]) == [1,3,4,7,9]
test_bubble = Array.new(15) { |i| rand(100) }
test_bubble2 = Array.new(150) { |i| rand(100) }
test_bubble3 = Array.new(1500) { |i| rand(100) }
p bubblesort(test_bubble) === test_bubble.sort
p bubblesort(test_bubble2) === test_bubble2.sort
p bubblesort(test_bubble3) === test_bubble3.sort

require 'benchmark'
n = Array.new(1000) {rand(100)}
Benchmark.bm do |x|
  x.report("bubblesort") { bubblesort(n) }
  x.report("ruby_native_sort") { n.sort! }
end