require_relative('../WeightedGraph')

def djikstras_shortest_path(graph, source, terminal)
  distances = {}
  previous = {}
  nodes = PriorityQueue.new
  results = ""

  # check for both nodes existing in @vertices
  return false if !graph.get_vertex(source) || !graph.get_vertex(terminal)
  # initialize the source node distance as 0 and, ...
  graph.vertices.each do |vertex, weighted_edges|
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
      # Print each result path element into a results string for displaying shortest path from source to terminal
      return "The shortest path from #{source} to #{terminal} is #{path.join('').reverse}."
    end

    # break if the rest of the node distances are infinite or nil after storing and deleting the next smallest step
    if (distances[smallest] == Float::INFINITY) or (smallest == nil)
      break
    end

    # grab each neighbor of smallest, and ...
    graph.vertices[smallest].each do | neighbor, value |
        # ... loop over the neighbors edges by summing that alternate distance
        # of the vertex values in smallest + each neighbor, and ...
        alt = distances[smallest] + graph.vertices[smallest][neighbor]
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

############
# Unit Tests
############

require 'test/unit'

class WeightedGraphTest < Test::Unit::TestCase

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
    assert_equal("The shortest path from A to E is AE.", djikstras_shortest_path(test, "A", "E"))
    assert_equal("The shortest path from A to J is AGIJ.", djikstras_shortest_path(test, "A", "J"))
    assert_equal("The shortest path from A to J is AGIJ.", djikstras_shortest_path(test, "A", "J"))
    assert_equal("The shortest path from J to A is JCA.", djikstras_shortest_path(test, "J", "A"))
    assert_equal("The shortest path from B to A is BDCA.", djikstras_shortest_path(test, "B", "A"))
    assert_equal(false, djikstras_shortest_path(test, "G", "X"))
  end

end