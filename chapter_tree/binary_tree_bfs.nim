# File: binary_tree_bfs.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import std/[deques, options]
import ../modules/tree_node
import ../modules/print_util

proc levelOrder(root: TreeNode): seq[int] =
  ## Level-order traversal
  if root == nil: return @[]
  # Initialize queue, add root node
  var queue = initDeque[TreeNode]()
  queue.addLast(root)
  # Initialize list to save traversal sequence
  var res: seq[int] = @[]
  while queue.len > 0:
    let node = queue.popFirst() # Dequeue
    res.add(node.val) # Save node value
    if node.left != nil:
      queue.addLast(node.left) # Enqueue left child
    if node.right != nil:
      queue.addLast(node.right) # Enqueue right child
  return res

## Driver Code
if isMainModule:
  # Initialize binary tree
  let arr = @[some(1), some(2), some(3), some(4), some(5), some(6), some(7)]
  let root = listToTree(arr)
  echo "\nInitialized binary tree\n"
  printTree(root)

  # Level-order traversal
  let res = levelOrder(root)
  echo "\nLevel-order traversal sequence = ", res
