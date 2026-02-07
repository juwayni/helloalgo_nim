# File: fractional_knapsack.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import std/algorithm

type
  Item = object
    w: int # Weight
    v: int # Value

proc fractionalKnapsack*(wgt: seq[int], val: seq[int], cap: int): float =
  ## Fractional knapsack: greedy
  # Create item list
  var items: seq[Item] = @[]
  for i in 0 ..< wgt.len:
    items.add(Item(w: wgt[i], v: val[i]))

  # Sort items by unit value v/w in descending order
  items.sort(proc (x, y: Item): int =
    let valX = x.v.float / x.w.float
    let valY = y.v.float / y.w.float
    if valX > valY: -1
    elif valX < valY: 1
    else: 0
  )

  var res = 0.0
  var remainingCap = cap.float
  # Greedily pick items
  for item in items:
    if item.w.float <= remainingCap:
      # If remaining capacity is enough, take the whole item
      res += item.v.float
      remainingCap -= item.w.float
    else:
      # Otherwise, take a fraction of the item
      res += (item.v.float / item.w.float) * remainingCap
      break
  return res

## Driver Code
if isMainModule:
  let wgt = @[10, 20, 30, 40, 50]
  let val = @[50, 120, 150, 210, 240]
  let cap = 50

  # Greedy algorithm
  let res = fractionalKnapsack(wgt, val, cap)
  echo "Max value (fractional knapsack) = ", res
