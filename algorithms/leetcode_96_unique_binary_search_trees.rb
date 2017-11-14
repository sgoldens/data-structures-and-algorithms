# https://leetcode.com/problems/unique-binary-search-trees/description/

# Given n, how many structurally unique BST's (binary search trees) that store values 1...n?

# For example,
# Given n = 3, there are a total of 5 unique BST's.

#    1         3     3      2      1
#     \       /     /      / \      \
#      3     2     1      1   3      2
#     /     /       \                 \
#    2     1         2                 3

# @param {Integer} n
# @return {Integer}
def num_trees(n)
  return 1 if n === 0
  return 1 if n === 1
  result = Array.new(n + 1) { |n| 0}
  result[0], result[1], result[2] = 1,1,2
  return result[n] if n < 3
  3.upto(n) do |i|
    1.upto(i) do |k|
      result[i] = result[i] + result[k - 1] * result[i-k]
    end
  end
  result[n]
end

p num_trees(3)
p num_trees(6)