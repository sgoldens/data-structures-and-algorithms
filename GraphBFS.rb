# File: GraphBFS.rb
#
# Author: Sasha Goldenson
#
# License: Free to use
#
# Breadth First Search (BFS) is one of the fundamental algorithms for traversing or searching trees and graphs. We'll focus on how to use it on graphs.
# 
# Unlike trees, graphs do not necessarily have a root Vertex. Instead, the beginning point in a walk between graph points is called the Source,
# and the ending point is called the Terminal. Furthermore, for BFS, the starting point is sometimes called its 'search_key.'
#
# BFS needs a 'search_key' to run on its graph. Our BFS uses additional two data structures, an array as an adjacency list and 
# a hash to keep track of which Vertices have already been visited. Our BFS prints the path walked and returns true if the 'search_key' is found, 
# or false if the 'search_key' does not exist in the graph.
#
#   Additional definitions of terms for Graph Theory (https://en.wikipedia.org/wiki/Graph_theory)
#
#   - Walk: a path of edges and vertices
#
#   - Cycle: "a cycle is a path of edges and vertices wherein a vertex is reachable from itself." (https://en.wikipedia.org/wiki/Cycle_(graph_theory)
#
#   - Degree (or Valency): For a graph, it's the total number of degrees of its vertices, and for a Vertex it's is the number of its edges. In an 
# undirected graph, the degree of a vertex can be easily found on paper by drawing a circle around the Vertex and counting the number of Edges 
# connecting to it. On a directed graph, the degree of a vertex is found only by evaluating all paths to it.
#
#   - Closed walk: a cycle which had the same vertex serving as source and terminal. Which vertex is considered the starting point on a cycle doesn't 
# change the cycle.
#
#   - Strongly connected: A path exists between every Vertex.
#
#   - Simple cycle: a cycle where each Vertex is only visited once.
#
##########
# Unit Tests
##########

require_relative('Graph')

class GraphBFSTest < Test::Unit::TestCase
  
  def test_graph_bfs_returns_true_when_target_is_found
    test = GraphBFS.new
    test.populate([[0,1], [0,2], [0,3], [1,4], [1,6], [1,8], [2,3], [2,7], [2,8], [3,1], [3,8], [4,6], [5,7], [5,8], [6,4], [6,9], [7,4], [8,1], [9,4]])

    assert_equal(true, test.bfs(0))
    assert_equal(true, test.bfs(1))
    assert_equal(true, test.bfs(2))
    assert_equal(true, test.bfs(3))
    assert_equal(true, test.bfs(4))
    assert_equal(true, test.bfs(5))
    assert_equal(true, test.bfs(6))
    assert_equal(true, test.bfs(7))
    assert_equal(true, test.bfs(8))
    assert_equal(true, test.bfs(9))
  end

  def test_graph_bfs_returns_true_when_target_is_not_found
    test = GraphBFS.new
    test.populate([[0,1], [0,2], [0,3], [1,4], [1,6], [1,8], [2,3], [2,7], [2,8], [3,1], [3,8], [4,6], [5,7], [5,8], [6,4], [6,9], [7,4], [8,1], [9,4]])
    
    assert_equal(false, test.bfs(10))
    assert_equal(false, test.bfs("10"))
    assert_equal(false, test.bfs(99))
  end
end

################
# GraphBFS class
################

class GraphBFS < Graph

  def initialize
    super
  end

 # Breadth First Search (BFS)
  def bfs(search_key)
    # Create a FIFO queue using Array#push to enqueue and Array#shift to dequeue
    queue = Array.new
    # Create a hash to track what's already been seen
    visited = {}
    # If the search_key exists in the graph
    if get_vertex(search_key)
      # Mark it as visited
      visited[search_key] = true
    end

    # Build the adjacency list for this graph and feed it into the queue
    @vertices.each do |vertex|
      queue << find_neighbors(vertex[1].value)
    end

    # Loop through the adjacency list
    queue.each do |edges|
      # and loop through each edge
      edges.each do |edge_to|
        # and when a directed edge goes to a previously unvisited Vertex
        if !visited[edge_to]
          # Mark that Vertex as now visited
          visited[edge_to] = true
        end
      end
    end

    # If the search_key exists in the visited hash populated during graph BFS traversal
    if visited[search_key] 
      return true
    else
      return false
    end
  end

end