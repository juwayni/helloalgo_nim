# File: hashing_search.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import std/tables
import ../modules/list_node

proc hashingSearchArray(hmap: Table[int, int], target: int): int =
  ## Hashing search (array)
  # Hash map key: target element, value: index
  # If key is not in hash map, return -1
  hmap.getOrDefault(target, -1)

proc hashingSearchLinkedList(hmap: Table[int, ListNode], target: int): ListNode =
  ## Hashing search (linked list)
  # Hash map key: node value, value: node object
  # If key is not in hash map, return nil
  hmap.getOrDefault(target, nil)

## Driver Code
if isMainModule:
  let target = 3

  # Hashing search (array)
  let nums = @[1, 5, 3, 2, 4, 7, 5, 9, 10, 8]
  # Initialize hash map
  var map0 = initTable[int, int]()
  for i in 0 ..< nums.len:
    map0[nums[i]] = i # key: element, value: index
  let index = hashingSearchArray(map0, target)
  echo "Index of target element 3 = ", index

  # Hashing search (linked list)
  var head = listToLinkedList(nums)
  # Initialize hash map
  var map1 = initTable[int, ListNode]()
  var curr = head
  while curr != nil:
    map1[curr.val] = curr # key: node value, value: node
    curr = curr.next
  let node = hashingSearchLinkedList(map1, target)
  echo "Target node with value 3: ", if node != nil: $node.val else: "nil"
