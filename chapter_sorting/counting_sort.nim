# File: counting_sort.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import std/sequtils

proc countingSortNaive*(nums: var seq[int]) =
  ## Counting sort (simple implementation)
  if nums.len == 0: return
  # 1. Find the maximum element m
  var m = nums[0]
  for num in nums:
    if num > m: m = num
  # 2. Count occurrences of each number
  var counter = newSeq[int](m + 1)
  for num in nums:
    counter[num] += 1
  # 3. Fill the original array with elements in order
  var i = 0
  for num in 0 .. m:
    for _ in 0 ..< counter[num]:
      nums[i] = num
      i += 1

proc countingSort*(nums: var seq[int]) =
  ## Counting sort (complete implementation, stable)
  if nums.len == 0: return
  # 1. Find the maximum element m
  var m = nums[0]
  for num in nums:
    if num > m: m = num
  # 2. Count occurrences of each number
  var counter = newSeq[int](m + 1)
  for num in nums:
    counter[num] += 1
  # 3. Calculate prefix sums of counter
  # counter[num]-1 is the index of the last occurrence of num in res
  for i in 0 ..< m:
    counter[i + 1] += counter[i]
  # 4. Traverse nums in reverse and fill results into res
  let n = nums.len
  var res = newSeq[int](n)
  for i in countdown(n - 1, 0):
    let num = nums[i]
    res[counter[num] - 1] = num
    counter[num] -= 1
  # Update original array
  for i in 0 ..< n:
    nums[i] = res[i]

## Driver Code
if isMainModule:
  var nums = @[1, 0, 1, 2, 0, 4, 0, 2, 2, 4]
  countingSortNaive(nums)
  echo "After counting sort (naive), nums = ", nums

  var nums1 = @[1, 0, 1, 2, 0, 4, 0, 2, 2, 4]
  countingSort(nums1)
  echo "After counting sort, nums1 = ", nums1
