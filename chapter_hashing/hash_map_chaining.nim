# File: hash_map_chaining.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import std/sequtils
import ./array_hash_map

type
  HashMapChaining* = ref object
    sizeVal: int
    capacityVal: int
    loadThres: float
    extendRatio: int
    buckets: seq[seq[Pair]]

proc newHashMapChaining*(): HashMapChaining =
  ## Constructor
  HashMapChaining(
    sizeVal: 0,
    capacityVal: 4,
    loadThres: 2.0 / 3.0,
    extendRatio: 2,
    buckets: newSeqWith(4, newSeq[Pair]())
  )

proc hashFunc(self: HashMapChaining, key: int): int =
  ## Hash function
  key mod self.capacityVal

proc loadFactor(self: HashMapChaining): float =
  ## Load factor
  self.sizeVal.float / self.capacityVal.float

proc get*(self: HashMapChaining, key: int): string =
  ## Query operation
  let index = self.hashFunc(key)
  let bucket = self.buckets[index]
  for pair in bucket:
    if pair.key == key:
      return pair.val
  return ""

proc extend(self: HashMapChaining) =
  ## Extend hash map
  let oldBuckets = self.buckets
  self.capacityVal *= self.extendRatio
  self.buckets = newSeqWith(self.capacityVal, newSeq[Pair]())
  self.sizeVal = 0
  for bucket in oldBuckets:
    for pair in bucket:
      let index = self.hashFunc(pair.key)
      self.buckets[index].add(pair)
      self.sizeVal += 1

proc put*(self: HashMapChaining, key: int, val: string) =
  ## Add operation
  if self.loadFactor() > self.loadThres:
    self.extend()
  let index = self.hashFunc(key)
  for i in 0 ..< self.buckets[index].len:
    if self.buckets[index][i].key == key:
      self.buckets[index][i].val = val
      return

  let pair = newPair(key, val)
  self.buckets[index].add(pair)
  self.sizeVal += 1

proc remove*(self: HashMapChaining, key: int) =
  ## Delete operation
  let index = self.hashFunc(key)
  for i in 0 ..< self.buckets[index].len:
    if self.buckets[index][i].key == key:
      self.buckets[index].delete(i)
      self.sizeVal -= 1
      break

proc print*(self: HashMapChaining) =
  ## Print hash map
  for bucket in self.buckets:
    var res: seq[string] = @[]
    for pair in bucket:
      res.add($pair.key & " -> " & pair.val)
    echo res

## Driver Code
if isMainModule:
  # Initialize hash map
  let hashmap = newHashMapChaining()

  # Add operations
  hashmap.put(12836, "Xiao Ha")
  hashmap.put(15937, "Xiao Luo")
  hashmap.put(16750, "Xiao Suan")
  hashmap.put(13276, "Xiao Fa")
  hashmap.put(10583, "Xiao Ya")
  echo "\nAfter adding, hash map is\n[Key1 -> Value1, Key2 -> Value2, ...]"
  hashmap.print()

  # Query operation
  let name = hashmap.get(13276)
  echo "\nInput ID 13276, queried name: ", name

  # Delete operation
  hashmap.remove(12836)
  echo "\nAfter deleting 12836, hash map is\n[Key1 -> Value1, Key2 -> Value2, ...]"
  hashmap.print()
