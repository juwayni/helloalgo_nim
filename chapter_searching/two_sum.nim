# File: two_sum.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import std/tables

proc twoSumBruteForce(nums: seq[int], target: int): seq[int] =
  ## Method 1: Brute force
  # Two loops, time complexity O(n^2)
  for i in 0 ..< nums.len - 1:
    for j in i + 1 ..< nums.len:
      if nums[i] + nums[j] == target:
        return @[i, j]
  return @[]

proc twoSumHashTable(nums: seq[int], target: int): seq[int] =
  ## Method 2: Auxiliary hash table
  # Auxiliary hash table, space complexity O(n)
  var dic = initTable[int, int]()
  # Single loop, time complexity O(n)
  for i in 0 ..< nums.len:
    if dic.hasKey(target - nums[i]):
      return @[dic[target - nums[i]], i]
    dic[nums[i]] = i
  return @[]

## Driver Code
if isMainModule:
  # Test Case
  let nums = @[2, 7, 11, 15]
  let target = 13

  # Method 1
  var res = twoSumBruteForce(nums, target)
  echo "Method 1 res = ", res
  # Method 2
  res = twoSumHashTable(nums, target)
  echo "Method 2 res = ", res
