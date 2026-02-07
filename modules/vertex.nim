# File: vertex.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import std/hashes

type
  Vertex* = ref object
    val*: int

proc newVertex*(val: int): Vertex =
  ## Vertex class
  Vertex(val: val)

proc valsToVets*(vals: seq[int]): seq[Vertex] =
  ## Input value list vals, return vertex list vets
  var vets: seq[Vertex] = @[]
  for val in vals:
    vets.add(newVertex(val))
  return vets

proc vetsToVals*(vets: seq[Vertex]): seq[int] =
  ## Input vertex list vets, return value list vals
  var vals: seq[int] = @[]
  for vet in vets:
    vals.add(vet.val)
  return vals

proc hash*(v: Vertex): Hash =
  ## Hash function for Vertex
  hash(cast[int](v))
