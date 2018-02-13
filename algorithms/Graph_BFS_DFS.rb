=begin

referenced materials: https://www.youtube.com/watch?v=AfSk24UTFS8

Depth-First Search(DFS) uses a Stack rather in order to process a search program.  It has several applications, is very fast, linear runtime O(n), and is the simplest graph search algorithm.

Recursive DFS can be used to explore graphs, backtracking as necessary, e.g. like solving a maze.

Iterative DFS has the same uses, only it uses a Stack structure to replace the recursive calls made by recursive DFS.

Inputs: Adjacency List, Parent structure

- Adjacency list as input: describes a graph, its vertices, by listing its connections, the edges -- {a,b},{b,c},{a,c} is an curly braces adjacency list describing an Undirected Cyclic Graph (UCG) A<->B<->C<->A of three nodes, whereas the same connections with parenthesis or normal braces describes a Directed Acyclic Graph (DAG) a triangle A->B->C<-A

- Parent structure, s = source, is our list of "visited" nodes and is ordered by the parent node as key and value as how the algorithm traveled from one node to the next 

The pseudocode for recursive DFS-Visit & DFS:
Notes:
-1- "DFS-Visit" only visits each visitable node once
-2- "DFS" finds all paths

parent = {s: none}
DFS-Visit(adj, s):
  for v in adj[s]:
      if v not in parent:
        parent[v]=s
        DFS-Visit(v,adj,s)

DFS(v, adj):
  for s in v:
    if s not in parent:
      parent[s]=none
      DFS-Visit(v,adj,s)

Analysis: Upper-bounded Big-O of (V + E), (linear time)
  - visit each vertex once in DFS alone, O(V)
  - DFS-Visit once per vertex -> pay |Adj[v]|
  
  => O(Order of sum over all vertices|Adj[v]|) = O(E) "Handshaking lemma"
    
    {\displaystyle \sum _{v}d(v)=2e}

  - Twice of E for undirected graphs, E for directed graphs

Edge classification:
  - tree edge (parent pointers) visit new vertex via edge
  - forward edge: goes from a node -> descendant in the tree/forest
  - backward edge: goes from a node -> ancestor in the tree/forest  
  - cross edge: between two non-ancestor related subtrees/nodes

Computing forward edges and cross edges can be done via time-tracking on a clock

Computing backward edges can be done by tracking the s structure currently being explored as a having a start and finish

If it's neither forward or backward, it's a cross edge

- Undirected graphs can have tree edges, backward edges, and cross edges, but not forward edges

Application #1 - Cycle detection:
  Ex: G has a cycle
  <=>DFS has a back edge
  - If a graph has a back edge, it has a cycle
  Proof:   (tree edges)
  (<=) 0 -> 0 -> 0 -> 0 
       |_______<______|  
    (back edge defines a cycle)

  AKA "Balanced Parenthesis" via the recursion stack, e.g. how (V)k finishes before (V)0, and (V)0 will always finish before (V)-1 

Application #2 - Job scheduling / Topological sort:
  given a directed acyclic graph (DAG)
  order vertices so all edges point from
  lower order to higher order (Earlier to Later)

  DAG={G,H},{A,H},{A,B},{B,C},{D,B},{D,E},{E,F},{C,F},{I}

  DFS can do this, and this is called a Topological sort:
    run DFS, and output the reverse of the finishing times of vertices

Why does this work...?

Correctness: for any edge E{u,v}, e.g. maybe u has two edges to v, 
  v finishes before u finishes

Case 1: u starts before v,
  => visit v before u finishes DFS

Case 2: v starts before u,
  => v finishes before visiting u,
     because {v,u} would be a cycle
     and cycles aren't allowed in a DAG

=end

### Breadth-First-Search (BFS) ###

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
G_UCG = Graph.new(UCG_edges, 'UCG')

# dfs/bfs shows all nodes reachable from their starting vertex
pp G_DAG.dfs('A') === ["A", "B", "C", "F", "H"]
pp G_DAG.dfs('D') === ["D", "E", "F", "B", "C"]
pp G_DAG.dfs('E') === ["E", "F"]

pp G_UCG.bfs('A') === ["A", "Z", "S", "X", "D", "C", "F", "U"]
pp G_UCG.bfs('D') === ["D", "X", "F", "C", "U", "S", "A", "Z"]
pp G_UCG.bfs('U') === ["U", "C", "F", "D", "X", "S", "A", "Z"]
pp G_UCG.bfs('Z') === ["Z", "A", "S", "X", "D", "C", "F", "U"]