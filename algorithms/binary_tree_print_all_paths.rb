
# Print all paths from the root node to leaf nodes
# 
# Example input:
#

#            A     @root
#          /   \ 
#         B      C   #child
#        / \    /  \
#       D   I  J    K    #grandchild
#      / \           \ 
#     E   F           L    #great_grandchild
#          \           \
#           G           M     #great_great_grandchild
#            \
#             H                 #great_great_great_grandchild
#
# Example output:
# 
#  ["ABDE", "ABDFGH", "ABI", "ACJ", "ACKLM"]
#   
# Solution : 
#   1) check for an empty root node, return if so
#   2) a) declare an new array called     paths
#      b) another new array called    root_node, with element one as
#           the root node and the second element as the root node value
#      c) declare a third array called    queue, and make the first element
#           the root_node array from step 2b)
#   3) loop over the queue until it is empty
#        a) each iteration shifting the queue's first element into 
#             two variables, parent & path
#        b) if parent.left && parent.right are empty, we're at a leaf node
#             so push the accumulated path var to the paths array
#        c) else, if there is a parent.left node, push that into the queue
#             as an array of [parent.left, path + parent.left.value]
#             ... and do the same check and push for 
#             any [parent.right, path + parent.right.value]
#   4) after exiting the loop, (optionally sort* and) return the paths array
# 
#      * The added #sort method on the return value bloats the runtime from
#          from O(n) to O(n log n), which is only worth doing in cases
#          where sorted returned arrays are a neccesssity.


class Node
  
  attr_accessor :value, :left, :right

  def initialize(options={})
    @value = options[:value]
    @left = options[:left]
    @right = options[:right]
  end

end

def print_all_paths_iterative(root)
  return [] if root.nil?

  paths = []
  root_node = [root, root.value]
  queue = [root_node]

  until queue.empty?
    parent, path = queue.shift
    if parent.left.nil? && parent.right.nil?
      paths << path
    else
      queue << [ parent.left,  path + parent.left.value   ] if parent.left
      queue << [ parent.right, path + parent.right.value  ] if parent.right
    end
  end

  paths.sort
end

root = Node.new(options={value: "A"})
child_1 = Node.new(options={value: "B"})
child_2 = Node.new(options={value: "C"})
grandchild_1 = Node.new(options={value: "D"})
grandchild_2 = Node.new(options={value: "I"})
grandchild_3 = Node.new(options={value: "J"})
grandchild_4 = Node.new(options={value: "K"})
great_grandchild_1 = Node.new(options={value: "E"})
great_grandchild_2 = Node.new(options={value: "F"})
great_grandchild_3 = Node.new(options={value: "L"})
great_great_grandchild_1 = Node.new(options={value: "G"})
great_great_grandchild_2 = Node.new(options={value: "M"})
great_great_great_grandchild_1 = Node.new(options={value: "H"})
root.left = child_1 #B
root.right = child_2 #C
child_1.left = grandchild_1 #D
child_1.right = grandchild_2 #I
child_2.left = grandchild_3 #J
child_2.right = grandchild_4 #K
grandchild_1.left = great_grandchild_1 #E
grandchild_1.right = great_grandchild_2 #F
grandchild_4.right = great_grandchild_3 #L
great_grandchild_2.right = great_great_grandchild_1 # G
great_grandchild_3.right = great_great_grandchild_2 # M
great_great_grandchild_1.right = great_great_great_grandchild_1 # H

p print_all_paths_iterative(root) === ["ABDE", "ABDFGH", "ABI", "ACJ", "ACKLM"]
p print_all_paths_iterative(nil) === []

# Referenced sites: 
#   - http://www.geeksforgeeks.org/given-a-binary-tree-print-all-root-to-leaf-paths/
#   - http://blog.gainlo.co/index.php/2016/04/15/print-all-paths-of-a-binary-tree/
#   - https://discuss.leetcode.com/topic/70565/ruby-solution
