# File: list_node.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

type
  ListNode* = ref object
    val*: int
    next*: ListNode

proc newListNode*(val: int): ListNode =
  ## Linked list node class
  ListNode(val: val, next: nil)

proc listToLinkedList*(arr: seq[int]): ListNode =
  ## Deserialize a list into a linked list
  if arr.len == 0: return nil
  var
    dum = newListNode(0)
    head = dum
  for a in arr:
    head.next = newListNode(a)
    head = head.next
  return dum.next

proc linkedListToList*(head: ListNode): seq[int] =
  ## Serialize a linked list into a list
  var
    arr: seq[int] = @[]
    curr = head
  while curr != nil:
    arr.add(curr.val)
    curr = curr.next
  return arr
