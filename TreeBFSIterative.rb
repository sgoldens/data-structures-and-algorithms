class Node
  attr_accessor :value, :left, :right

  def initialize(options={})
    @value = options[:value]
    @left = options[:left]
    @right = options[:right]
  end

end

def iterative_bfs(node)
  results = []
  queue = []
  queue.push(node)

  while(queue.length != 0)
    nxt = queue.shift
    results << nxt.value

    if nxt.left
      queue.push(nxt.left)
    end
    if nxt.right
      queue.push(nxt.right)
    end
  end
  results
end
RESULT = []
def recursive_dfs(node)
  RESULT << node.value
  if node.left
    recursive_dfs(node.left)
  end
  if node.right
    recursive_dfs(node.right)
  end
end

root = Node.new(options={:value => 1})
child_1 = Node.new(options={:value => 2})
child_2 = Node.new(options={:value => 4})
grandchild_1 = Node.new(options={:value => 3})
grandchild_2 = Node.new(options={:value => 5})
root.left = child_1
root.right = child_2
child_1.right = grandchild_1
child_2.left = grandchild_2

p iterative_bfs(root) === [1,2,4,3,5]
p iterative_bfs(root) != [1,2,3,4,5]
recursive_dfs(root)
p RESULT === [1,2,3,4,5] 
p recursive_dfs(root) != [1,2,4,3,5]