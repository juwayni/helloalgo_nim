# File: array.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import std/random

proc randomAccess(nums: seq[int]): int =
  ## Random access element
  # Randomly pick a number in the range [0, nums.len - 1]
  randomize()
  let randomIndex = rand(0 .. nums.len - 1)
  # Get and return the random element
  let randomNum = nums[randomIndex]
  return randomNum

# Note: Python's list is a dynamic array and can be extended directly
# For the purpose of learning, this function treats the list as a fixed-length array
proc extend(nums: seq[int], enlarge: int): seq[int] =
  ## Extend array length
  # Initialize an array with the extended length
  var res = newSeq[int](nums.len + enlarge)
  # Copy all elements from the original array to the new array
  for i in 0 ..< nums.len:
    res[i] = nums[i]
  # Return the extended new array
  return res

proc insert(nums: var seq[int], num: int, index: int) =
  ## Insert element num at index of the array
  # Move all elements at and after index one position backward
  for i in countdown(nums.len - 1, index + 1):
    nums[i] = nums[i - 1]
  # Assign num to the element at index
  nums[index] = num

proc remove(nums: var seq[int], index: int) =
  ## Delete the element at index
  # Move all elements after index one position forward
  for i in index ..< nums.len - 1:
    nums[i] = nums[i + 1]

proc traverse(nums: seq[int]) =
  ## Traverse array
  var count = 0
  # Traverse array by index
  for i in 0 ..< nums.len:
    count += nums[i]
  # Directly traverse array elements
  for num in nums:
    count += num
  # Traverse both index and element
  for i, num in nums:
    count += nums[i]
    count += num

proc find(nums: seq[int], target: int): int =
  ## Search for specified element in array
  for i in 0 ..< nums.len:
    if nums[i] == target:
      return i
  return -1

## Driver Code
if isMainModule:
  # Initialize array
  var arr = newSeq[int](5)
  echo "Array arr = ", arr
  var nums = @[1, 3, 2, 5, 4]
  echo "Array nums = ", nums

  # Random access
  let randomNum = randomAccess(nums)
  echo "Get random element in nums: ", randomNum

  # Length extension
  nums = extend(nums, 3)
  echo "Extend array length to 8, get nums = ", nums

  # Insert element
  insert(nums, 6, 3)
  echo "Insert number 6 at index 3, get nums = ", nums

  # Delete element
  remove(nums, 2)
  echo "Delete element at index 2, get nums = ", nums

  # Traverse array
  traverse(nums)

  # Search element
  let index = find(nums, 3)
  echo "Search for element 3 in nums, get index = ", index
