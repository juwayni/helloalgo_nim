# File: binary_search_edge.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import ./binary_search_insertion

proc binarySearchLeftEdge(nums: seq[int], target: int): int =
  ## Binary search for the leftmost target
  # Equivalent to finding the insertion point of target
  let i = binarySearchInsertion(nums, target)
  # target not found, return -1
  if i == nums.len or nums[i] != target:
    return -1
  # Found target, return index i
  return i

proc binarySearchRightEdge(nums: seq[int], target: int): int =
  ## Binary search for the rightmost target
  # Convert to finding the leftmost target + 1
  let i = binarySearchInsertion(nums, target + 1)
  # j points to the rightmost target, i points to the first element > target
  let j = i - 1
  # target not found, return -1
  if j == -1 or nums[j] != target:
    return -1
  # Found target, return index j
  return j

## Driver Code
if isMainModule:
  # Array with duplicate elements
  let nums = @[1, 3, 6, 6, 6, 6, 6, 10, 12, 15]
  echo "\nArray nums = ", nums

  # Binary search for left and right edges
  for target in [6, 7]:
    var index = binarySearchLeftEdge(nums, target)
    echo "Index of the leftmost element ", target, " is ", index
    index = binarySearchRightEdge(nums, target)
    echo "Index of the rightmost element ", target, " is ", index
