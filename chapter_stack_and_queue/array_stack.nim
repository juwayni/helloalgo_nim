# File: array_stack.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

type
  ArrayStack* = ref object
    stack: seq[int]

proc newArrayStack*(): ArrayStack =
  ## Constructor
  ArrayStack(stack: @[])

proc size*(self: ArrayStack): int =
  ## Get stack length
  self.stack.len

proc isEmpty*(self: ArrayStack): bool =
  ## Check if stack is empty
  self.size() == 0

proc push*(self: ArrayStack, item: int) =
  ## Push element
  self.stack.add(item)

proc pop*(self: ArrayStack): int =
  ## Pop element
  if self.isEmpty():
    raise newException(IndexDefect, "Stack is empty")
  self.stack.pop()

proc peek*(self: ArrayStack): int =
  ## Access the top element
  if self.isEmpty():
    raise newException(IndexDefect, "Stack is empty")
  self.stack[^1]

proc toList*(self: ArrayStack): seq[int] =
  ## Return seq for printing
  self.stack

## Driver Code
if isMainModule:
  # Initialize stack
  let stack = newArrayStack()

  # Push elements
  stack.push(1)
  stack.push(3)
  stack.push(2)
  stack.push(5)
  stack.push(4)
  echo "Stack stack = ", stack.toList()

  # Access the top element
  let peek = stack.peek()
  echo "Top element peek = ", peek

  # Pop element
  let popVal = stack.pop()
  echo "Popped element popVal = ", popVal
  echo "After popping, stack = ", stack.toList()

  # Get stack length
  let size = stack.size()
  echo "Stack length size = ", size

  # Check if empty
  let isEmpty = stack.isEmpty()
  echo "Is stack empty = ", isEmpty
