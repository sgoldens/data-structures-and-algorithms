# 653. Two Sum IV - Input is a BST

# Given a Binary Search Tree and a target number, return true if there exist two elements in the BST such that their sum is equal to the given target.

# Example 1:
# Input: 
#     5
#    / \
#   3   6
#  / \   \
# 2   4   7

# Target = 9

# Output: True
# Example 2:
# Input: 
#     5
#    / \
#   3   6
#  / \   \
# 2   4   7

# Target = 28

# Output: False


# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end

# @param {TreeNode} root
# @param {Integer} k
# @return {Boolean}
def find_target(root, k)
    return false if root.val === nil
    values = []    
    queue = [root]
    
    while queue.length > 0
        current = queue.pop
        values << current.val
        if current.left
            queue.push(current.left)
        end
        if current.right
            queue.push(current.right)
        end    
    end
    values.sort!
            
    values.each_with_index do |value1, ind1|
        target = k - value1
        values.each_with_index do |value2, ind2|
            if ind1 != ind2
                return true if value2 === target
            end
        end
    end
    
    return false
end