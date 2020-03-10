=begin
referenced materials: https://www.youtube.com/watch?v=s-CYnVz-uh4
MIT OpenCourseWare

MIT 6.006 Introduction to Algorithms, Fall 2011
View the complete course: http://ocw.mit.edu/6-006F11
Instructor: Erik Demaine

13. Breadth-First Search (BFS)

Recall: graph G=(V,E)
  V = set of vertices
  E = set of edges
  undirected: e={v,w} unordered pairs --> use curly brackets {}
  directed:   e=(v,w) ordered pairs --> use parenthesis ()

- O(V + E) time-space complexity
- careful to avoid duplicate visitations

Pseudocode

BFS(s, adj)
  level = {s: 0}
  parent = {s: none}
  i = 1
  frontier = [s]  #level = i - 1
  while frontier:
    next = []
    for u in frontier:
      for v in adj[u]:
        if v not in level:
          level[v] = i
          parent[v] = u
          next.append(v)
    frontier = next
    i += 1

=end

require 'pp'

class Vertex

  attr_accessor :value

  def initalize(value)
    @value = value
  end

end

class Graph

  def initialize(edges, graph_type)
    @adj            = {}
    @degree         = 0
    @edges          = edges
    @vertices       = {}
    @total_vertices = 0
    @graph_type     = graph_type
    populate(@edges)
  end

  def bfs(s)
    level = {s => 0}
    i = 1
    frontier = [s]
    while !frontier.empty?
      next_level = []
      frontier.each do |vertex|
        @adj[vertex].each do |next_level_vertex|
          if !level[next_level_vertex]
            level[next_level_vertex] = i
            next_level.unshift(next_level_vertex)
          end
        end
      end
      frontier = next_level
      i += 1
    end
    level.keys
  end

  def dfs(s)
    visited = {s => true}
    stack = [s]

    while !stack.empty?
      next_vertex = stack.pop
      visited[next_vertex] = true
      @adj[next_vertex].each do |vertex|
        if !visited[vertex]
          stack.push(vertex)
        end
      end
    end

    visited.keys
  end
  
  private

  def populate(edges)
    @edges.each do |edge|
      if !@vertices[edge[0]]
        v = Vertex.new()
        v.value = edge[0]
        @vertices[edge[0]] = [v]
        @total_vertices += 1
        @adj[edge[0]] = []
      end
      if !@vertices[edge[1]]
        v = Vertex.new()
        v.value = edge[1]
        @vertices[edge[1]] = [v]
        @total_vertices += 1
        @adj[edge[1]] = []
      end

      case @graph_type
      when 'DAG'
        if @vertices[edge[0]] && @vertices[edge[1]] && edge.size > 1 
          @adj[edge[0]] << edge[1]
          @degree += 1
        end
      when 'UCG'
        if @vertices[edge[0]] && @vertices[edge[1]] && edge.size > 1 
          @adj[edge[0]] << edge[1]
          @adj[edge[1]] << edge[0]
          @degree += 2
        end
      end
      
      if @vertices.include? nil
        @vertices.delete nil
        @total_vertices -= 1
      end
    end
  end

end

DAG_edges =  [['G','H'],
              ['A','H'],
              ['A','B'],
              ['B','C'],
              ['D','B'],
              ['D','E'],
              ['E','F'],
              ['C','F'],
              ['I']]

UCG_edges =  [['A', 'Z'],
              ['A', 'S'],
              ['S', 'X'],
              ['X', 'D'],
              ['X', 'C'],
              ['D', 'F'],
              ['D', 'C'],
              ['C', 'F'],
              ['C', 'U'],
              ['F', 'U']]

# Unit Tests
G_DAG = Graph.new(DAG_edges, 'DAG')
pp G_UCG = Graph.new(UCG_edges, 'UCG')

# dfs/bfs shows all nodes reachable from their starting vertex
pp G_DAG.dfs('A') === ["A", "B", "C", "F", "H"]
pp G_DAG.dfs('D') === ["D", "E", "F", "B", "C"]
pp G_DAG.dfs('E') === ["E", "F"]

pp G_UCG.bfs('A') === ["A", "Z", "S", "X", "D", "C", "F", "U"]
pp G_UCG.bfs('D') === ["D", "X", "F", "C", "U", "S", "A", "Z"]
pp G_UCG.bfs('U') === ["U", "C", "F", "D", "X", "S", "A", "Z"]
pp G_UCG.bfs('Z') === ["Z", "A", "S", "X", "D", "C", "F", "U"]