require_relative('../Graph')

################
# GraphDFS class
################

class GraphDFS < Graph

  def initialize
    super
    @parent = []
    @edge_to = {}
  end

# REFACTOR - Do without Graph superclass if able
# REFACTOR - Renaming methods and refactoring for closest to MIT lecture pseudocode args as able:
# => TODO: dfs(search_key) -> dfs_visit(adj, s)
# => TODO: find_path(source, terminal) -> dfs(v, adj)
# REFACTOR - Remove comments, consolidate them into the blog post I'm planning from today's MIT Online DFS lecture notes
# REFACTOR - Explain that shortest path and topological sort share methodologies, even though the current implementation is iterative


 # Depth First Search (DFS)
  def dfs(search_key)
    # verify the search_key exists
    return false unless get_vertex(search_key)
    if get_vertex(search_key)
      # push the search key into the @parent array
      @parent << search_key
      # find the neighbors of search_key and loop over them
      find_neighbors(search_key).each do |neighbor|
        # neglect vertices already parent
        next if @parent.include?(neighbor)
        # recursively run dfs() on this neighbor
        dfs(neighbor)
        # add the step to the @edge_to hash for pathfinding algorithms
        @edge_to[neighbor] = search_key
      end
    end
    return true
  end

  # Shortest path using DFS
  # Find the shortest path between two vertices
  def find_path(source, terminal)
    # run dfs() to populate the @parent array
    dfs(source)
    # check that terminal is connected to source
    return false unless @parent.include?(terminal)
    path = []
    # set current as the target terminal vertex
    current = terminal

    # Loop backwards from terminal to find the source vertex 
    while(current != source) do
      # unshift each step into the path array
      path.unshift(current)
      # set current to its previous connection from dfs()
      current = @edge_to[current]
    end

    # unshift source vertex, return shortest path to terminal
    path.unshift(source)
  end

end


############
# Unit Tests
############


class GraphDFSTest < Test::Unit::TestCase
  
  def test_graph_dfs_returns_true_when_target_is_found
    test = GraphDFS.new
    test.populate_directed([[0,1], [0,2], [0,3], [1,4], [1,6], [1,8], [2,3], [2,7], [2,8], [3,1], [3,8], [4,6], [5,7], [5,8], [6,4], [6,9], [7,4], [8,1], [9,4]])

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
    test.populate_directed([[0,1], [0,2], [0,3], [1,4], [1,6], [1,8], [2,3], [2,7], [2,8], [3,1], [3,8], [4,6], [5,7], [5,8], [6,4], [6,9], [7,4], [8,1], [9,4]])
    
    assert_equal(false, test.dfs(10))
    assert_equal(false, test.dfs(99))
  end

  def test_graph_dfs_find_path_returns_path_when_path_exists
    test = GraphDFS.new
    test.populate_directed([[0,1], [0,2], [0,3], [1,4], [1,6], [1,8], [2,3], [2,7], [2,8], [3,1], [3,8], [4,6], [5,7], [5,8], [6,4], [6,9], [7,4], [8,1], [9,4]])
    
    assert_equal([0, 1, 4, 6, 9], test.find_path(0,9))
    assert_equal([2, 7], test.find_path(2,7))
  end

  def test_graph_dfs_find_path_returns_false_when_path_does_not_exists
    test = GraphDFS.new
    test.populate_directed([[0,1], [0,2], [0,3], [1,4], [1,6], [1,8], [2,3], [2,7], [2,8], [3,1], [3,8], [4,6], [5,7], [5,8], [6,4], [6,9], [7,4], [8,1], [9,4]])
    
    assert_equal(false, test.find_path(4,5))
    assert_equal(false, test.find_path(9,8))
    assert_equal(false, test.find_path(0,5))
  end

end
