# File: my_heap.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import ../modules/print_util

type
  MaxHeap* = ref object
    maxHeap: seq[int]

proc left(self: MaxHeap, i: int): int =
  ## Get index of left child
  2 * i + 1

proc right(self: MaxHeap, i: int): int =
  ## Get index of right child
  2 * i + 2

proc parent(self: MaxHeap, i: int): int =
  ## Get index of parent
  (i - 1) div 2

proc swap(self: MaxHeap, i: int, j: int) =
  ## Swap elements
  let tmp = self.maxHeap[i]
  self.maxHeap[i] = self.maxHeap[j]
  self.maxHeap[j] = tmp

proc size*(self: MaxHeap): int =
  ## Get heap size
  self.maxHeap.len

proc isEmpty*(self: MaxHeap): bool =
  ## Check if heap is empty
  self.size() == 0

proc peek*(self: MaxHeap): int =
  ## Access the top element
  if self.isEmpty():
    raise newException(IndexDefect, "Heap is empty")
  self.maxHeap[0]

proc siftDown(self: MaxHeap, i: int) =
  ## Sift down from index i
  var curr = i
  while true:
    let l = self.left(curr)
    let r = self.right(curr)
    var ma = curr
    if l < self.size() and self.maxHeap[l] > self.maxHeap[ma]:
      ma = l
    if r < self.size() and self.maxHeap[r] > self.maxHeap[ma]:
      ma = r
    if ma == curr:
      break
    self.swap(curr, ma)
    curr = ma

proc newMaxHeap*(nums: seq[int]): MaxHeap =
  ## Constructor, build heap from input list
  let h = MaxHeap(maxHeap: nums)
  # Heapify all nodes except leaf nodes
  if h.size() > 0:
    for i in countdown(h.parent(h.size() - 1), 0):
      h.siftDown(i)
  return h

proc siftUp(self: MaxHeap, i: int) =
  ## Sift up from index i
  var curr = i
  while true:
    let p = self.parent(curr)
    if p < 0 or self.maxHeap[curr] <= self.maxHeap[p]:
      break
    self.swap(curr, p)
    curr = p

proc push*(self: MaxHeap, val: int) =
  ## Enqueue element
  self.maxHeap.add(val)
  self.siftUp(self.size() - 1)

proc pop*(self: MaxHeap): int =
  ## Dequeue top element
  if self.isEmpty():
    raise newException(IndexDefect, "Heap is empty")
  self.swap(0, self.size() - 1)
  let val = self.maxHeap.pop()
  if not self.isEmpty():
    self.siftDown(0)
  return val

proc print*(self: MaxHeap) =
  ## Print heap
  printHeap(self.maxHeap)

## Driver Code
if isMainModule:
  # Initialize max-heap
  let maxHeap = newMaxHeap(@[9, 8, 6, 6, 7, 5, 2, 1, 4, 3, 6, 2])
  echo "\nAfter building max-heap from list"
  maxHeap.print()

  # Get top element
  let peekVal = maxHeap.peek()
  echo "\nTop element is ", peekVal

  # Enqueue element
  let val = 7
  maxHeap.push(val)
  echo "\nAfter element ", val, " enqueued"
  maxHeap.print()

  # Dequeue top element
  let popVal = maxHeap.pop()
  echo "\nTop element ", popVal, " dequeued"
  maxHeap.print()

  # Get size
  let sizeVal = maxHeap.size()
  echo "\nHeap size is ", sizeVal

  # Check if empty
  let isEmptyVal = maxHeap.isEmpty()
  echo "\nIs heap empty: ", isEmptyVal
