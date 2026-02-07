# File: preorder_traversal_iii_compact.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import std/options
import ../modules/tree_node
import ../modules/print_util

var path: seq[TreeNode] = @[]
var res: seq[seq[TreeNode]] = @[]

proc preOrder(root: TreeNode) =
  ## Pre-order traversal: Example 3
  # Pruning
  if root == nil or root.val == 3:
    return
  # Try
  path.add(root)
  if root.val == 7:
    # Record solution
    res.add(path)
  preOrder(root.left)
  preOrder(root.right)
  # Backtrack
  discard path.pop()

## Driver Code
if isMainModule:
  let root = listToTree(@[some(1), some(7), some(3), some(4), some(5), some(6), some(7)])
  echo "\nInitialized binary tree"
  printTree(root)

  # Pre-order traversal
  path = @[]
  res = @[]
  preOrder(root)

  echo "\nOutput all paths from root to nodes with value 7, excluding nodes with value 3"
  for p in res:
    var vals: seq[int] = @[]
    for node in p:
      vals.add(node.val)
    echo vals
