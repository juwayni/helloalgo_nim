# File: linkedlist_queue.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import ../modules/list_node

type
  LinkedListQueue* = ref object
    frontNode: ListNode # Head node
    rearNode: ListNode # Tail node
    sizeVal: int

proc newLinkedListQueue*(): LinkedListQueue =
  ## Constructor
  LinkedListQueue(frontNode: nil, rearNode: nil, sizeVal: 0)

proc size*(self: LinkedListQueue): int =
  ## Get queue length
  self.sizeVal

proc isEmpty*(self: LinkedListQueue): bool =
  ## Check if queue is empty
  self.sizeVal == 0

proc push*(self: LinkedListQueue, num: int) =
  ## Enqueue
  let node = newListNode(num)
  if self.frontNode == nil:
    self.frontNode = node
    self.rearNode = node
  else:
    self.rearNode.next = node
    self.rearNode = node
  self.sizeVal += 1

proc peek*(self: LinkedListQueue): int =
  ## Access the front element
  if self.isEmpty():
    raise newException(IndexDefect, "Queue is empty")
  self.frontNode.val

proc pop*(self: LinkedListQueue): int =
  ## Dequeue
  let num = self.peek()
  self.frontNode = self.frontNode.next
  self.sizeVal -= 1
  return num

proc toList*(self: LinkedListQueue): seq[int] =
  ## Convert to seq for printing
  var res: seq[int] = @[]
  var temp = self.frontNode
  while temp != nil:
    res.add(temp.val)
    temp = temp.next
  return res

## Driver Code
if isMainModule:
  # Initialize queue
  let queue = newLinkedListQueue()

  # Enqueue elements
  queue.push(1)
  queue.push(3)
  queue.push(2)
  queue.push(5)
  queue.push(4)
  echo "Queue queue = ", queue.toList()

  # Access the front element
  let peekVal = queue.peek()
  echo "Front element peek = ", peekVal

  # Dequeue element
  let popVal = queue.pop()
  echo "Dequeued element pop = ", popVal
  echo "After dequeueing, queue = ", queue.toList()

  # Get queue length
  let sizeVal = queue.size()
  echo "Queue length size = ", sizeVal

  # Check if empty
  let isEmptyVal = queue.isEmpty()
  echo "Is queue empty = ", isEmptyVal
