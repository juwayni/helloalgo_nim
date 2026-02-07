# File: binary_tree.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import ../modules/tree_node
import ../modules/print_util

## Driver Code
if isMainModule:
  # Initialize binary tree
  # Initialize nodes
  let n1 = newTreeNode(1)
  let n2 = newTreeNode(2)
  let n3 = newTreeNode(3)
  let n4 = newTreeNode(4)
  let n5 = newTreeNode(5)
  # Build references between nodes
  n1.left = n2
  n1.right = n3
  n2.left = n4
  n2.right = n5
  echo "\nInitialized binary tree\n"
  printTree(n1)

  # Insert and delete nodes
  let p = newTreeNode(0)
  # Insert node P between n1 and n2
  n1.left = p
  p.left = n2
  echo "\nAfter inserting node P\n"
  printTree(n1)
  # Delete node P
  n1.left = n2
  echo "\nAfter deleting node P\n"
  printTree(n1)
