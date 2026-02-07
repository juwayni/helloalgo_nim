# File: insertion_sort.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

proc insertionSort*(nums: var seq[int]) =
  ## Insertion sort
  # Outer loop: sorted range is [0, i-1]
  for i in 1 ..< nums.len:
    let base = nums[i]
    var j = i - 1
    # Inner loop: insert base into the correct position in sorted range [0, i-1]
    while j >= 0 and nums[j] > base:
      nums[j + 1] = nums[j] # Move nums[j] one position to the right
      j -= 1
    nums[j + 1] = base # Assign base to the correct position

## Driver Code
if isMainModule:
  var nums = @[4, 1, 3, 1, 5, 2]
  insertionSort(nums)
  echo "After insertion sort, nums = ", nums
