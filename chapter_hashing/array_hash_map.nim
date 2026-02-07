# File: array_hash_map.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

type
  Pair* = ref object
    key*: int
    val*: string

proc newPair*(key: int, val: string): Pair =
  Pair(key: key, val: val)

type
  ArrayHashMap* = ref object
    buckets: seq[Pair]

proc newArrayHashMap*(): ArrayHashMap =
  ## Constructor
  ArrayHashMap(buckets: newSeq[Pair](100))

proc hashFunc(self: ArrayHashMap, key: int): int =
  ## Hash function
  (key mod 100 + 100) mod 100

proc get*(self: ArrayHashMap, key: int): string =
  ## Query operation
  let index = self.hashFunc(key)
  let pair = self.buckets[index]
  if pair == nil:
    return ""
  pair.val

proc put*(self: ArrayHashMap, key: int, val: string) =
  ## Add or update operation
  let pair = newPair(key, val)
  let index = self.hashFunc(key)
  self.buckets[index] = pair

proc remove*(self: ArrayHashMap, key: int) =
  ## Delete operation
  let index = self.hashFunc(key)
  self.buckets[index] = nil

proc entrySet*(self: ArrayHashMap): seq[Pair] =
  ## Get all key-value pairs
  var res: seq[Pair] = @[]
  for pair in self.buckets:
    if pair != nil:
      res.add(pair)
  return res

proc keySet*(self: ArrayHashMap): seq[int] =
  ## Get all keys
  var res: seq[int] = @[]
  for pair in self.buckets:
    if pair != nil:
      res.add(pair.key)
  return res

proc valueSet*(self: ArrayHashMap): seq[string] =
  ## Get all values
  var res: seq[string] = @[]
  for pair in self.buckets:
    if pair != nil:
      res.add(pair.val)
  return res

proc print*(self: ArrayHashMap) =
  ## Print hash map
  for pair in self.buckets:
    if pair != nil:
      echo pair.key, " -> ", pair.val

## Driver Code
if isMainModule:
  # Initialize hash map
  let hmap = newArrayHashMap()

  # Add operations
  hmap.put(12836, "Xiao Ha")
  hmap.put(15937, "Xiao Luo")
  hmap.put(16750, "Xiao Suan")
  hmap.put(13276, "Xiao Fa")
  hmap.put(10583, "Xiao Ya")
  echo "\nAfter adding, hash map is\nKey -> Value"
  hmap.print()

  # Query operation
  let name = hmap.get(15937)
  echo "\nInput ID 15937, queried name: ", name

  # Delete operation
  hmap.remove(10583)
  echo "\nAfter deleting 10583, hash map is\nKey -> Value"
  hmap.print()

  # Traverse hash map
  echo "\nTraverse Key->Value pairs"
  for pair in hmap.entrySet():
    echo pair.key, " -> ", pair.val

  echo "\nTraverse keys only"
  for key in hmap.keySet():
    echo key

  echo "\nTraverse values only"
  for val in hmap.valueSet():
    echo val
