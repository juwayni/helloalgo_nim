# File: build_tree.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import std/tables
import ../modules/tree_node
import ../modules/print_util

proc dfs(
    preorder: seq[int],
    inorderMap: Table[int, int],
    i: int,
    l: int,
    r: int
): TreeNode =
  ## Build binary tree: divide and conquer
  # Terminate when subtree range is empty
  if r - l < 0:
    return nil
  # Initialize root node
  var root = newTreeNode(preorder[i])
  # Query m to divide left and right subtrees
  let m = inorderMap[preorder[i]]
  # Sub-problem: build left subtree
  root.left = dfs(preorder, inorderMap, i + 1, l, m - 1)
  # Sub-problem: build right subtree
  root.right = dfs(preorder, inorderMap, i + 1 + m - l, m + 1, r)
  # Return root node
  return root

proc buildTree*(preorder: seq[int], inorder: seq[int]): TreeNode =
  ## Build binary tree
  # Initialize hash map to store inorder element-to-index mapping
  var inorderMap = initTable[int, int]()
  for i, val in inorder:
    inorderMap[val] = i
  let root = dfs(preorder, inorderMap, 0, 0, inorder.len - 1)
  return root

## Driver Code
if isMainModule:
  let preorder = @[3, 9, 2, 1, 7]
  let inorder = @[9, 3, 1, 2, 7]
  echo "Pre-order = ", preorder
  echo "In-order = ", inorder

  let root = buildTree(preorder, inorder)
  echo "Built binary tree:"
  printTree(root)
