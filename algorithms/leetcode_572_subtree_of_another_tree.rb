=begin
    572. Subtree of Another Tree
    https://leetcode.com/problems/subtree-of-another-tree/description/

    Given two non-empty binary trees s and t, check whether tree t has exactly the same structure and node values with a subtree of s. A subtree of s is a tree consists of a node in s and all of this node's descendants. The tree s could also be considered as a subtree of itself.

    Example 1:
    Given tree s:

         3
        / \
       4   5
      / \
     1   2
    Given tree t:
       4 
      / \
     1   2
    Return true, because t has the same structure and node values with a subtree of s.
    Example 2:
    Given tree s:

         3
        / \
       4   5
      / \
     1   2
        /
       0
    Given tree t:
       4
      / \
     1   2
    Return false.
=end
require('pp')
# Definition for a binary tree node.
class TreeNode
    attr_accessor :val, :left, :right
    def initialize(val)
        @val = val
        @left, @right = nil, nil
    end
end

# @param {TreeNode} s
# @param {TreeNode} t
# @return {Boolean}
def is_subtree(s, t)
  subtree = nil

  traverse = -> node {
    queue = [node]
    # node_levels = {node.val => nil}
    nodes = [node.val]
    level = 1
    while !queue.empty? do
      next_node = queue.pop
      if next_node.left
        queue.push(next_node.left)
        nodes << next_node.left.val
      else
        nodes.push("no left")
      end
      if next_node.right
        queue.push(next_node.right)
        nodes << next_node.right.val
        # node_levels[next_node.right.val] = next_node.val
      else
        nodes.push("no right")
      end
      level += 1
    end
    nodes
  }

  p tree_t = traverse.call(t)
  p tree_s = traverse.call(s)


end

t0 = TreeNode.new(4)
t1 = TreeNode.new(1)
t2 = TreeNode.new(2)

t0.left = t1
t0.right = t2

s0 = TreeNode.new(3)
s1 = TreeNode.new(4)
s2 = TreeNode.new(5)
s3 = TreeNode.new(1)
s4 = TreeNode.new(2)

s0.left = s1
s0.right = s2
s1.left = s3
s1.right = s4

is_subtree(s0, t0)