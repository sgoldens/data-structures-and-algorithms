# source: https://leetcode.com/problems/subsets/description/
# 78. Subsets I
# Given a set of distinct integers, nums, return all possible subsets (the power set).

# Note: The solution set must not contain duplicate subsets.

# For example,
# If nums = [1,2,3], a solution is:

# [
#   [3],
#   [1],
#   [2],
#   [1,2,3],
#   [1,3],
#   [2,3],
#   [1,2],
#   []
# ]
  # @param {Integer[]} nums
  # @return {Integer[][]}
  def subsets(nums)
    # result = [[]]
    # Injects into a blank array of arrays.
    # acc is what we're injecting into
    # you is each element of the array
    nums.reduce([[]]) do |acc, you|
      ret = []             # Set up a new array to add into
      acc.each do |i|      # For each array in the injected array,
        ret << i           # Add itself into the new array
        ret << i + [you]   # Merge the array with a new array of the current element
      end
      ret       # Return the array we're looking at to inject more.
    end
  end

# Unit tests
puts subsets([1,2,3]) === [[], [3], [2], [2, 3], [1], [1, 3], [1, 2], [1, 2, 3]]