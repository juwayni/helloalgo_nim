# File: permutations_ii.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import std/sets

proc backtrack(state: var seq[int], choices: seq[int], selected: var seq[bool], res: var seq[seq[int]]) =
  ## Backtracking algorithm: permutations II
  # When state length equals number of choices, record the solution
  if state.len == choices.len:
    res.add(state)
    return
  # Traverse all choices
  var duplicated = initHashSet[int]()
  for i in 0 ..< choices.len:
    let choice = choices[i]
    # Pruning: do not allow duplicate choice of same index AND do not allow duplicate choice of same value at this level
    if not selected[i] and not duplicated.contains(choice):
      # Try: make a choice, update state
      duplicated.incl(choice) # Record value chosen at this level
      selected[i] = true
      state.add(choice)
      # Proceed to next round of choices
      backtrack(state, choices, selected, res)
      # Backtrack: undo choice, restore previous state
      selected[i] = false
      discard state.pop()

proc permutationsII*(nums: seq[int]): seq[seq[int]] =
  ## Permutations II
  var res: seq[seq[int]] = @[]
  var state: seq[int] = @[]
  var selected = newSeq[bool](nums.len)
  backtrack(state, nums, selected, res)
  return res

## Driver Code
if isMainModule:
  let nums = @[1, 2, 2]
  let res = permutationsII(nums)
  echo "Input array nums = ", nums
  echo "All permutations res = ", res
