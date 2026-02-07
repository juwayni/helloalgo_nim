# File: print_util.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import std/[strutils, sequtils, options, tables]
import ./list_node
import ./tree_node

proc printMatrix*(mat: seq[seq[int]]) =
  ## Print matrix
  var s: seq[string] = @[]
  for arr in mat:
    s.add("  " & $arr)
  echo "[\n" & s.join(",\n") & "\n]"

proc printLinkedList*(head: ListNode) =
  ## Print linked list
  let arr = linkedListToList(head)
  echo arr.mapIt($it).join(" -> ")

type
  Trunk = ref object
    prev: Trunk
    str: string

proc newTrunk(prev: Trunk, str: string): Trunk =
  Trunk(prev: prev, str: str)

proc showTrunks(p: Trunk) =
  if p == nil:
    return
  showTrunks(p.prev)
  stdout.write(p.str)

proc printTree*(root: TreeNode, prev: Trunk = nil, isRight: bool = false) =
  ## Print binary tree
  ## This tree printer is borrowed from TECHIE DELIGHT
  ## https://www.techiedelight.com/c-program-print-binary-tree/
  if root == nil:
    return

  var prevStr = "    "
  var trunk = newTrunk(prev, prevStr)
  printTree(root.right, trunk, true)

  if prev == nil:
    trunk.str = "———"
  elif isRight:
    trunk.str = "/———"
    prevStr = "   |"
  else:
    trunk.str = "\\———"
    prev.str = prevStr

  showTrunks(trunk)
  echo " " & $root.val
  if prev != nil:
    prev.str = prevStr
  trunk.str = "   |"
  printTree(root.left, trunk, false)

proc printDict*[K, V](hmap: Table[K, V]) =
  ## Print dictionary
  for key, value in hmap.pairs:
    echo $key & " -> " & $value

proc printHeap*(heap: seq[int]) =
  ## Print heap
  echo "Heap array representation: ", heap
  echo "Heap tree representation:"
  var optHeap: seq[Option[int]] = @[]
  for x in heap: optHeap.add(some(x))
  let root = listToTree(optHeap)
  printTree(root)
