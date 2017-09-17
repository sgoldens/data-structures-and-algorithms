require_relative('../Graph')

################
# GraphBFS class
################

class GraphBFS < Graph

  def initialize
    super
  end

 # Breadth First Search (BFS) graph traversal 
  def bfs(search_key)
    # Track the traversal walked
    walked = []
    # Create a FIFO queue using Array#push to enqueue and Array#shift to dequeue
    queue = Array.new
    # Build the adjacency list for this graph by feeding each Vertex's edges into the queue
    @vertices.each do |vertex|
      queue << find_neighbors(vertex[1].value)
    end
    # Create a hash to track what's already been seen
    visited = {}
    # Check if the search_key exists as a starting point and
    # If the search_key exists in the graph
    if @vertices[search_key]
      # Mark it as visited
      visited[search_key] = true
      # and add it as the first vertex visited
      walked << search_key
    end
    # Loop through the adjacency list as a queue
    queue.each do |edges|
      # and loop through each adjacency list element as a collection of edges
      edges.each do |edge_to|
        # and when a edge goes to a previously unvisited Vertex
        if !visited[edge_to]
          # Mark that Vertex as now visited
          visited[edge_to] = true
          # And add it as the next step of our BFS walk
          walked << edge_to
        end
      end
    end
    # Return the walked BFS traversal path if the search_key was visited
    if visited[search_key] 
      walked
    # Else return false
    else
      false
    end
  end

end


############
# Unit Tests
############

class GraphBFSTest < Test::Unit::TestCase
  
  def test_graph_bfs_returns_true_when_target_is_found
    test = GraphBFS.new
    test.populate_directed([[0,1], [0,2], [0,3], [1,4], [1,6], [1,8], [2,3], [2,7], [2,8], [3,1], [3,8], [4,6], [5,7], [5,8], [6,4], [6,9], [7,4], [8,1], [9,4]])

    assert_equal([0, 1, 2, 3, 4, 6, 8, 7, 9], test.bfs(0))
    assert_equal([1, 2, 3, 4, 6, 8, 7, 9], test.bfs(1))
    assert_equal([2, 1, 3, 4, 6, 8, 7, 9], test.bfs(2))
    assert_equal([3, 1, 2, 4, 6, 8, 7, 9], test.bfs(3))
    assert_equal([4, 1, 2, 3, 6, 8, 7, 9], test.bfs(4))
    assert_equal([5, 1, 2, 3, 4, 6, 8, 7, 9], test.bfs(5))
    assert_equal([6, 1, 2, 3, 4, 8, 7, 9], test.bfs(6))
    assert_equal([7, 1, 2, 3, 4, 6, 8, 9], test.bfs(7))
    assert_equal([8, 1, 2, 3, 4, 6, 7, 9], test.bfs(8))
    assert_equal([9, 1, 2, 3, 4, 6, 8, 7], test.bfs(9))
  end

  def test_graph_bfs_returns_false_when_target_is_not_found
    test = GraphBFS.new
    test.populate_directed([[0,1], [0,2], [0,3], [1,4], [1,6], [1,8], [2,3], [2,7], [2,8], [3,1], [3,8], [4,6], [5,7], [5,8], [6,4], [6,9], [7,4], [8,1], [9,4]])
    
    assert_equal(false, test.bfs(10))
    assert_equal(false, test.bfs("10"))
    assert_equal(false, test.bfs(99))
  end
end