# WeightedGraph.rb
# 
# Djiisktra's Algorithm, single-source shortest path graph search

require 'test/unit'
require 'priority_queue'
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

  def djikstras_shortest_path(source, terminal)
    distances = {}
    previous = {}
    nodes = PriorityQueue.new
    results = ""
    cumulative_walk_score = []

    # check for both nodes existing in @vertices
    return false if !get_vertex(source) || !get_vertex(terminal)
    # initialize the source node distance as 0 and, ...
    @vertices.each do |vertex, weighted_edges|
        if vertex == source
          distances[vertex] = 0
          nodes[vertex] = 0
        # all other distances to infinity
        else
          distances[vertex] = Float::INFINITY
          nodes[vertex] = Float::INFINITY
        end
        # populate previous with each vertex
        previous[vertex] = nil
      end
  
    # the nodes PriorityQueue is used as a min heap to quickly find the smallest weight
    # among remaining nodes, O(1) "Constant" lookup 
    while nodes
      # store the smallest path as a temp var and delete it from the nodes
      smallest = nodes.delete_min_return_key
      # If we reached the terminal
      if smallest == terminal
        # declare results var
        path = []
        # loop through a record in the previous step of the path
        while previous[smallest]
          # push it to our results var
          path.push(smallest)
          # and loop through previous
          smallest = previous[smallest]
        end
        # Push the source onto the end
        path.push(source)
        # Shovel each result path element into the results string for displaying shortest path
        return "The shortest path from #{source} to #{terminal} is #{to_s path.reverse}."
      end

      # break if the rest of the node distances are infinite or nil after storing and deleting the next smallest step
      if (distances[smallest] == Float::INFINITY) or (smallest == nil)
        break
      end

      # grab each neighbor of smallest, and ...
      @vertices[smallest].each do | neighbor, value |
          # ... loop over the neighbors edges by summing that alternate distance
          # of the vertex values in smallest + each neighbor, and ...
          alt = distances[smallest] + @vertices[smallest][neighbor]
          # if the alternate route is smaller than the distance to its neighbor
          if alt < distances[neighbor]
            # choose that alternate path, store a record of it in the distances hash
            distances[neighbor] = alt
            # put it in the previous hash as a distance for smallest
            previous[neighbor] = smallest
            # and set the value of that neighbor in our min-heap PriorityQueue
            nodes[neighbor] = alt
          end
        end
    end
    # after the nodes PriorityQueue is empty, if a path from source to terminal was not found
    return distances
  end

  # join the array elements as a word, string for returning the results path
  def to_s(array)
    array.join('')
  end

end

##############
# Unit Tests
##############

class WeightedGraphTest < Test::Unit::TestCase

  def test_weighted_graph_has_methods
    test = WeightedGraph.new

    assert_respond_to(test, :add_weighted_vertex) 
    assert_respond_to(test, :djikstras_shortest_path) 
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

  def test_weighted_graph_djikstra_returns_shortest_path
    test = WeightedGraph.new
    weighted_edges = [{"A" => {"B" => 74, "C" => 9, "D" => 72, "E" => 54, "G" => 12}},
                                   {"B" => {"A" => 74, "C" => 85, "D" => 54, "E" => 45}},
                                   {"C" => {"A" => 9, "D" => 75, "F" => 33, "J" => 900}},
                                   {"D" => {"C" => 3, "F" => 101}},
                                   {"E" => {"B" => 45, "G" => 500}},
                                   {"F" => {"D" => 101}},
                                   {"G" => {"C" => 71, "I" => 40}},
                                   {"H" => {"E" => 2, "F" => 61}},
                                   {"I" => {"F" => 37, "G" => 40, "H" => 49, "J" => 42}},
                                   {"J" => {"B" => 27, "C" => 36, "F" => 99}}]
    weighted_edges.each do |w_edge|
      test.add_weighted_vertex(w_edge.first[0], w_edge.first[1])
    end
    assert_equal("The shortest path from A to J is AGIJ.", test.djikstras_shortest_path("A", "J"))
    assert_equal("The shortest path from J to A is JCA.", test.djikstras_shortest_path("J", "A"))
    assert_equal("The shortest path from B to A is BDCA.", test.djikstras_shortest_path("B", "A"))
    assert_equal(false  , test.djikstras_shortest_path("G", "X"))
    end

end
