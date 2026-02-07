# File: my_list.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

type
  MyList* = ref object
    capacityVal: int # capacity
    arr: seq[int] # array (stores list elements)
    sizeVal: int # list length (current number of elements)
    extendRatio: int # multiple for each expansion

proc newMyList*(): MyList =
  ## Constructor
  MyList(
    capacityVal: 10,
    arr: newSeq[int](10),
    sizeVal: 0,
    extendRatio: 2
  )

proc size*(self: MyList): int =
  ## Get list length (current number of elements)
  self.sizeVal

proc capacity*(self: MyList): int =
  ## Get list capacity
  self.capacityVal

proc get*(self: MyList, index: int): int =
  ## Access element
  if index < 0 or index >= self.sizeVal:
    raise newException(IndexDefect, "Index out of bounds")
  self.arr[index]

proc set*(self: MyList, num: int, index: int) =
  ## Update element
  if index < 0 or index >= self.sizeVal:
    raise newException(IndexDefect, "Index out of bounds")
  self.arr[index] = num

proc extendCapacity*(self: MyList) =
  ## Extend list capacity
  let newCapacity = self.capacityVal * self.extendRatio
  var newArr = newSeq[int](newCapacity)
  for i in 0 ..< self.sizeVal:
    newArr[i] = self.arr[i]
  self.arr = newArr
  self.capacityVal = newCapacity

proc add*(self: MyList, num: int) =
  ## Add element at the end
  if self.sizeVal == self.capacityVal:
    self.extendCapacity()
  self.arr[self.sizeVal] = num
  self.sizeVal += 1

proc insert*(self: MyList, num: int, index: int) =
  ## Insert element in the middle
  if index < 0 or index >= self.sizeVal:
    raise newException(IndexDefect, "Index out of bounds")
  if self.sizeVal == self.capacityVal:
    self.extendCapacity()
  for j in countdown(self.sizeVal - 1, index):
    self.arr[j + 1] = self.arr[j]
  self.arr[index] = num
  self.sizeVal += 1

proc remove*(self: MyList, index: int): int =
  ## Delete element
  if index < 0 or index >= self.sizeVal:
    raise newException(IndexDefect, "Index out of bounds")
  let num = self.arr[index]
  for j in index ..< self.sizeVal - 1:
    self.arr[j] = self.arr[j + 1]
  self.sizeVal -= 1
  return num

proc toArray*(self: MyList): seq[int] =
  ## Return a list of effective length
  if self.sizeVal == 0: return @[]
  self.arr[0 ..< self.sizeVal]

## Driver Code
if isMainModule:
  # Initialize list
  var nums = newMyList()
  # Add elements at the end
  nums.add(1)
  nums.add(3)
  nums.add(2)
  nums.add(5)
  nums.add(4)
  echo "List nums = ", nums.toArray(), ", capacity = ", nums.capacity(), ", size = ", nums.size()

  # Insert element in the middle
  nums.insert(6, 3)
  echo "Insert number 6 at index 3, get nums = ", nums.toArray()

  # Delete element
  discard nums.remove(3)
  echo "Delete element at index 3, get nums = ", nums.toArray()

  # Access element
  let num = nums.get(1)
  echo "Access element at index 1, get num = ", num

  # Update element
  nums.set(0, 1)
  echo "Update element at index 1 to 0, get nums = ", nums.toArray()

  # Test extension mechanism
  for i in 0 ..< 10:
    # When i = 5, the list length will exceed the capacity, triggering expansion
    nums.add(i)
  echo "After expansion, list nums = ", nums.toArray(), ", capacity = ", nums.capacity(), ", size = ", nums.size()
