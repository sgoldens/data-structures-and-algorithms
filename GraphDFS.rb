# File: GraphDFS.rb
#
# Author: Sasha Goldenson
#
# License: Free to use
#
# Depth First Search (DFS) is one of the fundamental algorithms for traversing or searching trees and graphs. We'll focus on how to use it for
# traversing graphs.
# 
# Unlike trees, graphs do not necessarily have a root Vertex. Instead, the beginning point in a walk between graph points is called the Source,
# and the ending point is called the Terminal. Furthermore, for DFS, the starting point is sometimes called its 'search_key.'
#
# DFS needs a 'search_key' to run on its graph. Our DFS uses additional two data structures, an array as an adjacency list and 
# a hash to keep track of which edges have been walked. Our DFS traversal method returns true when it succeeds, else returns false. 
# 
# The find_path method uses DFS to return the shortest path walkable between the source and terminal, else returning false if no path exists.
#
##########
# Unit Tests
##########

require_relative('Graph')
require 'pp'

class GraphDFSTest < Test::Unit::TestCase
  
  def test_graph_dfs_returns_true_when_target_is_found
    test = GraphDFS.new
    test.populate([[0,1], [0,2], [0,3], [1,4], [1,6], [1,8], [2,3], [2,7], [2,8], [3,1], [3,8], [4,6], [5,7], [5,8], [6,4], [6,9], [7,4], [8,1], [9,4]])

    assert_equal(true, test.dfs(0))
    assert_equal(true, test.dfs(1))
    assert_equal(true, test.dfs(2))
    assert_equal(true, test.dfs(3))
    assert_equal(true, test.dfs(4))
    assert_equal(true, test.dfs(5))
    assert_equal(true, test.dfs(6))
    assert_equal(true, test.dfs(7))
    assert_equal(true, test.dfs(8))
    assert_equal(true, test.dfs(9))
  end

  def test_graph_dfs_returns_false_when_target_is_not_found
    test = GraphDFS.new
    test.populate([[0,1], [0,2], [0,3], [1,4], [1,6], [1,8], [2,3], [2,7], [2,8], [3,1], [3,8], [4,6], [5,7], [5,8], [6,4], [6,9], [7,4], [8,1], [9,4]])
    
    assert_equal(false, test.dfs(10))
    assert_equal(false, test.dfs(99))
  end

  def test_graph_dfs_find_path_returns_path_when_path_exists
    test = GraphDFS.new
    test.populate([[0,1], [0,2], [0,3], [1,4], [1,6], [1,8], [2,3], [2,7], [2,8], [3,1], [3,8], [4,6], [5,7], [5,8], [6,4], [6,9], [7,4], [8,1], [9,4]])
    
    assert_equal([0, 1, 4, 6, 9], test.find_path(0,9))
    assert_equal([2, 7], test.find_path(2,7))
  end

  def test_graph_dfs_find_path_returns_false_when_path_does_not_exists
    test = GraphDFS.new
    test.populate([[0,1], [0,2], [0,3], [1,4], [1,6], [1,8], [2,3], [2,7], [2,8], [3,1], [3,8], [4,6], [5,7], [5,8], [6,4], [6,9], [7,4], [8,1], [9,4]])
    
    assert_equal(false, test.find_path(4,5))
    assert_equal(false, test.find_path(9,8))
    assert_equal(false, test.find_path(0,5))
  end

end

################
# GraphDFS class
################

class GraphDFS < Graph

  def initialize
    super
    @visited = []
    @edge_to = {}
  end

 # Depth First Search (DFS)
  def dfs(search_key)
    # check for if the search_key exists
    return false unless get_vertex(search_key)
    # start with the search_key
    if get_vertex(search_key)
      # mark it as visited
      @visited << search_key
      # and for each of its neighbors
      find_neighbors(search_key).each do |neighbor|
        #  and unless the neighbor has already been visited
        next if @visited.include?(neighbor)
        # recursively run DFS on each unvisited neighbor
        dfs(neighbor)
        # and add a directed path record to @edge_to for the vertices traversed (for each recursive DFS call)
        @edge_to[neighbor] = search_key
      end
    end
    # return true to signify that DFS ran successfully
    return true
  end

  # Graph DFS, utilized to find the shortest path between two vertices
  def find_path(source, terminal)
    # run DFS to populate @visited [] and @edge_to {} using source as search_key
    dfs(source)
    # check that terminal is connected to source
    return false unless @visited.include?(terminal)
    # store the results path in an array
    path = []
    # store a pointer starting as terminal
    current = terminal

    # Loop, until terminal is equal to source
    while(current != source) do
      # by unshifting the pointer to the results path
      path.unshift(current)
      # and resetting the pointer to the next vertex stored in the results returned from DFS 
      current = @edge_to[current]
    end

    # cleanup after dfs
    @visited.clear
    # unshifting the source last and returning the results path
    path.unshift(source)
  end

end