# File: binary_search_tree.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import ../modules/tree_node
import ../modules/print_util

type
  BinarySearchTree* = ref object
    root: TreeNode

proc newBinarySearchTree*(): BinarySearchTree =
  ## Constructor
  BinarySearchTree(root: nil)

proc getRoot*(self: BinarySearchTree): TreeNode =
  ## Get root node
  self.root

proc search*(self: BinarySearchTree, num: int): TreeNode =
  ## Search for node
  var cur = self.root
  while cur != nil:
    if cur.val < num:
      cur = cur.right
    elif cur.val > num:
      cur = cur.left
    else:
      break
  return cur

proc insert*(self: BinarySearchTree, num: int) =
  ## Insert node
  if self.root == nil:
    self.root = newTreeNode(num)
    return
  var
    cur = self.root
    pre: TreeNode = nil
  while cur != nil:
    if cur.val == num:
      return
    pre = cur
    if cur.val < num:
      cur = cur.right
    else:
      cur = cur.left

  let node = newTreeNode(num)
  if pre.val < num:
    pre.right = node
  else:
    pre.left = node

proc remove*(self: BinarySearchTree, num: int) =
  ## Remove node
  if self.root == nil:
    return
  var
    cur = self.root
    pre: TreeNode = nil
  while cur != nil:
    if cur.val == num:
      break
    pre = cur
    if cur.val < num:
      cur = cur.right
    else:
      cur = cur.left

  if cur == nil:
    return

  # Node has 0 or 1 child
  if cur.left == nil or cur.right == nil:
    let child = if cur.left != nil: cur.left else: cur.right
    if cur != self.root:
      if pre.left == cur:
        pre.left = child
      else:
        pre.right = child
    else:
      self.root = child
  # Node has 2 children
  else:
    var tmp = cur.right
    while tmp.left != nil:
      tmp = tmp.left
    let tmpVal = tmp.val
    self.remove(tmpVal)
    cur.val = tmpVal

## Driver Code
if isMainModule:
  let bst = newBinarySearchTree()
  let nums = @[8, 4, 12, 2, 6, 10, 14, 1, 3, 5, 7, 9, 11, 13, 15]
  for num in nums:
    bst.insert(num)
  echo "\nInitialized binary search tree\n"
  printTree(bst.getRoot())

  let node = bst.search(7)
  echo "\nFound node: ", if node != nil: $node.val else: "nil"

  bst.insert(16)
  echo "\nAfter inserting node 16\n"
  printTree(bst.getRoot())

  bst.remove(1)
  echo "\nAfter removing node 1\n"
  printTree(bst.getRoot())

  bst.remove(2)
  echo "\nAfter removing node 2\n"
  printTree(bst.getRoot())

  bst.remove(4)
  echo "\nAfter removing node 4\n"
  printTree(bst.getRoot())
