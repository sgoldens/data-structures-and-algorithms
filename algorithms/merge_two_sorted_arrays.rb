# Merge two sorted arrays of unique positive integers, where one array is twice the size of the other and that larger arrays second half is filled with 0's, while maintaining constant Auxiliary Space Complexity (not using any additional data structures.)

a = [1,5,6,13,41,99,0,0,0,0,0,0]
b = [2,3,7,9,10,14]

def sort_merge_arr(a,b)
  # Time Complexity = O(AB)
  # Auxiliary Space Complexity = O(1)
  a << b
  a.flatten!
  b.clear
  a.each do |el|
    if !el.nil?
      b[el] = el
    end
  end
  a.clear
  counter = 0
  b.each do |el|
    if !el.nil?
      a[counter] = el
      counter += 1
    end
  end
  a.drop(1)
end

p sort_merge_arr(a,b)

# require 'benchmark'

# Benchmark.bmbm do |results|
#   results.report("sort_merge_arr(a,b)") { sort_merge_arr(a,b) }
# end