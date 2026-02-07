# File: iteration.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

proc forLoop*(n: int): int =
  ## for loop
  var res = 0
  # Sum 1, 2, ..., n
  for i in 1 .. n:
    res += i
  return res

proc whileLoop*(n: int): int =
  ## while loop
  var res = 0
  var i = 1 # Initialize condition variable
  # Sum 1, 2, ..., n
  while i <= n:
    res += i
    i += 1 # Update condition variable
  return res

proc whileLoopII*(n: int): int =
  ## while loop (two updates)
  var res = 0
  var i = 1 # Initialize condition variable
  # Sum 1, 4, 10, ...
  while i <= n:
    res += i
    # Update condition variable
    i += 1
    i *= 2
  return res

proc nestedForLoop*(n: int): string =
  ## Nested for loop
  var res = ""
  # Loop i = 1, 2, ..., n
  for i in 1 .. n:
    # Loop j = 1, 2, ..., n
    for j in 1 .. n:
      res &= "(" & $i & ", " & $j & "), "
  return res

## Driver Code
if isMainModule:
  let n = 5
  var resSum = forLoop(n)
  echo "\nSum from for loop: res = ", resSum

  resSum = whileLoop(n)
  echo "\nSum from while loop: res = ", resSum

  resSum = whileLoopII(n)
  echo "\nSum from while loop (two updates): res = ", resSum

  let resStr = nestedForLoop(n)
  echo "\nTraversal result from nested for loop: ", resStr
