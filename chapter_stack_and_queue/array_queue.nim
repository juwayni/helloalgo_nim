# File: array_queue.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

type
  ArrayQueue* = ref object
    nums: seq[int] # Array for storing queue elements
    frontIdx: int # Index of front element
    sizeVal: int # Queue length

proc newArrayQueue*(size: int): ArrayQueue =
  ## Constructor
  ArrayQueue(nums: newSeq[int](size), frontIdx: 0, sizeVal: 0)

proc capacity*(self: ArrayQueue): int =
  ## Get queue capacity
  self.nums.len

proc size*(self: ArrayQueue): int =
  ## Get queue length
  self.sizeVal

proc isEmpty*(self: ArrayQueue): bool =
  ## Check if queue is empty
  self.sizeVal == 0

proc push*(self: ArrayQueue, num: int) =
  ## Enqueue
  if self.sizeVal == self.capacity():
    raise newException(IndexDefect, "Queue is full")
  # Calculate rear index
  let rear = (self.frontIdx + self.sizeVal) mod self.capacity()
  self.nums[rear] = num
  self.sizeVal += 1

proc peek*(self: ArrayQueue): int =
  ## Access the front element
  if self.isEmpty():
    raise newException(IndexDefect, "Queue is empty")
  self.nums[self.frontIdx]

proc pop*(self: ArrayQueue): int =
  ## Dequeue
  let num = self.peek()
  self.frontIdx = (self.frontIdx + 1) mod self.capacity()
  self.sizeVal -= 1
  return num

proc toList*(self: ArrayQueue): seq[int] =
  ## Return seq for printing
  var res = newSeq[int](self.sizeVal)
  for i in 0 ..< self.sizeVal:
    res[i] = self.nums[(self.frontIdx + i) mod self.capacity()]
  return res

## Driver Code
if isMainModule:
  # Initialize queue
  let queue = newArrayQueue(10)

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

  # Test circular array
  for i in 0 ..< 10:
    queue.push(i)
    discard queue.pop()
    echo "Round ", i, " enqueue + dequeue, queue = ", queue.toList()
