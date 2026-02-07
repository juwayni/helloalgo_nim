# File: binary_search.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

proc binarySearch(nums: seq[int], target: int): int =
  ## Binary search (double closed interval)
  # Initialize double closed interval [0, n-1]
  var i = 0
  var j = nums.len - 1
  # Loop until the search interval is empty (when i > j)
  while i <= j:
    let m = i + (j - i) div 2 # Calculate midpoint index m
    if nums[m] < target:
      i = m + 1 # target is in [m+1, j]
    elif nums[m] > target:
      j = m - 1 # target is in [i, m-1]
    else:
      return m # Found target element, return its index
  return -1 # Target element not found, return -1

proc binarySearchLcro(nums: seq[int], target: int): int =
  ## Binary search (left-closed right-open interval)
  # Initialize left-closed right-open interval [0, n)
  var i = 0
  var j = nums.len
  # Loop until the search interval is empty (when i == j)
  while i < j:
    let m = i + (j - i) div 2 # Calculate midpoint index m
    if nums[m] < target:
      i = m + 1 # target is in [m+1, j)
    elif nums[m] > target:
      j = m # target is in [i, m)
    else:
      return m # Found target element, return its index
  return -1 # Target element not found, return -1

## Driver Code
if isMainModule:
  let target = 6
  let nums = @[1, 3, 6, 8, 12, 15, 23, 26, 31, 35]

  # Binary search (double closed interval)
  var index = binarySearch(nums, target)
  echo "Index of target element 6 = ", index

  # Binary search (left-closed right-open interval)
  index = binarySearchLcro(nums, target)
  echo "Index of target element 6 = ", index
