# File: array_binary_tree.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import std/options
import ../modules/tree_node
import ../modules/print_util

type
  ArrayBinaryTree* = ref object
    tree: seq[Option[int]]
    res: seq[int]

proc newArrayBinaryTree*(arr: seq[Option[int]]): ArrayBinaryTree =
  ## Constructor
  ArrayBinaryTree(tree: arr, res: @[])

proc size*(self: ArrayBinaryTree): int =
  ## List capacity
  self.tree.len

proc val*(self: ArrayBinaryTree, i: int): Option[int] =
  ## Get value of node at index i
  if i < 0 or i >= self.size():
    return none(int)
  self.tree[i]

proc left*(self: ArrayBinaryTree, i: int): int =
  ## Get index of left child of node at index i
  2 * i + 1

proc right*(self: ArrayBinaryTree, i: int): int =
  ## Get index of right child of node at index i
  2 * i + 2

proc parent*(self: ArrayBinaryTree, i: int): int =
  ## Get index of parent of node at index i
  (i - 1) div 2

proc levelOrder*(self: ArrayBinaryTree): seq[int] =
  ## Level-order traversal
  self.res = @[]
  for i in 0 ..< self.size():
    let v = self.val(i)
    if v.isSome:
      self.res.add(v.get())
  return self.res

proc dfs(self: ArrayBinaryTree, i: int, order: string) =
  ## Depth-first traversal
  let v = self.val(i)
  if v.isNone:
    return
  # Pre-order
  if order == "pre":
    self.res.add(v.get())
  self.dfs(self.left(i), order)
  # In-order
  if order == "in":
    self.res.add(v.get())
  self.dfs(self.right(i), order)
  # Post-order
  if order == "post":
    self.res.add(v.get())

proc preOrder*(self: ArrayBinaryTree): seq[int] =
  ## Pre-order traversal
  self.res = @[]
  self.dfs(0, "pre")
  return self.res

proc inOrder*(self: ArrayBinaryTree): seq[int] =
  ## In-order traversal
  self.res = @[]
  self.dfs(0, "in")
  return self.res

proc postOrder*(self: ArrayBinaryTree): seq[int] =
  ## Post-order traversal
  self.res = @[]
  self.dfs(0, "post")
  return self.res

## Driver Code
if isMainModule:
  # Initialize binary tree
  let arr = @[some(1), some(2), some(3), some(4), none(int), some(6), some(7), some(8), some(9), none(int), none(int), some(12), none(int), none(int), some(15)]
  let root = listToTree(arr)
  echo "\nInitialized binary tree\n"
  echo "Array representation of binary tree:"
  echo arr
  echo "Linked list representation of binary tree:"
  printTree(root)

  # ArrayBinaryTree class
  let abt = newArrayBinaryTree(arr)

  # Access nodes
  let i = 1
  let l = abt.left(i)
  let r = abt.right(i)
  let p = abt.parent(i)
  echo "\nCurrent node index = ", i, ", value = ", if abt.val(i).isSome: $abt.val(i).get() else: "None"
  echo "Left child index = ", l, ", value = ", if abt.val(l).isSome: $abt.val(l).get() else: "None"
  echo "Right child index = ", r, ", value = ", if abt.val(r).isSome: $abt.val(r).get() else: "None"
  echo "Parent index = ", p, ", value = ", if abt.val(p).isSome: $abt.val(p).get() else: "None"

  # Traverse tree
  var res = abt.levelOrder()
  echo "\nLevel-order traversal: ", res
  res = abt.preOrder()
  echo "Pre-order traversal: ", res
  res = abt.inOrder()
  echo "In-order traversal: ", res
  res = abt.postOrder()
  echo "Post-order traversal: ", res
