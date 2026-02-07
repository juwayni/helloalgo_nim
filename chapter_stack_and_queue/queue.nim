# File: queue.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import std/deques
import std/sequtils

## Driver Code
if isMainModule:
  # Initialize queue
  # In Nim, we can use the Deque from std/deques
  var que = initDeque[int]()

  # Enqueue elements
  que.addLast(1)
  que.addLast(3)
  que.addLast(2)
  que.addLast(5)
  que.addLast(4)
  # Convert Deque to seq for printing to match Python's output style
  echo "Queue que = ", toSeq(que.items)

  # Access the front element
  let front = que[0]
  echo "Front element front = ", front

  # Dequeue element
  let popVal = que.popFirst()
  echo "Dequeued element popVal = ", popVal
  echo "After dequeueing, que = ", toSeq(que.items)

  # Get queue length
  let size = que.len
  echo "Queue length size = ", size

  # Check if empty
  let isEmpty = que.len == 0
  echo "Is queue empty = ", isEmpty
