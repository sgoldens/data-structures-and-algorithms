# Graph is a Tree
# Given an undirected graph, determine whether or not said graph is a tree.

# Input: [[1,0], [2,0], [0,3], [3,4]]
# Output: True

# Input: [[1,0], [2,0], [1,2], [0,3], [3,4]]
# Output: False

def is_tree?(edges)
  adjacency_list = {}
  visited = {}

  # build an adjacency list
  edges.each do |edge|
    if !adjacency_list[edge[0]]
      adjacency_list[edge[0]] = [edge[1]]
    end
    if !adjacency_list[edge[1]]
      adjacency_list[edge[1]] = [edge[0]]
    end
    if !adjacency_list[edge[0]].include?edge[1]
      adjacency_list[edge[0]].push(edge[1])
    end
    if !adjacency_list[edge[1]].include?edge[0]
      adjacency_list[edge[1]].push(edge[0])
    end
  end

  # seed the Queue
  queue = [0]
  while !queue.empty?
    node = queue.shift
    if visited[node] === 1
      return false
    end
    visited[node] = 1
    adjacency_list[node].each do |neighbor|
      queue.push(neighbor)
      adjacency_list[neighbor].delete(node)
    end
  end  
  true
end

a_tree = [[1,0], [2,0], [0,3], [3,4]]
not_a_tree = [[1,0], [2,0], [1,2], [0,3], [3,4]]
p is_tree?(a_tree) === true
p is_tree?(not_a_tree) === false