# File: quick_sort.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

proc partition(nums: var seq[int], left: int, right: int): int =
  ## Sentinel partition
  # Use nums[left] as the pivot
  var i = left
  var j = right
  while i < j:
    while i < j and nums[j] >= nums[left]:
      j -= 1 # Find the first element smaller than the pivot from right to left
    while i < j and nums[i] <= nums[left]:
      i += 1 # Find the first element larger than the pivot from left to right
    # Swap elements
    let temp = nums[i]
    nums[i] = nums[j]
    nums[j] = temp
  # Swap the pivot to the boundary between the two sub-arrays
  let temp = nums[i]
  nums[i] = nums[left]
  nums[left] = temp
  return i # Return the index of the pivot

proc quickSort*(nums: var seq[int], left: int, right: int) =
  ## Quick sort
  # Terminate recursion when sub-array length is 1 or 0
  if left >= right:
    return
  # Sentinel partition
  let pivot = partition(nums, left, right)
  # Recursively sort left and right sub-arrays
  quickSort(nums, left, pivot - 1)
  quickSort(nums, pivot + 1, right)

proc medianThree(nums: seq[int], left: int, mid: int, right: int): int =
  ## Select the median of three candidate elements
  let l = nums[left]
  let m = nums[mid]
  let r = nums[right]
  if (l <= m and m <= r) or (r <= m and m <= l):
    return mid # m is between l and r
  if (m <= l and l <= r) or (r <= l and l <= m):
    return left # l is between m and r
  return right

proc partitionMedian(nums: var seq[int], left: int, right: int): int =
  ## Sentinel partition (median-of-three optimization)
  let med = medianThree(nums, left, (left + right) div 2, right)
  # Swap the median to the leftmost end of the array
  let temp1 = nums[left]
  nums[left] = nums[med]
  nums[med] = temp1
  # Use nums[left] as the pivot
  var i = left
  var j = right
  while i < j:
    while i < j and nums[j] >= nums[left]:
      j -= 1
    while i < j and nums[i] <= nums[left]:
      i += 1
    let temp = nums[i]
    nums[i] = nums[j]
    nums[j] = temp
  let temp2 = nums[i]
  nums[i] = nums[left]
  nums[left] = temp2
  return i

proc quickSortMedian*(nums: var seq[int], left: int, right: int) =
  ## Quick sort (median-of-three optimization)
  if left >= right:
    return
  let pivot = partitionMedian(nums, left, right)
  quickSortMedian(nums, left, pivot - 1)
  quickSortMedian(nums, pivot + 1, right)

proc quickSortTailCall*(nums: var seq[int], left: int, right: int) =
  ## Quick sort (tail call/recursion depth optimization)
  var l = left
  var r = right
  while l < r:
    # Sentinel partition
    let pivot = partition(nums, l, r)
    # Recursively sort the shorter of the two sub-arrays
    if pivot - l < r - pivot:
      quickSortTailCall(nums, l, pivot - 1) # Recursively sort left sub-array
      l = pivot + 1 # Remaining unsorted range is [pivot + 1, r]
    else:
      quickSortTailCall(nums, pivot + 1, r) # Recursively sort right sub-array
      r = pivot - 1 # Remaining unsorted range is [l, pivot - 1]

## Driver Code
if isMainModule:
  # Quick sort
  var nums = @[2, 4, 1, 0, 3, 5]
  quickSort(nums, 0, nums.len - 1)
  echo "After quick sort, nums = ", nums

  # Quick sort (median-of-three optimization)
  var nums1 = @[2, 4, 1, 0, 3, 5]
  quickSortMedian(nums1, 0, nums1.len - 1)
  echo "After quick sort (median optimization), nums1 = ", nums1

  # Quick sort (recursion depth optimization)
  var nums2 = @[2, 4, 1, 0, 3, 5]
  quickSortTailCall(nums2, 0, nums2.len - 1)
  echo "After quick sort (recursion depth optimization), nums2 = ", nums2
