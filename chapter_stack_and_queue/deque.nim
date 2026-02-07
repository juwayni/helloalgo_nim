# File: deque.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import std/deques
import std/sequtils

## Driver Code
if isMainModule:
  # Initialize deque
  var deq = initDeque[int]()

  # Enqueue elements
  deq.addLast(2)  # Add to rear
  deq.addLast(5)
  deq.addLast(4)
  deq.addFirst(3) # Add to front
  deq.addFirst(1)
  echo "Deque deque = ", toSeq(deq.items)

  # Access elements
  let front = deq[0] # Front element
  echo "Front element front = ", front
  let rear = deq[deq.len - 1] # Rear element
  echo "Rear element rear = ", rear

  # Dequeue elements
  let popFront = deq.popFirst() # Dequeue from front
  echo "Popped front element popFront = ", popFront
  echo "After popping front, deque = ", toSeq(deq.items)
  let popRear = deq.popLast() # Dequeue from rear
  echo "Popped rear element popRear = ", popRear
  echo "After popping rear, deque = ", toSeq(deq.items)

  # Get length
  let size = deq.len
  echo "Deque length size = ", size

  # Check if empty
  let isEmpty = deq.len == 0
  echo "Is deque empty = ", isEmpty
