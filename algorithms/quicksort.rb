# Quicksort is an efficient, non-stable (destructive - although I've hacked it to be non-destructive), divide-and-conquer, comparison sort, which can be done in place or not and, when implemented well, it can be about two or three times faster than its main competitors, mergesort and heapsort. By “implemented well”, meaning the choice of pivot points is ideal for task parallelism, and the availability of auxiliary space is permissible.
# Steps: 
# 1) deciding a pivot point, 
# 2) storing that value in a temp variable, 
# 3) removing that variable from the list, 
# 4) recursively sort all elements into two groups, lesser and greater,
#   by comparing the values to the pivot point: [int array] lesser-than

def quicksort(list)  
  # Base Case: list is empty, return an empty array  
  return [] if list.empty? 

  # copy the list as a hack to make the quicksort non-destructive, although now has a auxiliary space complexity of O(n) instead of O(1)
  list_copy = list.clone

  sort = -> list_copy {
    # Choose a pivot point  
    pivot_point = (list_copy.size / 2).to_i  
    # Store the pivot value as a temp variable  
    pivot_value = list_copy[pivot_point]  
    # # Remove it from the input  
    list_copy.delete_at(pivot_point) 
    # Create two new arrays  
    lesser = []  
    greater = []  
    # Loop through the list  
    if list_copy
      list_copy.each do |x|  
        # Put the lesser items in one array  
        if x <= pivot_value  
          lesser << x  
        # and the greater items in another
        else  
          greater << x  
        end  
      end  
    end
    # Recursive Case: call quick sort on lesser and greater arrays, joined by the pivot_value 
    return quicksort(lesser) + [pivot_value] + quicksort(greater)
  }

  # Using the lambda call helper function, we can hack quicksort to be non-destructive
  sort.call(list_copy)
end

ten_rand_arr = Array.new(10) { rand(100) }
thousand_rand_arr = Array.new(1000) { rand(1000) } 

require 'benchmark'

Benchmark.bmbm do |results|
  results.report("quicksort(ten_rand_arr)") { quicksort(ten_rand_arr) }
  results.report("quicksort(thousand_rand_arr") { quicksort(thousand_rand_arr) }
end

# Rehearsal ---------------------------------------------------------------
# quicksort(ten_rand_arr)       0.000000   0.000000   0.000000 (  0.000109)
# quicksort(thousand_rand_arr   0.010000   0.000000   0.010000 (  0.010102)
# ------------------------------------------------------ total: 0.010000sec

#                                   user     system      total        real
# quicksort(ten_rand_arr)       0.000000   0.000000   0.000000 (  0.000079)
# quicksort(thousand_rand_arr   0.000000   0.000000   0.000000 (  0.004939)