# File: tree_node.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import std/options

type
  TreeNode* = ref object
    val*: int
    height*: int
    left*: TreeNode
    right*: TreeNode

proc newTreeNode*(val: int): TreeNode =
  ## Binary tree node class
  TreeNode(val: val, height: 0, left: nil, right: nil)

proc listToTreeDfs(arr: seq[Option[int]], i: int): TreeNode =
  ## Deserialize a list into a binary tree: recursive
  if i < 0 or i >= arr.len or arr[i].isNone:
    return nil
  var root = newTreeNode(arr[i].get())
  root.left = listToTreeDfs(arr, 2 * i + 1)
  root.right = listToTreeDfs(arr, 2 * i + 2)
  return root

proc listToTree*(arr: seq[Option[int]]): TreeNode =
  ## Deserialize a list into a binary tree
  return listToTreeDfs(arr, 0)

proc treeToListDfs(root: TreeNode, i: int, res: var seq[Option[int]]) =
  ## Serialize a binary tree into a list: recursive
  if root == nil:
    return
  if i >= res.len:
    res.setLen(i + 1)
  res[i] = some(root.val)
  treeToListDfs(root.left, 2 * i + 1, res)
  treeToListDfs(root.right, 2 * i + 2, res)

proc treeToList*(root: TreeNode): seq[Option[int]] =
  ## Serialize a binary tree into a list
  var res: seq[Option[int]] = @[]
  treeToListDfs(root, 0, res)
  return res
