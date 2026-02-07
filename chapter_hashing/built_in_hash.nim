# File: built_in_hash.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import std/hashes
import ../modules/list_node

## Driver Code
if isMainModule:
  let num = 3
  let hashNum = hash(num)
  echo "Hash value of integer ", num, " is ", hashNum

  let bol = true
  let hashBol = hash(bol)
  echo "Hash value of boolean ", bol, " is ", hashBol

  let dec = 3.14159
  let hashDec = hash(dec)
  echo "Hash value of float ", dec, " is ", hashDec

  let strVal = "Hello Algorithm"
  let hashStr = hash(strVal)
  echo "Hash value of string ", strVal, " is ", hashStr

  let tup = (12836, "Xiao Ha")
  let hashTup = hash(tup)
  echo "Hash value of tuple ", tup, " is ", hashTup

  let obj = newListNode(0)
  # In Nim, hashing a ref object usually hashes the reference (address)
  let hashObj = hash(cast[int](obj))
  echo "Hash value of node object with value ", obj.val, " is ", hashObj
