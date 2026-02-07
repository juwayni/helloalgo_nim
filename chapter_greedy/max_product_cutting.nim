# File: max_product_cutting.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import std/math

proc maxProductCutting*(n: int): int =
  ## Max product cutting: greedy
  # When n <= 3, must cut at least once
  if n <= 3:
    return 1 * (n - 1)
  # Greedily cut out 3s
  let a = n div 3
  let b = n mod 3
  if b == 1:
    # If remainder is 1, convert one 1*3 to 2*2
    return (3.float.pow((a - 1).float)).int * 2 * 2
  if b == 2:
    # If remainder is 2, just multiply
    return (3.float.pow(a.float)).int * 2
  # If remainder is 0
  return (3.float.pow(a.float)).int

## Driver Code
if isMainModule:
  let n = 58

  # Greedy algorithm
  let res = maxProductCutting(n)
  echo "Max product cutting = ", res
