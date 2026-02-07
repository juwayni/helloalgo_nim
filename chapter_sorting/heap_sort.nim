# File: heap_sort.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

proc siftDown(nums: var seq[int], n: int, i: int) =
  ## Sift down from node i in a heap of length n
  var curr = i
  while true:
    # Find the largest among node curr, its left child l, and its right child r
    let l = 2 * curr + 1
    let r = 2 * curr + 2
    var ma = curr
    if l < n and nums[l] > nums[ma]:
      ma = l
    if r < n and nums[r] > nums[ma]:
      ma = r
    # If node curr is the largest or l, r are out of bounds, break
    if ma == curr:
      break
    # Swap nodes
    let temp = nums[curr]
    nums[curr] = nums[ma]
    nums[ma] = temp
    # Move down to continue sift-down
    curr = ma

proc heapSort*(nums: var seq[int]) =
  ## Heap sort
  # Build heap: sift down all nodes except leaf nodes
  for i in countdown(nums.len div 2 - 1, 0):
    siftDown(nums, nums.len, i)
  # Extract max element from heap for n-1 rounds
  for i in countdown(nums.len - 1, 1):
    # Swap root node with the rightmost leaf node
    let temp = nums[0]
    nums[0] = nums[i]
    nums[i] = temp
    # Sift down from root
    siftDown(nums, i, 0)

## Driver Code
if isMainModule:
  var nums = @[4, 1, 3, 1, 5, 2]
  heapSort(nums)
  echo "After heap sort, nums = ", nums
