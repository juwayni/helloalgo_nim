# File: merge_sort.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

proc merge(nums: var seq[int], left: int, mid: int, right: int) =
  ## Merge left and right sub-arrays
  # Left sub-array range is [left, mid], right sub-array range is [mid+1, right]
  # Create a temporary array tmp to store the merged result
  var tmp = newSeq[int](right - left + 1)
  # Initialize the starting indices for the left and right sub-arrays and the temporary array
  var i = left
  var j = mid + 1
  var k = 0
  # Compare and copy the smaller element to the temporary array
  while i <= mid and j <= right:
    if nums[i] <= nums[j]:
      tmp[k] = nums[i]
      i += 1
    else:
      tmp[k] = nums[j]
      j += 1
    k += 1
  # Copy the remaining elements from the left and right sub-arrays
  while i <= mid:
    tmp[k] = nums[i]
    i += 1
    k += 1
  while j <= right:
    tmp[k] = nums[j]
    j += 1
    k += 1
  # Copy the merged elements back to the original array nums
  for k2 in 0 ..< tmp.len:
    nums[left + k2] = tmp[k2]

proc mergeSort*(nums: var seq[int], left: int, right: int) =
  ## Merge sort
  # Termination condition
  if left >= right:
    return # Terminate recursion when sub-array length is 1 or 0
  # Divide stage
  let mid = (left + right) div 2 # Calculate midpoint
  mergeSort(nums, left, mid) # Recursively sort left sub-array
  mergeSort(nums, mid + 1, right) # Recursively sort right sub-array
  # Merge stage
  merge(nums, left, mid, right)

## Driver Code
if isMainModule:
  var nums = @[7, 3, 2, 6, 0, 1, 5, 4]
  mergeSort(nums, 0, nums.len - 1)
  echo "After merge sort, nums = ", nums
