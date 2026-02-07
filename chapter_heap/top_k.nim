# File: top_k.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import std/heapqueue
import ../modules/print_util

proc topKHeap(nums: seq[int], k: int): seq[int] =
  ## Find the largest k elements in an array using a heap
  # Initialize min-heap
  var heap = initHeapQueue[int]()
  # Enqueue the first k elements
  for i in 0 ..< k:
    heap.push(nums[i])
  # From the (k+1)-th element, maintain the heap size as k
  for i in k ..< nums.len:
    # If the current element is larger than the top element, dequeue top and enqueue current
    if nums[i] > heap[0]:
      discard heap.pop()
      heap.push(nums[i])

  var res: seq[int] = @[]
  for x in heap:
    res.add(x)
  return res

## Driver Code
if isMainModule:
  let nums = @[1, 7, 6, 3, 2]
  let k = 3

  let res = topKHeap(nums, k)
  echo "The largest ", k, " elements are"
  printHeap(res)
