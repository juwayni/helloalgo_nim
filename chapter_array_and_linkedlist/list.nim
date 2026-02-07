# File: list.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import std/algorithm

## Driver Code
if isMainModule:
  # Initialize list
  var nums = @[1, 3, 2, 5, 4]
  echo "\nList nums = ", nums

  # Access element
  let x = nums[1]
  echo "\nAccess element at index 1, get x = ", x

  # Update element
  nums[1] = 0
  echo "\nUpdate element at index 1 to 0, get nums = ", nums

  # Clear list
  nums.setLen(0)
  echo "\nAfter clearing list nums = ", nums

  # Append elements at the end
  nums.add(1)
  nums.add(3)
  nums.add(2)
  nums.add(5)
  nums.add(4)
  echo "\nAfter adding elements nums = ", nums

  # Insert element in the middle
  nums.insert(6, 3)
  echo "\nInsert number 6 at index 3, get nums = ", nums

  # Delete element
  nums.delete(3)
  echo "\nDelete element at index 3, get nums = ", nums

  # Traverse list by index
  var count = 0
  for i in 0 ..< nums.len:
    count += nums[i]
  # Directly traverse list elements
  for num in nums:
    count += num

  # Concatenate two lists
  let nums1 = @[6, 8, 7, 10, 9]
  nums.add(nums1)
  echo "\nAfter concatenating nums1 to nums, get nums = ", nums

  # Sort list
  nums.sort()
  echo "\nAfter sorting list nums = ", nums
