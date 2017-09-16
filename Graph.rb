##############
# Vertex class
##############

class Vertex

  attr_accessor :value, :edges

  def initialize(id=nil, edges={})
    @value = id
    @edges = edges
  end

end

#############
# Graph class
#############

class Graph

  attr_accessor :vertices, :total_vertices, :total_edges, :args

  def initialize()
    @total_vertices = 0
    @total_edges = 0
    @vertices = {}
  end

  def add_vertex(id)
    if @vertices
      if !@vertices[id]
        new_vertex = Vertex.new
        new_vertex.value = id
        self.vertices[id] = new_vertex
        self.total_vertices += 1
      else
        return "Vertex with id: #{id} already exists in graph" 
      end
    end
  end

  def get_vertex(id)
    if @vertices
      if !@vertices[id]
        return false
      else
        return vertices[id]
      end
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
    if @vertices
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

  def populate_undirected(edge_tuples_arr)
    if !@vertices
      @vertices = {}
    end
    edge_tuples_arr.each do |edge|
      self.add_vertex(edge[0]) if !@vertices[edge[0]]
      self.add_vertex(edge[1]) if !@vertices[edge[1]]
      self.add_edge(edge[0], edge[1])
      self.add_edge(edge[1], edge[0])
    end
  end

  def populate_directed(edge_tuples_arr)
    if !@vertices
      @vertices = {}
    end
    edge_tuples_arr.each do |edge|
      self.add_vertex(edge[0]) if !@vertices[edge[0]]
      self.add_vertex(edge[1]) if !@vertices[edge[1]]
      self.add_edge(edge[0], edge[1])
    end
  end

end

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
    test = Graph.new()
    test.add_vertex(1)
    test.add_vertex(2)
    test.add_edge(1,2)

    assert_instance_of(Vertex, test.vertices[1])
    assert_equal({2=>2}, test.vertices[1].edges)
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

  def test_graph_get_vertex_returns_false_when_vertex_does_not_exist
    test = Graph.new
    test.add_vertex(9)

    assert_equal(false, test.get_vertex(12))
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

  def test_graph_populate_directed_from_edge_tuples_arr
    test = Graph.new
    edge_tuples_arr = [[0,1], 
                                   [0,2], 
                                   [0,3], 
                                   [1,4], 
                                   [1,6], 
                                   [1,8], 
                                   [2,3], 
                                   [2,7], 
                                   [2,8], 
                                   [3,1], 
                                   [3,8], 
                                   [4,6], 
                                   [5,7], 
                                   [5,8], 
                                   [6,4], 
                                   [6,9], 
                                   [7,4], 
                                   [8,1], 
                                   [9,4]]
    test.populate_directed(edge_tuples_arr)

    test.vertices.length.times do |i| 
      assert_instance_of(Vertex, test.vertices[i])
    end
    assert_equal([1,2,3], test.find_neighbors(0))
    assert_equal([4,6,8], test.find_neighbors(1))
    assert_equal([3,7,8], test.find_neighbors(2))
    assert_equal([1,8], test.find_neighbors(3))
    assert_equal([6], test.find_neighbors(4))
    assert_equal([7,8], test.find_neighbors(5))
    assert_equal([4,9], test.find_neighbors(6))
    assert_equal([4], test.find_neighbors(7))
    assert_equal([1], test.find_neighbors(8))
    assert_equal([4], test.find_neighbors(9))
    assert_equal(10, test.vertices.length)
    assert_equal(10, test.total_vertices)
    assert_equal(19, test.total_edges)
    assert_equal(nil, test.vertices[10])
  end

  def test_graph_populate_undirected_from_edge_tuples_arr
    test = Graph.new
    edge_tuples_arr = [[0,1], 
                                   [0,2], 
                                   [0,3], 
                                   [1,4], 
                                   [1,6], 
                                   [1,8], 
                                   [2,3], 
                                   [2,7], 
                                   [2,8], 
                                   [3,1], 
                                   [3,8], 
                                   [4,6], 
                                   [5,7], 
                                   [5,8], 
                                   [6,4], 
                                   [6,9], 
                                   [7,4], 
                                   [8,1], 
                                   [9,4]]
    test.populate_undirected(edge_tuples_arr)

    test.vertices.length.times do |i| 
      assert_instance_of(Vertex, test.vertices[i])
    end
    assert_equal([1,2,3], test.find_neighbors(0))
    assert_equal([0,4,6,8,3], test.find_neighbors(1))
    assert_equal([0,3,7,8], test.find_neighbors(2))
    assert_equal([0,2,1,8], test.find_neighbors(3))
    assert_equal([1,6,7,9], test.find_neighbors(4))
    assert_equal([7,8], test.find_neighbors(5))
    assert_equal([1,4,9], test.find_neighbors(6))
    assert_equal([2,5,4], test.find_neighbors(7))
    assert_equal([1,2,3,5], test.find_neighbors(8))
    assert_equal([6,4], test.find_neighbors(9))
    assert_equal(10, test.vertices.length)
    assert_equal(10, test.total_vertices)
    assert_equal(34, test.total_edges)
    assert_equal(nil, test.vertices[10])
  end

end
