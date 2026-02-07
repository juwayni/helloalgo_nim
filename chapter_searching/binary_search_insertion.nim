# File: binary_search_insertion.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

proc binarySearchInsertionSimple*(nums: seq[int], target: int): int =
  ## Binary search insertion point (no duplicate elements)
  var i = 0
  var j = nums.len - 1 # Initialize double closed interval [0, n-1]
  while i <= j:
    let m = i + (j - i) div 2 # Calculate midpoint index m
    if nums[m] < target:
      i = m + 1 # target is in [m+1, j]
    elif nums[m] > target:
      j = m - 1 # target is in [i, m-1]
    else:
      return m # Found target, return insertion point m
  # target not found, return insertion point i
  return i

proc binarySearchInsertion*(nums: seq[int], target: int): int =
  ## Binary search insertion point (duplicate elements exist)
  var i = 0
  var j = nums.len - 1 # Initialize double closed interval [0, n-1]
  while i <= j:
    let m = i + (j - i) div 2 # Calculate midpoint index m
    if nums[m] < target:
      i = m + 1 # target is in [m+1, j]
    elif nums[m] > target:
      j = m - 1 # target is in [i, m-1]
    else:
      j = m - 1 # First element >= target is in [i, m-1]
  # Return insertion point i
  return i

## Driver Code
if isMainModule:
  # Array with no duplicate elements
  var nums = @[1, 3, 6, 8, 12, 15, 23, 26, 31, 35]
  echo "\nArray nums = ", nums
  # Binary search insertion point
  for target in [6, 9]:
    let index = binarySearchInsertionSimple(nums, target)
    echo "Insertion point for element ", target, " is index ", index

  # Array with duplicate elements
  nums = @[1, 3, 6, 6, 6, 6, 6, 10, 12, 15]
  echo "\nArray nums = ", nums
  # Binary search insertion point
  for target in [2, 6, 20]:
    let index = binarySearchInsertion(nums, target)
    echo "Insertion point for element ", target, " is index ", index
