# File: graph_bfs.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import std/[deques, sets, tables]
import ../modules/vertex
import ./graph_adjacency_list

proc graphBfs*(graph: GraphAdjList, startVet: Vertex): seq[Vertex] =
  ## Breadth-first search
  # Sequence to store the traversal result
  var res: seq[Vertex] = @[]
  # Set to keep track of visited vertices
  var visited = initHashSet[Vertex]()
  visited.incl(startVet)
  # Queue for BFS implementation
  var que = initDeque[Vertex]()
  que.addLast(startVet)

  while que.len > 0:
    let vet = que.popFirst() # Dequeue front vertex
    res.add(vet) # Record visited vertex
    # Traverse all adjacent vertices of the current vertex
    if graph.adjList.hasKey(vet):
      for adjVet in graph.adjList[vet]:
        if visited.contains(adjVet):
          continue # Skip visited vertices
        que.addLast(adjVet) # Enqueue unvisited vertices
        visited.incl(adjVet) # Mark as visited

  return res

## Driver Code
if isMainModule:
  # Initialize undirected graph
  let v = valsToVets(@[0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
  let edges = @[
    @[v[0], v[1]],
    @[v[0], v[3]],
    @[v[1], v[2]],
    @[v[1], v[4]],
    @[v[2], v[5]],
    @[v[3], v[4]],
    @[v[3], v[6]],
    @[v[4], v[5]],
    @[v[4], v[7]],
    @[v[5], v[8]],
    @[v[6], v[7]],
    @[v[7], v[8]]
  ]
  let graph = newGraphAdjList(edges)
  echo "\nAfter initialization, the graph is"
  graph.print()

  # Breadth-first search
  let res = graphBfs(graph, v[0])
  echo "\nBreadth-first search (BFS) vertex sequence is"
  echo vetsToVals(res)
