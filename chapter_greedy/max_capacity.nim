# File: max_capacity.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

proc maxCapacity*(ht: seq[int]): int =
  ## Max capacity: greedy
  # Initialize i, j at both ends of the array
  var i = 0
  var j = ht.len - 1
  # Initial max capacity is 0
  var res = 0
  # Greedily move pointers inward until they meet
  while i < j:
    # Update max capacity
    let cap = min(ht[i], ht[j]) * (j - i)
    res = max(res, cap)
    # Move the shorter board inward
    if ht[i] < ht[j]:
      i += 1
    else:
      j -= 1
  return res

## Driver Code
if isMainModule:
  let ht = @[3, 8, 5, 2, 7, 7, 3, 4]

  # Greedy algorithm
  let res = maxCapacity(ht)
  echo "Max capacity = ", res
