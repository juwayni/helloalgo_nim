# File: linear_search.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import ../modules/list_node

proc linearSearchArray(nums: seq[int], target: int): int =
  ## Linear search (array)
  # Traverse array
  for i in 0 ..< nums.len:
    if nums[i] == target: # Found target element, return its index
      return i
  return -1 # Target element not found, return -1

proc linearSearchLinkedList(head: ListNode, target: int): ListNode =
  ## Linear search (linked list)
  # Traverse linked list
  var curr = head
  while curr != nil:
    if curr.val == target: # Found target node, return it
      return curr
    curr = curr.next
  return nil # Target node not found, return nil

## Driver Code
if isMainModule:
  let target = 3

  # Perform linear search in array
  let nums = @[1, 5, 3, 2, 4, 7, 5, 9, 10, 8]
  let index = linearSearchArray(nums, target)
  echo "Index of target element 3 = ", index

  # Perform linear search in linked list
  let head = listToLinkedList(nums)
  let node = linearSearchLinkedList(head, target)
  echo "Target node with value 3: ", if node != nil: $node.val else: "nil"
