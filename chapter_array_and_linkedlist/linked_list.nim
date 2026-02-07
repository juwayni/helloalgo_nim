# File: linked_list.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import ../modules/list_node
import ../modules/print_util

proc insert(n0: ListNode, p: ListNode) =
  ## Insert node P after node n0 in the linked list
  let n1 = n0.next
  p.next = n1
  n0.next = p

proc remove(n0: ListNode) =
  ## Delete the first node after node n0 in the linked list
  if n0.next == nil:
    return
  # n0 -> P -> n1
  let p = n0.next
  let n1 = p.next
  n0.next = n1

proc access(head: ListNode, index: int): ListNode =
  ## Access the node at index in the linked list
  var curr = head
  for _ in 0 ..< index:
    if curr == nil:
      return nil
    curr = curr.next
  return curr

proc find(head: ListNode, target: int): int =
  ## Search for the first node with value target in the linked list
  var
    curr = head
    index = 0
  while curr != nil:
    if curr.val == target:
      return index
    curr = curr.next
    index += 1
  return -1

## Driver Code
if isMainModule:
  # Initialize linked list
  # Initialize nodes
  let n0 = newListNode(1)
  let n1 = newListNode(3)
  let n2 = newListNode(2)
  let n3 = newListNode(5)
  let n4 = newListNode(4)
  # Build references between nodes
  n0.next = n1
  n1.next = n2
  n2.next = n3
  n3.next = n4
  echo "Initialized linked list:"
  printLinkedList(n0)

  # Insert node
  let p = newListNode(0)
  insert(n0, p)
  echo "Linked list after insertion:"
  printLinkedList(n0)

  # Delete node
  remove(n0)
  echo "Linked list after deletion:"
  printLinkedList(n0)

  # Access node
  let node = access(n0, 3)
  if node != nil:
    echo "Value of node at index 3 in linked list = ", node.val

  # Search node
  let index = find(n0, 2)
  echo "Index of node with value 2 in linked list = ", index
