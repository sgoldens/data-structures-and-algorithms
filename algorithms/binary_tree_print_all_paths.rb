
# Print all paths from root to leaf nodes
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
#
#
#
# Example output:
# 
#  ["ABDE", "ABDFGH", "ABI", "ACJ", "ACKLM"]
#   

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

def print_all_paths_recursive(node)

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

# Referenced sites: 
#   - http://www.geeksforgeeks.org/given-a-binary-tree-print-all-root-to-leaf-paths/
#   - http://blog.gainlo.co/index.php/2016/04/15/print-all-paths-of-a-binary-tree/
#   - https://discuss.leetcode.com/topic/70565/ruby-solution
