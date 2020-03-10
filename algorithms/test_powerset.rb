# def power_set(str)

#   # Scope Variables

#   result = Array.new()
#   library = Hash.new()

#   # Helper Function
#   traverse = -> accum, depth {

#     # Base Case
#     if depth == str.length


#       # Alphabetize key, so in cases like 'ab' != 'ba', such that            \
#       #   only one existing record is necessary to check both combinations.
#       key = accum.split('').sort.join('')
#       # Add logic to check if a subset is undefined within the hash. If it is, 
#       #   add it to the results and hash variables. Else, skip recording the duplicate.
#      if !library[key]

#        result.push(accum)

#        library[key] = true

#      end

#    return result

#     # Recursive Case (Left side of the tree)

#     traverse.call(accum, depth + 1)

#     # Recursive Case (Right side of the tree)

#     traverse.call((accum + str[depth]), depth + 1)

# }

#   # Call Helper Function

#   traverse.call('',0)


#   # Return result

#   return result


# end
# # UNIT TESTS
# # # Should evaluate to TRUE
# # p power_set('abc') == ["", "c", "b", "bc", "a", "ac", "ab", "abc"]
# class Array
#   def power_set
 
#     # Injects into a blank array of arrays.
#     # acc is what we're injecting into
#     # you is each element of the array
#     inject([[]]) do |acc, you|
#       ret = []             # Set up a new array to add into
#       acc.each do |i|      # For each array in the injected array,
#         ret << i           # Add itself into the new array
#         ret << i + [you]   # Merge the array with a new array of the current element
#       end
#       ret       # Return the array we're looking at to inject more.
#     end
 
#   end
# end

# p [1,2,3].power_set


def subsets(nums)
  # result = [[]]
  # Injects into a blank array of arrays.
  # acc is what we're injecting into
  # you is each element of the array
  nums.reduce([[]]) do |acc, you|
    ret = [] # Set up a new array to add into
    acc.each do |i| # For each array in the injected array,
      ret << i # Add itself into the new array
      ret << i + [you] # Merge the array with a new array of the current element
      end
    ret # Return the array we're looking at to inject more.
  end
end
# Unit tests
puts subsets([1,2,3]) === [[], [3], [2], [2, 3], [1], [1, 3], [1, 2], [1, 2, 3]]