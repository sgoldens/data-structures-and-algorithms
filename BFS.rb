# BFS.rb
#
# Breadth First Search (BFS): one of the fundamental algorithms for traversing or searching trees and graphs. We'll focus on how to use it on graphs.
# 
# Unlike trees, graphs do not necessarily have a root Vertex. Instead, the beginning point in a walk between graph points is called the Source,
# and the ending point is called the Terminal. Furthermore, for BFS, the starting point is sometimes called a, 'search_key.'
#
# BFS takes as two arguments: a graph to search, and a 'search_key'. It uses two arrays, one as a priority queue and the other as
# a way to keep track of which Vertices have already been seen. BFS returns the path walked in searching, or false depending on whether or not the
# search target is present in the graph.
#
# The computational time complexity of BFS is the sum of all Vertices and Edges, or O(V + E) in asymptotic notation.  When we know the number of
# vertices beforehand and have an additional data structure to track which vertices have already been visited, O(E) can vary from O(1), "Constant", to
# O(V²), "Quadratic." ()
#
# Given a populated graph, with vertices and directed edges, BFS can reveal if there is a path between two points on the graph.
#
# First, some definitions of terms to help comprehension: Graph Theory (https://en.wikipedia.org/wiki/Graph_theory)
#
# Walk: a path of edges and vertices
#
# Cycle: "a cycle is a path of edges and vertices wherein a vertex is reachable from itself." (https://en.wikipedia.org/wiki/Cycle_(graph_theory)
#
# Degree (or Valency): For a graph, it's the total number of degrees of its vertices, and for a Vertex it's is the number of its edges. In an 
# undirected graph, the degree of a vertex can be easily found on paper by drawing a circle around the Vertex and counting the number of Edges 
# connecting to it. On a directed graph, the degree of a vertex is found only by evaluating all paths to it.
#
# Closed walk: a cycle which had the same vertex serving as source and terminal. Which vertex is considered the starting point on a cycle doesn't 
# change the cycle.
#
# Strongly connected: A path exists between every Vertex.
#
# Simple cycle: a cycle where each Vertex is only visited once. Finding the most efficient path on a directed graph can be found if the graph is both 
# strongly connected and even in its number of inding the most efficient path on a weighted, directed graph is a problem of the highest order of complexity, NP-complete.
#
#
require_relative('Graph')
require 'test/unit'
require 'pp'

class GraphBFSTest < Test::Unit::TestCase

  def test_graph_bfs_returns_true_when_target_is_found
    test = Graph.new
    test.populate([[0,1], [0,2], [0,3], [1,4], [1,6], [1,8], [2,3], [2,7], [2,8], [3,1], [3,8], [4,6], [5,7], [5,8], [6,4], [6,9], [7,4], [8,1], [9,4]])

    assert_not_equal(true, test.bfs(11))
  end

  def test_graph_bfs_returns_true_when_target_is_not_found
    test = Graph.new
    test.populate([[0,1], [0,2], [0,3], [1,4], [1,6], [1,8], [2,3], [2,7], [2,8], [3,1], [3,8], [4,6], [5,7], [5,8], [6,4], [6,9], [7,4], [8,1], [9,4]])
    
    assert_not_equal(false, test.bfs(test, 99))
  end

end

def bfs

bfs_graph_tuples = Graph.new
pp bfs_graph_tuples.populate([[0,1], [0,2], [0,3], [1,4], [1,6], [1,8], [2,3], [2,7], [2,8], [3,1], [3,8], [4,6], [5,7], [5,8], [6,4], [6,9], [7,4], [8,1], [9,4]])