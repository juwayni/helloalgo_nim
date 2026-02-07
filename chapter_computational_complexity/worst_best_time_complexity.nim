# File: worst_best_time_complexity.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import std/random

proc randomNumbers*(n: int): seq[int] =
  ## Generate an array with elements 1, 2, ..., n, shuffled
  var nums: seq[int] = @[]
  for i in 1 .. n: nums.add(i)
  # Shuffle the array
  randomize()
  shuffle(nums)
  return nums

proc findOne*(nums: seq[int]): int =
  ## Find the index of number 1 in the array
  for i in 0 ..< nums.len:
    # Best case O(1) if 1 is at the head
    # Worst case O(n) if 1 is at the tail
    if nums[i] == 1:
      return i
  return -1

## Driver Code
if isMainModule:
  for i in 0 ..< 10:
    let n = 100
    let nums = randomNumbers(n)
    let index = findOne(nums)
    echo "\nArray [ 1, 2, ..., n ] after shuffling = ", nums
    echo "Index of number 1 is ", index
