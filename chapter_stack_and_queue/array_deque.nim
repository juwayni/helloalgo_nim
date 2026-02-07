# File: array_deque.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

type
  ArrayDeque* = ref object
    nums: seq[int]
    frontIdx: int
    sizeVal: int

proc newArrayDeque*(capacity: int): ArrayDeque =
  ## Constructor
  ArrayDeque(nums: newSeq[int](capacity), frontIdx: 0, sizeVal: 0)

proc capacity*(self: ArrayDeque): int =
  ## Get deque capacity
  self.nums.len

proc size*(self: ArrayDeque): int =
  ## Get deque length
  self.sizeVal

proc isEmpty*(self: ArrayDeque): bool =
  ## Check if deque is empty
  self.sizeVal == 0

proc index(self: ArrayDeque, i: int): int =
  ## Calculate circular array index
  (i + self.capacity()) mod self.capacity()

proc pushFirst*(self: ArrayDeque, num: int) =
  ## Enqueue at front
  if self.sizeVal == self.capacity():
    echo "Deque is full"
    return
  self.frontIdx = self.index(self.frontIdx - 1)
  self.nums[self.frontIdx] = num
  self.sizeVal += 1

proc pushLast*(self: ArrayDeque, num: int) =
  ## Enqueue at rear
  if self.sizeVal == self.capacity():
    echo "Deque is full"
    return
  let rear = self.index(self.frontIdx + self.sizeVal)
  self.nums[rear] = num
  self.sizeVal += 1

proc peekFirst*(self: ArrayDeque): int =
  ## Access the front element
  if self.isEmpty():
    raise newException(IndexDefect, "Deque is empty")
  self.nums[self.frontIdx]

proc peekLast*(self: ArrayDeque): int =
  ## Access the rear element
  if self.isEmpty():
    raise newException(IndexDefect, "Deque is empty")
  let last = self.index(self.frontIdx + self.sizeVal - 1)
  self.nums[last]

proc popFirst*(self: ArrayDeque): int =
  ## Dequeue from front
  let num = self.peekFirst()
  self.frontIdx = self.index(self.frontIdx + 1)
  self.sizeVal -= 1
  return num

proc popLast*(self: ArrayDeque): int =
  ## Dequeue from rear
  let num = self.peekLast()
  self.sizeVal -= 1
  return num

proc toArray*(self: ArrayDeque): seq[int] =
  ## Return seq for printing
  var res: seq[int] = @[]
  for i in 0 ..< self.sizeVal:
    res.add(self.nums[self.index(self.frontIdx + i)])
  return res

## Driver Code
if isMainModule:
  # Initialize deque
  let deque = newArrayDeque(10)
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
