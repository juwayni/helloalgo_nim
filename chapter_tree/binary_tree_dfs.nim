# File: binary_tree_dfs.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import std/options
import ../modules/tree_node
import ../modules/print_util

var res: seq[int] = @[]

proc preOrder(root: TreeNode) =
  ## Pre-order traversal
  if root == nil: return
  # Access priority: root -> left child -> right child
  res.add(root.val)
  preOrder(root.left)
  preOrder(root.right)

proc inOrder(root: TreeNode) =
  ## In-order traversal
  if root == nil: return
  # Access priority: left child -> root -> right child
  inOrder(root.left)
  res.add(root.val)
  inOrder(root.right)

proc postOrder(root: TreeNode) =
  ## Post-order traversal
  if root == nil: return
  # Access priority: left child -> right child -> root
  postOrder(root.left)
  postOrder(root.right)
  res.add(root.val)

## Driver Code
if isMainModule:
  # Initialize binary tree
  let arr = @[some(1), some(2), some(3), some(4), some(5), some(6), some(7)]
  let root = listToTree(arr)
  echo "\nInitialized binary tree\n"
  printTree(root)

  # Pre-order traversal
  res = @[]
  preOrder(root)
  echo "\nPre-order traversal sequence = ", res

  # In-order traversal
  res = @[]
  inOrder(root)
  echo "\nIn-order traversal sequence = ", res

  # Post-order traversal
  res = @[]
  postOrder(root)
  echo "\nPost-order traversal sequence = ", res
