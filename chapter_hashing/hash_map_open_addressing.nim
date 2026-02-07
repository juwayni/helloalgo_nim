# File: hash_map_open_addressing.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import ./array_hash_map

type
  HashMapOpenAddressing* = ref object
    sizeVal: int
    capacityVal: int
    loadThres: float
    extendRatio: int
    buckets: seq[Pair]
    tombstone: Pair

proc newHashMapOpenAddressing*(): HashMapOpenAddressing =
  ## Constructor
  let tomb = newPair(-1, "-1")
  HashMapOpenAddressing(
    sizeVal: 0,
    capacityVal: 4,
    loadThres: 2.0 / 3.0,
    extendRatio: 2,
    buckets: newSeq[Pair](4),
    tombstone: tomb
  )

proc hashFunc(self: HashMapOpenAddressing, key: int): int =
  ## Hash function
  key mod self.capacityVal

proc loadFactor(self: HashMapOpenAddressing): float =
  ## Load factor
  self.sizeVal.float / self.capacityVal.float

proc findBucket(self: HashMapOpenAddressing, key: int): int =
  ## Search for the bucket index corresponding to key
  var index = self.hashFunc(key)
  var firstTombstone = -1
  # Linear probing, break when encountering an empty bucket
  while self.buckets[index] != nil:
    # If key is found, return the bucket index
    if self.buckets[index].key == key:
      # If a tombstone was encountered before, move the pair to that index
      if firstTombstone != -1:
        self.buckets[firstTombstone] = self.buckets[index]
        self.buckets[index] = self.tombstone
        return firstTombstone
      return index

    # Record the first tombstone encountered
    if firstTombstone == -1 and self.buckets[index] == self.tombstone:
      firstTombstone = index

    # Calculate next bucket index
    index = (index + 1) mod self.capacityVal

  # If key doesn't exist, return the index of the addition point
  if firstTombstone != -1: return firstTombstone
  return index

proc get*(self: HashMapOpenAddressing, key: int): string =
  ## Query operation
  let index = self.findBucket(key)
  if self.buckets[index] != nil and self.buckets[index] != self.tombstone:
    return self.buckets[index].val
  return ""

proc put*(self: HashMapOpenAddressing, key: int, val: string) # forward declaration

proc extend(self: HashMapOpenAddressing) =
  ## Extend hash map
  let oldBuckets = self.buckets
  self.capacityVal *= self.extendRatio
  self.buckets = newSeq[Pair](self.capacityVal)
  self.sizeVal = 0
  for pair in oldBuckets:
    if pair != nil and pair != self.tombstone:
      self.put(pair.key, pair.val)

proc put*(self: HashMapOpenAddressing, key: int, val: string) =
  ## Add operation
  if self.loadFactor() > self.loadThres:
    self.extend()
  let index = self.findBucket(key)
  if self.buckets[index] != nil and self.buckets[index] != self.tombstone:
    self.buckets[index].val = val
    return

  self.buckets[index] = newPair(key, val)
  self.sizeVal += 1

proc remove*(self: HashMapOpenAddressing, key: int) =
  ## Delete operation
  let index = self.findBucket(key)
  if self.buckets[index] != nil and self.buckets[index] != self.tombstone:
    self.buckets[index] = self.tombstone
    self.sizeVal -= 1

proc print*(self: HashMapOpenAddressing) =
  ## Print hash map
  for pair in self.buckets:
    if pair == nil:
      echo "None"
    elif pair == self.tombstone:
      echo "TOMBSTONE"
    else:
      echo pair.key, " -> ", pair.val

## Driver Code
if isMainModule:
  # Initialize hash map
  let hashmap = newHashMapOpenAddressing()

  # Add operations
  hashmap.put(12836, "Xiao Ha")
  hashmap.put(15937, "Xiao Luo")
  hashmap.put(16750, "Xiao Suan")
  hashmap.put(13276, "Xiao Fa")
  hashmap.put(10583, "Xiao Ya")
  echo "\nAfter adding, hash map is\nKey -> Value"
  hashmap.print()

  # Query operation
  let name = hashmap.get(13276)
  echo "\nInput ID 13276, queried name: ", name

  # Delete operation
  hashmap.remove(16750)
  echo "\nAfter deleting 16750, hash map is\nKey -> Value"
  hashmap.print()
