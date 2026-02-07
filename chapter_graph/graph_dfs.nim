# File: graph_dfs.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import std/[sets, tables]
import ../modules/vertex
import ./graph_adjacency_list

proc dfs(graph: GraphAdjList, visited: var HashSet[Vertex], res: var seq[Vertex], vet: Vertex) =
  ## Depth-first search helper function
  res.add(vet) # Record visited vertex
  visited.incl(vet) # Mark as visited
  # Traverse all adjacent vertices
  if graph.adjList.hasKey(vet):
    for adjVet in graph.adjList[vet]:
      if visited.contains(adjVet):
        continue # Skip visited vertices
      # Recursively visit adjacent vertex
      dfs(graph, visited, res, adjVet)

proc graphDfs*(graph: GraphAdjList, startVet: Vertex): seq[Vertex] =
  ## Depth-first search
  var res: seq[Vertex] = @[]
  var visited = initHashSet[Vertex]()
  dfs(graph, visited, res, startVet)
  return res

## Driver Code
if isMainModule:
  # Initialize undirected graph
  let v = valsToVets(@[0, 1, 2, 3, 4, 5, 6])
  let edges = @[
    @[v[0], v[1]],
    @[v[0], v[3]],
    @[v[1], v[2]],
    @[v[2], v[5]],
    @[v[4], v[5]],
    @[v[5], v[6]]
  ]
  let graph = newGraphAdjList(edges)
  echo "\nAfter initialization, the graph is"
  graph.print()

  # Depth-first search
  let res = graphDfs(graph, v[0])
  echo "\nDepth-first search (DFS) vertex sequence is"
  echo vetsToVals(res)
