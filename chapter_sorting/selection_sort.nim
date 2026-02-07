# File: selection_sort.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

proc selectionSort*(nums: var seq[int]) =
  ## Selection sort
  let n = nums.len
  # Outer loop: unsorted range is [i, n-1]
  for i in 0 ..< n - 1:
    # Inner loop: find the minimum element in the unsorted range
    var k = i
    for j in i + 1 ..< n:
      if nums[j] < nums[k]:
        k = j # Record the index of the minimum element
    # Swap the minimum element with the first element of the unsorted range
    let temp = nums[i]
    nums[i] = nums[k]
    nums[k] = temp

## Driver Code
if isMainModule:
  var nums = @[4, 1, 3, 1, 5, 2]
  selectionSort(nums)
  echo "After selection sort, nums = ", nums
