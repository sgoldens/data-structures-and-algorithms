# Requires PriorityQueue: gem install PriorityQueue

require 'test/unit'
require('priority_queue')
require_relative('Graph')

class WeightedGraph < Graph
  def initialize
    super
  end

  def add_weighted_vertex(id, weighted_edges)
    vertex = Vertex.new(id, weighted_edges)
    @vertices[id] = weighted_edges
    @total_vertices += 1
    @total_edges += weighted_edges.length
  end

end

##############
# Unit Tests
##############

class WeightedGraphTest < Test::Unit::TestCase

  def test_weighted_graph_has_methods
    test = WeightedGraph.new

    assert_respond_to(test, :add_weighted_vertex) 
  end

  def test_weighted_graph_add_weighted_vertex_creates_weighted_vertex
    test = WeightedGraph.new
    test_edges = {"B" => 12, "C" => 919, "D" => 488, "E" => 92, "F" => 42, "G" => 41, "H" => 43}
    test.add_weighted_vertex("A", test_edges)

    assert_not_equal(nil, test)
    assert_equal(test_edges, test.vertices["A"])
    assert_equal(7, test.total_edges)
    assert_equal(1, test.total_vertices)
  end 

end
