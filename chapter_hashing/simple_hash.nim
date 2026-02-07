# File: simple_hash.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

proc addHash*(key: string): int =
  ## Additive hash
  var h = 0
  let modulus = 1000000007
  for c in key:
    h += ord(c)
  return h mod modulus

proc mulHash*(key: string): int =
  ## Multiplicative hash
  var h: int64 = 0
  let modulus = 1000000007
  for c in key:
    h = (31 * h + ord(c).int64) mod modulus
  return h.int

proc xorHash*(key: string): int =
  ## XOR hash
  var h = 0
  let modulus = 1000000007
  for c in key:
    h = h xor ord(c)
  return h mod modulus

proc rotHash*(key: string): int =
  ## Rotational hash
  var h: uint32 = 0
  let modulus = 1000000007'u32
  for c in key:
    h = ((h shl 4) xor (h shr 28) xor ord(c).uint32) mod modulus
  return h.int

## Driver Code
if isMainModule:
  let key = "Hello Algorithm"

  var h = addHash(key)
  echo "Additive hash value = ", h

  h = mulHash(key)
  echo "Multiplicative hash value = ", h

  h = xorHash(key)
  echo "XOR hash value = ", h

  h = rotHash(key)
  echo "Rotational hash value = ", h
