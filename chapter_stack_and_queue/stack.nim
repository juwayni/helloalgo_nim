# File: stack.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

## Driver Code
if isMainModule:
  # Initialize stack
  # Nim's seq can be used as a stack
  var stack: seq[int] = @[]

  # Push elements
  stack.add(1)
  stack.add(3)
  stack.add(2)
  stack.add(5)
  stack.add(4)
  echo "Stack stack = ", stack

  # Access the top element
  let peek = stack[^1]
  echo "Top element peek = ", peek

  # Pop element
  let popVal = stack.pop()
  echo "Popped element popVal = ", popVal
  echo "After popping, stack = ", stack

  # Get stack length
  let size = stack.len
  echo "Stack length size = ", size

  # Check if empty
  let isEmpty = stack.len == 0
  echo "Is stack empty = ", isEmpty
