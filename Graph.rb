# Graph.rb
#
# Graph data structures can describe relationships between different points.
#
# Instead of Nodes or Arrays to hold data, we're going to use the Vertex class, which will contain a value a edges hash. Edges are the relationships 
# between Vertices, and a adjacency matrix is made of multiple edges and describes paths between vertices. 
#
# To manipulate our Graph class, it'll have the following attributes:
#   - vertices
#   - total_vertices
#   - total_edges
# 
# and methods:
#   - addVertex
#   - getVertex
#   - removeVertex
#   - addEdge
#   - removeEdge
#   - findNeighbors
#   - forEachVertex
#   - forEachEdge
#
###############
# Unit Tests
###############

require 'test/unit'

class VertexTest < Test::Unit::TestCase

  def test_vertex_can_be_created
    test = Vertex.new

    assert_not_equal(nil, test)
  end

  def test_vertex_has_properties
    test = Vertex.new

    assert_respond_to(test, :value)
    assert_respond_to(test, :edges)
  end

  def test_vertex_can_hold_value
    test = Vertex.new(121)

    assert_equal(121, test.value)
  end

  def test_vertex_can_hold_edges
    test = Vertex.new(121)
    other_vertex = Vertex.new(89)
  end

end

class GraphClassTest

  def test_graph_has_properties
    test = Graph.new

    assert_respond_to(test, :vertices)
    assert_respond_to(test, :total_vertices)
    assert_respond_to(test, :total_edges)
  end

  def test_graph_has_methods

  end

end

###########
# Vertex class
###########

class Vertex

  attr_accessor :value, :edges

  def initialize(id=nil)
    @value = id
    @edges = {}
  end

end

###########
# Graph class
###########

def Graph

  attr_accessor :vertices, :total_vertices, :total_edges

  def initialize
    @vertices = {}
    @total_vertices = 0
    @total_edges = 0
  end

  def add_vertex(id)
    # to prevent overwriting
    # TO-DO: handle data collisions more gracefully than dismissal
    if self.vertices[id] == nil
      new_vertex = Vertex(id).new
      self.vertices[id] = new_vertex
      self.total_vertices += 1
    end
  end

end