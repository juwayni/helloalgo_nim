# File: bubble_sort.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

proc bubbleSort*(nums: var seq[int]) =
  ## Bubble sort
  let n = nums.len
  # Outer loop: unsorted range is [0, i]
  for i in countdown(n - 1, 1):
    # Inner loop: move the maximum element in [0, i] to the right end
    for j in 0 ..< i:
      if nums[j] > nums[j + 1]:
        # Swap nums[j] and nums[j + 1]
        let temp = nums[j]
        nums[j] = nums[j + 1]
        nums[j + 1] = temp

proc bubbleSortWithFlag*(nums: var seq[int]) =
  ## Bubble sort (flag optimization)
  let n = nums.len
  # Outer loop: unsorted range is [0, i]
  for i in countdown(n - 1, 1):
    var flag = false # Initialize flag
    # Inner loop: move the maximum element in [0, i] to the right end
    for j in 0 ..< i:
      if nums[j] > nums[j + 1]:
        # Swap nums[j] and nums[j + 1]
        let temp = nums[j]
        nums[j] = nums[j + 1]
        nums[j + 1] = temp
        flag = true # Record swap
    if not flag:
      break # No swap occurred this round, break

## Driver Code
if isMainModule:
  var nums = @[4, 1, 3, 1, 5, 2]
  bubbleSort(nums)
  echo "After bubble sort, nums = ", nums

  var nums1 = @[4, 1, 3, 1, 5, 2]
  bubbleSortWithFlag(nums1)
  echo "After bubble sort with flag, nums1 = ", nums1
