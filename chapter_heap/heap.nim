# File: heap.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import std/heapqueue
import std/sequtils
import ../modules/print_util

proc toSeq[T](h: HeapQueue[T]): seq[T] =
  var res: seq[T] = @[]
  for x in h:
    res.add(x)
  return res

proc testPush(heap: var HeapQueue[int], val: int, flag: int = 1) =
  heap.push(flag * val) # Element enqueue
  echo "\nAfter element ", val, " enqueued"
  printHeap(heap.toSeq().mapIt(flag * it))

proc testPop(heap: var HeapQueue[int], flag: int = 1) =
  let val = flag * heap.pop() # Top element dequeue
  echo "\nAfter top element ", val, " dequeued"
  printHeap(heap.toSeq().mapIt(flag * it))

## Driver Code
if isMainModule:
  # Initialize min-heap
  var minHeap = initHeapQueue[int]()
  var flag = 1
  # Initialize max-heap
  var maxHeap = initHeapQueue[int]()
  flag = -1

  echo "\nThe following test cases are for max-heap"
  # Nim's HeapQueue implements a min-heap by default
  # To implement a max-heap, we can negate the elements

  # Enqueue elements
  testPush(maxHeap, 1, flag)
  testPush(maxHeap, 3, flag)
  testPush(maxHeap, 2, flag)
  testPush(maxHeap, 5, flag)
  testPush(maxHeap, 4, flag)

  # Get top element
  let peek = flag * maxHeap[0]
  echo "\nTop element is ", peek

  # Dequeue top element
  testPop(maxHeap, flag)
  testPop(maxHeap, flag)
  testPop(maxHeap, flag)
  testPop(maxHeap, flag)
  testPop(maxHeap, flag)

  # Get heap size
  let size = maxHeap.len
  echo "\nHeap size is ", size

  # Check if empty
  let isEmpty = maxHeap.len == 0
  echo "\nIs heap empty: ", isEmpty

  # Input list and build heap
  var minHeap2 = initHeapQueue[int]()
  for x in [1, 3, 2, 5, 4]:
    minHeap2.push(x)
  echo "\nAfter building min-heap from list"
  printHeap(minHeap2.toSeq())
