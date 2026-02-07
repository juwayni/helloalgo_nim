# File: bucket_sort.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import std/algorithm

proc bucketSort*(nums: var seq[float]) =
  ## Bucket sort
  if nums.len <= 1: return
  # Initialize k = n/2 buckets, expecting 2 elements per bucket on average
  let k = nums.len div 2
  var buckets = newSeq[seq[float]](k)
  for i in 0 ..< k:
    buckets[i] = @[]

  # 1. Distribute elements into buckets
  for num in nums:
    # Input data range is [0, 1), map to [0, k-1] using num * k
    let i = int(num * k.float)
    buckets[i].add(num)

  # 2. Sort each bucket
  for i in 0 ..< k:
    buckets[i].sort()

  # 3. Concatenate all buckets back to nums
  var i = 0
  for bucket in buckets:
    for num in bucket:
      nums[i] = num
      i += 1

## Driver Code
if isMainModule:
  # Assume input data are floats in range [0, 1)
  var nums = @[0.49, 0.96, 0.82, 0.09, 0.57, 0.43, 0.91, 0.75, 0.15, 0.37]
  bucketSort(nums)
  echo "After bucket sort, nums = ", nums
