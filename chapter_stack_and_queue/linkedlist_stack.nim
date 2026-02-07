# File: linkedlist_stack.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import std/algorithm
import ../modules/list_node

type
  LinkedListStack* = ref object
    peekNode: ListNode
    sizeVal: int

proc newLinkedListStack*(): LinkedListStack =
  ## Constructor
  LinkedListStack(peekNode: nil, sizeVal: 0)

proc size*(self: LinkedListStack): int =
  ## Get stack length
  self.sizeVal

proc isEmpty*(self: LinkedListStack): bool =
  ## Check if stack is empty
  self.sizeVal == 0

proc push*(self: LinkedListStack, val: int) =
  ## Push element
  let node = newListNode(val)
  node.next = self.peekNode
  self.peekNode = node
  self.sizeVal += 1

proc peek*(self: LinkedListStack): int =
  ## Access the top element
  if self.isEmpty():
    raise newException(IndexDefect, "Stack is empty")
  self.peekNode.val

proc pop*(self: LinkedListStack): int =
  ## Pop element
  let num = self.peek()
  self.peekNode = self.peekNode.next
  self.sizeVal -= 1
  return num

proc toList*(self: LinkedListStack): seq[int] =
  ## Convert to seq for printing
  var arr: seq[int] = @[]
  var node = self.peekNode
  while node != nil:
    arr.add(node.val)
    node = node.next
  arr.reverse()
  return arr

## Driver Code
if isMainModule:
  # Initialize stack
  let stack = newLinkedListStack()

  # Push elements
  stack.push(1)
  stack.push(3)
  stack.push(2)
  stack.push(5)
  stack.push(4)
  echo "Stack stack = ", stack.toList()

  # Access the top element
  let peekVal = stack.peek()
  echo "Top element peek = ", peekVal

  # Pop element
  let popVal = stack.pop()
  echo "Popped element popVal = ", popVal
  echo "After popping, stack = ", stack.toList()

  # Get stack length
  let sizeVal = stack.size()
  echo "Stack length size = ", sizeVal

  # Check if empty
  let isEmptyVal = stack.isEmpty()
  echo "Is stack empty = ", isEmptyVal
