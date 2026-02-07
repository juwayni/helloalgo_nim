# File: graph_adjacency_list.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import std/[tables, sequtils]
import ../modules/vertex

type
  GraphAdjList* = ref object
    adjList*: Table[Vertex, seq[Vertex]]

proc size*(self: GraphAdjList): int =
  ## Get number of vertices
  self.adjList.len

proc addVertex*(self: GraphAdjList, vet: Vertex) =
  ## Add vertex
  if self.adjList.hasKey(vet):
    return
  self.adjList[vet] = @[]

proc addEdge*(self: GraphAdjList, vet1: Vertex, vet2: Vertex) =
  ## Add edge
  if not self.adjList.hasKey(vet1) or not self.adjList.hasKey(vet2) or vet1 == vet2:
    raise newException(ValueError, "Invalid vertex or self-loop")
  self.adjList[vet1].add(vet2)
  self.adjList[vet2].add(vet1)

proc newGraphAdjList*(edges: seq[seq[Vertex]]): GraphAdjList =
  ## Constructor
  let g = GraphAdjList(adjList: initTable[Vertex, seq[Vertex]]())
  for edge in edges:
    g.addVertex(edge[0])
    g.addVertex(edge[1])
    g.addEdge(edge[0], edge[1])
  return g

proc removeEdge*(self: GraphAdjList, vet1: Vertex, vet2: Vertex) =
  ## Remove edge
  if not self.adjList.hasKey(vet1) or not self.adjList.hasKey(vet2) or vet1 == vet2:
    raise newException(ValueError, "Invalid vertex or self-loop")
  # Remove vet2 from vet1's list
  self.adjList[vet1].keepItIf(it != vet2)
  # Remove vet1 from vet2's list
  self.adjList[vet2].keepItIf(it != vet1)

proc removeVertex*(self: GraphAdjList, vet: Vertex) =
  ## Remove vertex
  if not self.adjList.hasKey(vet):
    raise newException(ValueError, "Vertex not found")
  # Remove the vertex from the adjacency list
  self.adjList.del(vet)
  # Remove all edges connected to this vertex
  for vertex in self.adjList.keys:
    self.adjList[vertex].keepItIf(it != vet)

proc print*(self: GraphAdjList) =
  ## Print adjacency list
  echo "Adjacency list ="
  for vertex in self.adjList.keys:
    let tmp = self.adjList[vertex].mapIt(it.val)
    echo vertex.val, ": ", tmp, ","

## Driver Code
if isMainModule:
  # Initialize undirected graph
  let v = valsToVets(@[1, 3, 2, 5, 4])
  let edges = @[
    @[v[0], v[1]],
    @[v[0], v[3]],
    @[v[1], v[2]],
    @[v[2], v[3]],
    @[v[2], v[4]],
    @[v[3], v[4]]
  ]
  let graph = newGraphAdjList(edges)
  echo "\nAfter initialization, the graph is"
  graph.print()

  # Add edge
  # Vertex 1 and 2 are v[0] and v[2]
  graph.addEdge(v[0], v[2])
  echo "\nAfter adding edge 1-2, the graph is"
  graph.print()

  # Remove edge
  # Vertex 1 and 3 are v[0] and v[1]
  graph.removeEdge(v[0], v[1])
  echo "\nAfter removing edge 1-3, the graph is"
  graph.print()

  # Add vertex
  let v5 = newVertex(6)
  graph.addVertex(v5)
  echo "\nAfter adding vertex 6, the graph is"
  graph.print()

  # Remove vertex
  # Vertex 3 is v[1]
  graph.removeVertex(v[1])
  echo "\nAfter removing vertex 3, the graph is"
  graph.print()
