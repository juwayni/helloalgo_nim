# File: graph_adjacency_matrix.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import ../modules/print_util

type
  GraphAdjMat* = ref object
    vertices: seq[int]
    adjMat: seq[seq[int]]

proc size*(self: GraphAdjMat): int =
  ## Get number of vertices
  self.vertices.len

proc addVertex*(self: GraphAdjMat, val: int) =
  ## Add vertex
  let n = self.size()
  # Add new vertex value to vertices list
  self.vertices.add(val)
  # Add a new row in adjacency matrix
  var newRow = newSeq[int](n)
  self.adjMat.add(newRow)
  # Add a new column in adjacency matrix
  for row in self.adjMat.mitems:
    row.add(0)

proc addEdge*(self: GraphAdjMat, i: int, j: int) =
  ## Add edge
  # i, j correspond to indices in vertices list
  if i < 0 or j < 0 or i >= self.size() or j >= self.size() or i == j:
    raise newException(IndexDefect, "Index out of bounds")
  # In undirected graph, adjacency matrix is symmetric
  self.adjMat[i][j] = 1
  self.adjMat[j][i] = 1

proc newGraphAdjMat*(vertices: seq[int], edges: seq[seq[int]]): GraphAdjMat =
  ## Constructor
  let g = GraphAdjMat(vertices: @[], adjMat: @[])
  for val in vertices:
    g.addVertex(val)
  for e in edges:
    g.addEdge(e[0], e[1])
  return g

proc removeVertex*(self: GraphAdjMat, index: int) =
  ## Remove vertex
  if index >= self.size():
    raise newException(IndexDefect, "Index out of bounds")
  # Remove vertex from vertices list
  self.vertices.delete(index)
  # Remove the row at index in adjacency matrix
  self.adjMat.delete(index)
  # Remove the column at index in adjacency matrix
  for row in self.adjMat.mitems:
    row.delete(index)

proc removeEdge*(self: GraphAdjMat, i: int, j: int) =
  ## Remove edge
  if i < 0 or j < 0 or i >= self.size() or j >= self.size() or i == j:
    raise newException(IndexDefect, "Index out of bounds")
  self.adjMat[i][j] = 0
  self.adjMat[j][i] = 0

proc print*(self: GraphAdjMat) =
  ## Print adjacency matrix
  echo "Vertices list = ", self.vertices
  echo "Adjacency matrix ="
  printMatrix(self.adjMat)

## Driver Code
if isMainModule:
  # Initialize undirected graph
  let vertices = @[1, 3, 2, 5, 4]
  let edges = @[@[0, 1], @[0, 3], @[1, 2], @[2, 3], @[2, 4], @[3, 4]]
  let graph = newGraphAdjMat(vertices, edges)
  echo "\nAfter initialization, the graph is"
  graph.print()

  # Add edge
  # Index of vertices 1 and 2 are 0 and 2
  graph.addEdge(0, 2)
  echo "\nAfter adding edge 1-2, the graph is"
  graph.print()

  # Remove edge
  # Index of vertices 1 and 3 are 0 and 1
  graph.removeEdge(0, 1)
  echo "\nAfter removing edge 1-3, the graph is"
  graph.print()

  # Add vertex
  graph.addVertex(6)
  echo "\nAfter adding vertex 6, the graph is"
  graph.print()

  # Remove vertex
  # Index of vertex 3 is 1
  graph.removeVertex(1)
  echo "\nAfter removing vertex 3, the graph is"
  graph.print()
