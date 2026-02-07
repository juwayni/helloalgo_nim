# File: preorder_traversal_i_compact.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import std/options
import ../modules/tree_node
import ../modules/print_util

var res: seq[TreeNode] = @[]

proc preOrder(root: TreeNode) =
  ## Pre-order traversal: Example 1
  if root == nil:
    return
  if root.val == 7:
    # Record solution
    res.add(root)
  preOrder(root.left)
  preOrder(root.right)

## Driver Code
if isMainModule:
  let root = listToTree(@[some(1), some(7), some(3), some(4), some(5), some(6), some(7)])
  echo "\nInitialized binary tree"
  printTree(root)

  # Pre-order traversal
  res = @[]
  preOrder(root)

  echo "\nOutput all nodes with value 7"
  var vals: seq[int] = @[]
  for node in res:
    vals.add(node.val)
  echo vals
