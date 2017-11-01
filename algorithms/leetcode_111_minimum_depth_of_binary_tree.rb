# https://leetcode.com/problems/minimum-depth-of-binary-tree/description/
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end

# @param {TreeNode} root
# @return {Integer}
def min_depth(root)
    return 0 if root.nil?
    root_node = [root, 1]
    queue = [root_node]
    
    while !queue.empty?
        parent, depth = queue.shift
        if parent.left.nil? && parent.right.nil?
            return depth
        end
        queue << [parent.left, 1 + depth] if parent.left
        queue << [parent.right, 1 + depth] if parent.right
    end 
end