# File: space_complexity.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import std/tables
import ../modules/list_node
import ../modules/tree_node
import ../modules/print_util

proc functionSample(): int =
  ## Function sample
  return 0

proc constant*(n: int) =
  ## Constant space O(1)
  let a = 0
  let nums = newSeq[int](10000)
  let node = newListNode(0)
  # Variables in loop occupy O(1) space
  for _ in 0 ..< n:
    let c = 0
  # Functions in loop occupy O(1) space
  for _ in 0 ..< n:
    discard functionSample()

proc linear*(n: int) =
  ## Linear space O(n)
  # List of length n
  let nums = newSeq[int](n)
  # Hash table of size n
  var hmap = initTable[int, string]()
  for i in 0 ..< n:
    hmap[i] = $i

proc linearRecur*(n: int) =
  ## Linear space O(n) (recursive)
  echo "Recursion n = ", n
  if n <= 1:
    return
  linearRecur(n - 1)

proc quadratic*(n: int) =
  ## Quadratic space O(n^2)
  # 2D list
  var numMatrix: seq[seq[int]] = @[]
  for i in 0 ..< n:
    numMatrix.add(newSeq[int](n))

proc quadraticRecur*(n: int): int =
  ## Quadratic space O(n^2) (recursive)
  if n <= 0:
    return 0
  # Sequence of length n, n-1, ..., 1
  let nums = newSeq[int](n)
  return quadraticRecur(n - 1)

proc buildTreeSample*(n: int): TreeNode =
  ## Exponential space O(2^n) (full binary tree)
  if n == 0:
    return nil
  var root = newTreeNode(0)
  root.left = buildTreeSample(n - 1)
  root.right = buildTreeSample(n - 1)
  return root

## Driver Code
if isMainModule:
  let n = 5
  # Constant space
  constant(n)
  # Linear space
  linear(n)
  linearRecur(n)
  # Quadratic space
  quadratic(n)
  discard quadraticRecur(n)
  # Exponential space
  let root = buildTreeSample(n)
  printTree(root)
