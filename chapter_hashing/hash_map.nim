# File: hash_map.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import std/tables
import ../modules/print_util

## Driver Code
if isMainModule:
  # Initialize hash map
  var hmap = initTable[int, string]()

  # Add operations
  hmap[12836] = "Xiao Ha"
  hmap[15937] = "Xiao Luo"
  hmap[16750] = "Xiao Suan"
  hmap[13276] = "Xiao Fa"
  hmap[10583] = "Xiao Ya"
  echo "\nAfter adding, hash map is\nKey -> Value"
  printDict(hmap)

  # Query operation
  let name = hmap[15937]
  echo "\nInput ID 15937, queried name: ", name

  # Delete operation
  hmap.del(10583)
  echo "\nAfter deleting 10583, hash map is\nKey -> Value"
  printDict(hmap)

  # Traverse hash map
  echo "\nTraverse Key->Value pairs"
  for key, value in hmap.pairs:
    echo key, " -> ", value

  echo "\nTraverse keys only"
  for key in hmap.keys:
    echo key

  echo "\nTraverse values only"
  for val in hmap.values:
    echo val
