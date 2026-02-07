# File: avl_tree.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import ../modules/tree_node
import ../modules/print_util

type
  AVLTree* = ref object
    root: TreeNode

proc newAVLTree*(): AVLTree =
  ## Constructor
  AVLTree(root: nil)

proc getRoot*(self: AVLTree): TreeNode =
  ## Get root node
  self.root

proc height*(self: AVLTree, node: TreeNode): int =
  ## Get node height
  # Height of empty node is -1, leaf node is 0
  if node != nil:
    return node.height
  return -1

proc updateHeight*(self: AVLTree, node: TreeNode) =
  ## Update node height
  # Height equals to max height of child subtrees + 1
  node.height = max(self.height(node.left), self.height(node.right)) + 1

proc balanceFactor*(self: AVLTree, node: TreeNode): int =
  ## Get balance factor
  # Balance factor of empty node is 0
  if node == nil:
    return 0
  # Balance factor = left subtree height - right subtree height
  return self.height(node.left) - self.height(node.right)

proc rightRotate*(self: AVLTree, node: TreeNode): TreeNode =
  ## Right rotation
  let child = node.left
  let grandChild = child.right
  # Rotate node to right with child as pivot
  child.right = node
  node.left = grandChild
  # Update node heights
  self.updateHeight(node)
  self.updateHeight(child)
  # Return the root of rotated subtree
  return child

proc leftRotate*(self: AVLTree, node: TreeNode): TreeNode =
  ## Left rotation
  let child = node.right
  let grandChild = child.left
  # Rotate node to left with child as pivot
  child.left = node
  node.right = grandChild
  # Update node heights
  self.updateHeight(node)
  self.updateHeight(child)
  # Return the root of rotated subtree
  return child

proc rotate*(self: AVLTree, node: TreeNode): TreeNode =
  ## Perform rotation to rebalance subtree
  let bf = self.balanceFactor(node)
  # Left-skewed
  if bf > 1:
    if self.balanceFactor(node.left) >= 0:
      # Right rotation
      return self.rightRotate(node)
    else:
      # Left-Right rotation
      node.left = self.leftRotate(node.left)
      return self.rightRotate(node)
  # Right-skewed
  elif bf < -1:
    if self.balanceFactor(node.right) <= 0:
      # Left rotation
      return self.leftRotate(node)
    else:
      # Right-Left rotation
      node.right = self.rightRotate(node.right)
      return self.leftRotate(node)
  # Balanced, no rotation needed
  return node

proc insertHelper(self: AVLTree, node: TreeNode, val: int): TreeNode =
  ## Recursive insertion (helper)
  if node == nil:
    return newTreeNode(val)
  # 1. Find insertion position and insert
  if val < node.val:
    node.left = self.insertHelper(node.left, val)
  elif val > node.val:
    node.right = self.insertHelper(node.right, val)
  else:
    # Duplicate node not inserted
    return node
  # Update node height
  self.updateHeight(node)
  # 2. Rebalance subtree
  return self.rotate(node)

proc insert*(self: AVLTree, val: int) =
  ## Insert node
  self.root = self.insertHelper(self.root, val)

proc removeHelper(self: AVLTree, node: TreeNode, val: int): TreeNode =
  ## Recursive removal (helper)
  if node == nil:
    return nil
  # 1. Find and remove node
  var curr = node
  if val < curr.val:
    curr.left = self.removeHelper(curr.left, val)
  elif val > curr.val:
    curr.right = self.removeHelper(curr.right, val)
  else:
    if curr.left == nil or curr.right == nil:
      let child = if curr.left != nil: curr.left else: curr.right
      # 0 child
      if child == nil:
        return nil
      # 1 child
      else:
        curr = child
    else:
      # 2 children: replace with successor
      var temp = curr.right
      while temp.left != nil:
        temp = temp.left
      curr.right = self.removeHelper(curr.right, temp.val)
      curr.val = temp.val

  # Update node height
  self.updateHeight(curr)
  # 2. Rebalance subtree
  return self.rotate(curr)

proc remove*(self: AVLTree, val: int) =
  ## Remove node
  self.root = self.removeHelper(self.root, val)

proc search*(self: AVLTree, val: int): TreeNode =
  ## Search for node
  var cur = self.root
  while cur != nil:
    if cur.val < val:
      cur = cur.right
    elif cur.val > val:
      cur = cur.left
    else:
      break
  return cur

## Driver Code
if isMainModule:
  proc testInsert(tree: AVLTree, val: int) =
    tree.insert(val)
    echo "\nAfter inserting node ", val, ", AVL tree is"
    printTree(tree.getRoot())

  proc testRemove(tree: AVLTree, val: int) =
    tree.remove(val)
    echo "\nAfter removing node ", val, ", AVL tree is"
    printTree(tree.getRoot())

  let avlTree = newAVLTree()

  for val in [1, 2, 3, 4, 5, 8, 7, 9, 10, 6]:
    testInsert(avlTree, val)

  testInsert(avlTree, 7)

  testRemove(avlTree, 8) # Remove node with degree 0
  testRemove(avlTree, 5) # Remove node with degree 1
  testRemove(avlTree, 4) # Remove node with degree 2

  let resNode = avlTree.search(7)
  echo "\nFound node: ", if resNode != nil: $resNode.val else: "nil"
