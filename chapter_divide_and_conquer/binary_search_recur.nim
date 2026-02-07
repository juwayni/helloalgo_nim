# File: binary_search_recur.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

proc dfs(nums: seq[int], target: int, i: int, j: int): int =
  ## Binary search: problem f(i, j)
  # If the range is empty, target element not found, return -1
  if i > j:
    return -1
  # Calculate midpoint index m
  let m = i + (j - i) div 2
  if nums[m] < target:
    # Recursive sub-problem f(m+1, j)
    return dfs(nums, target, m + 1, j)
  elif nums[m] > target:
    # Recursive sub-problem f(i, m-1)
    return dfs(nums, target, i, m - 1)
  else:
    # Target element found, return its index
    return m

proc binarySearch*(nums: seq[int], target: int): int =
  ## Binary search
  let n = nums.len
  # Solve problem f(0, n-1)
  return dfs(nums, target, 0, n - 1)

## Driver Code
if isMainModule:
  let target = 6
  let nums = @[1, 3, 6, 8, 12, 15, 23, 26, 31, 35]

  # Binary search (double closed interval)
  let index = binarySearch(nums, target)
  echo "Index of target element 6 = ", index
