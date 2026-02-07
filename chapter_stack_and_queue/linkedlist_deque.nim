# File: linkedlist_deque.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

type
  ListNode* = ref object
    val*: int
    next*: ListNode
    prev*: ListNode

proc newListNode*(val: int): ListNode =
  ## Doubly linked list node
  ListNode(val: val, next: nil, prev: nil)

type
  LinkedListDeque* = ref object
    frontNode: ListNode # Head node
    rearNode: ListNode # Tail node
    sizeVal: int

proc newLinkedListDeque*(): LinkedListDeque =
  ## Constructor
  LinkedListDeque(frontNode: nil, rearNode: nil, sizeVal: 0)

proc size*(self: LinkedListDeque): int =
  ## Get deque length
  self.sizeVal

proc isEmpty*(self: LinkedListDeque): bool =
  ## Check if deque is empty
  self.sizeVal == 0

proc push*(self: LinkedListDeque, num: int, isFront: bool) =
  ## Enqueue operation
  let node = newListNode(num)
  if self.isEmpty():
    self.frontNode = node
    self.rearNode = node
  elif isFront:
    self.frontNode.prev = node
    node.next = self.frontNode
    self.frontNode = node
  else:
    self.rearNode.next = node
    node.prev = self.rearNode
    self.rearNode = node
  self.sizeVal += 1

proc pushFirst*(self: LinkedListDeque, num: int) =
  ## Enqueue at front
  self.push(num, true)

proc pushLast*(self: LinkedListDeque, num: int) =
  ## Enqueue at rear
  self.push(num, false)

proc pop*(self: LinkedListDeque, isFront: bool): int =
  ## Dequeue operation
  if self.isEmpty():
    raise newException(IndexDefect, "Deque is empty")
  var val: int
  if isFront:
    val = self.frontNode.val
    let fnext = self.frontNode.next
    if fnext != nil:
      fnext.prev = nil
      self.frontNode.next = nil
    self.frontNode = fnext
  else:
    val = self.rearNode.val
    let rprev = self.rearNode.prev
    if rprev != nil:
      rprev.next = nil
      self.rearNode.prev = nil
    self.rearNode = rprev
  self.sizeVal -= 1
  return val

proc popFirst*(self: LinkedListDeque): int =
  ## Dequeue from front
  self.pop(true)

proc popLast*(self: LinkedListDeque): int =
  ## Dequeue from rear
  self.pop(false)

proc peekFirst*(self: LinkedListDeque): int =
  ## Access the front element
  if self.isEmpty():
    raise newException(IndexDefect, "Deque is empty")
  self.frontNode.val

proc peekLast*(self: LinkedListDeque): int =
  ## Access the rear element
  if self.isEmpty():
    raise newException(IndexDefect, "Deque is empty")
  self.rearNode.val

proc toArray*(self: LinkedListDeque): seq[int] =
  ## Return seq for printing
  var res: seq[int] = @[]
  var node = self.frontNode
  while node != nil:
    res.add(node.val)
    node = node.next
  return res

## Driver Code
if isMainModule:
  # Initialize deque
  let deque = newLinkedListDeque()
  deque.pushLast(3)
  deque.pushLast(2)
  deque.pushLast(5)
  echo "Deque deque = ", deque.toArray()

  # Access elements
  let peekFirstVal = deque.peekFirst()
  echo "Front element peekFirst = ", peekFirstVal
  let peekLastVal = deque.peekLast()
  echo "Rear element peekLast = ", peekLastVal

  # Enqueue elements
  deque.pushLast(4)
  echo "After pushing 4 to last, deque = ", deque.toArray()
  deque.pushFirst(1)
  echo "After pushing 1 to first, deque = ", deque.toArray()

  # Dequeue elements
  let popLastVal = deque.popLast()
  echo "Popped last element = ", popLastVal, ", after popping last, deque = ", deque.toArray()
  let popFirstVal = deque.popFirst()
  echo "Popped first element = ", popFirstVal, ", after popping first, deque = ", deque.toArray()

  # Get length
  let sizeVal = deque.size()
  echo "Deque length size = ", sizeVal

  # Check if empty
  let isEmptyVal = deque.isEmpty()
  echo "Is deque empty = ", isEmptyVal
