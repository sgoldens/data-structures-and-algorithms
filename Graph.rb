# Graph.rb
#
# Graph data structures can describe relationships between different points.
#
# Instead of Nodes or Arrays to hold data, we're going to use the Vertex class, which will contain a value and an edges hash. Edges are
# the relationships between Vertices, and a adjacency matrix is made of multiple edges and describes paths between vertices. 
#
# Graphs can be directed or undirected. Undirected Graphs have edges which are bidirectional, they know about each other. Directed graphs have
# edges which go one way, and can also have edges in both directions making bidirectional edges. We'll use a directed graph for our code.
#
# To manipulate our Graph class, it'll have the following attributes:
#   - vertices
#   - total_vertices
#   - total_edges
# 
# and methods:
#   - add_vertex
#   - get_vertex
#   - remove_vertex
#   - add_edge
#   - remove_edge
#   - find_neighbors
#   - for_each_vertex
#   - for_each_edge
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

class GraphClassTest < Test::Unit::TestCase

  def test_graph_has_properties
    test = Graph.new

    assert_respond_to(test, :vertices)
    assert_respond_to(test, :total_vertices)
    assert_respond_to(test, :total_edges)
  end

  def test_graph_has_methods
    test = Graph.new

    assert_respond_to(test, :add_vertex)
    assert_respond_to(test, :get_vertex)
    assert_respond_to(test, :remove_vertex)
    assert_respond_to(test, :add_edge)
    assert_respond_to(test, :remove_edge)
    assert_respond_to(test, :find_neighbors)
  end

  def test_graph_add_vertex_adds_to_graph_and_count
    test = Graph.new

    assert_equal(0, test.total_vertices)
    assert_equal({}, test.vertices)
    test.add_vertex(8)

    assert_equal(1, test.total_vertices)
    assert_instance_of(Vertex, test.vertices[8])
  end

  def test_graph_get_vertex_gets_target_vertex
    test = Graph.new
    test.add_vertex(9)

    assert_instance_of(Vertex, test.get_vertex(9))
  end

  def test_graph_get_vertex_does_not_get_vertex_which_do_not_exist
    test = Graph.new
    test.add_vertex(9)

    assert_equal("ID does not exist in graph.", test.get_vertex(12))
  end


  def test_graph_remove_vertex_reduces_graph_and_count
    test = Graph.new
    test.add_vertex(2)
    test.add_vertex(7)
    test.add_edge(2, 7)
    assert_equal(1, test.total_edges)
    assert_equal(2, test.total_vertices)
    assert_instance_of(Vertex, test.vertices[2])

    test.remove_vertex(2)

    assert_equal(1, test.total_vertices)
    assert_equal(0, test.total_edges)
    test.remove_vertex(7)

    assert_equal({}, test.vertices)
  end

  def test_graph_add_edge_adds_edges_to_vertices_edges_and_total_edges
    test = Graph.new
    test.add_vertex(2)
    test.add_vertex(3)
    test.add_vertex(10)

    assert_equal(0, test.total_edges)

    test.add_edge(2, 10)

    assert_equal(1, test.total_edges)

    test.add_edge(3, 10)

    assert_equal({}, test.vertices[10].edges)
    assert_equal({10=>10}, test.vertices[2].edges)
    assert_equal({10=>10}, test.vertices[3].edges)
    assert_equal(2, test.total_edges)
  end

  def test_graph_remove_edge_removes_edge_and_reduces_total_edges
    test = Graph.new
    test.add_vertex(1)
    test.add_vertex(148)
    test.add_edge(148,1)

    assert_equal(1, test.total_edges)
    assert_equal({1=>1}, test.vertices[148].edges)

    test.remove_edge(148,1)

    assert_equal(0, test.total_edges)
    assert_equal({}, test.vertices[148].edges)
  end

  def test_graph_find_neighbors
    test = Graph.new
    test.add_vertex(6)
    test.add_vertex(29)
    test.add_vertex(42)
    test.add_vertex(194)
    test.add_edge(6,29)
    test.add_edge(6,42)
    test.add_edge(6,194)
    test.add_edge(29,42)
    test.add_edge(29,194)
    test.add_edge(42,194)

    assert_equal([29, 42, 194], test.find_neighbors(6))
    assert_equal([42, 194], test.find_neighbors(29))
    assert_equal([194], test.find_neighbors(42))
    assert_equal([], test.find_neighbors(194))
  end

end

##############
# Vertex class
##############

class Vertex

  attr_accessor :value, :edges

  def initialize(id=nil)
    @value = id
    @edges = {}
  end

end

#############
# Graph class
#############

class Graph

  attr_accessor :vertices, :total_vertices, :total_edges

  def initialize
    @vertices = {}
    @total_vertices = 0
    @total_edges = 0
  end

  def add_vertex(id)
    if !vertices[id]
      new_vertex = Vertex.new
      new_vertex.value = id
      self.vertices[id] = new_vertex
      self.total_vertices += 1
    end
  end

  def get_vertex(id)
    if !vertices[id]
      return "ID does not exist in graph."
    else
      return vertices[id]
    end
  end

  def remove_vertex(id)
    if !vertices[id]
      return "ID does not exist in graph."
    end
    if @vertices[id]
      if @vertices[id].edges
        @vertices[id].edges.each do |key, value|
          @vertices[key].edges.delete(id)
          @total_edges -= 1
        end
      end
      @vertices.delete(id)
      @total_vertices -= 1
    end
  end

  def add_edge(from_id,to_id)
    if vertices[from_id] && vertices[to_id]
      if vertices[from_id].edges[to_id] && vertices[to_id].edges[from_id]
        return "Edge already exists between from_id and to_id"
      else
        vertices[from_id].edges[to_id] = to_id
        @total_edges += 1
      end
    else
      return "Either Vertex of id1 or id2 do not exist in graph."
    end
  end

  def remove_edge(from_id,to_id)
    if vertices[from_id] && vertices[to_id] 
      vertices[from_id].edges[to_id] && vertices[to_id].edges[from_id]
      vertices[from_id].edges.delete(to_id)
      @total_edges -= 1
    else
      return "Either Vertex of id1 and/or to_id do not exist in graph."
    end
  end

  def find_neighbors(id)
    neighbors = []
    if vertices[id]
      vertices[id].edges.each do |to|
        neighbors << to[0]
      end
      neighbors
    end
  end

end