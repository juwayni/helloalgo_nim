# File: subset_sum_i.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import std/algorithm

proc backtrack(state: var seq[int], target: int, choices: seq[int], start: int, res: var seq[seq[int]]) =
  ## Backtracking algorithm: subset sum I
  # If subset sum equals target, record the solution
  if target == 0:
    res.add(state)
    return
  # Traverse all choices
  # Pruning 2: start from 'start' to avoid generating duplicate subsets
  for i in start ..< choices.len:
    # Pruning 1: if subset sum exceeds target, stop the loop
    # Since choices are sorted, the subsequent elements are larger
    if target - choices[i] < 0:
      break
    # Try: make a choice, update target
    state.add(choices[i])
    # Proceed to next round of choices
    backtrack(state, target - choices[i], choices, i, res)
    # Backtrack: undo choice, restore previous state
    discard state.pop()

proc subsetSumI*(nums: seq[int], target: int): seq[seq[int]] =
  ## Solve subset sum I
  var state: seq[int] = @[]
  var sortedNums = nums
  sortedNums.sort() # Sort nums
  var res: seq[seq[int]] = @[]
  backtrack(state, target, sortedNums, 0, res)
  return res

## Driver Code
if isMainModule:
  let nums = @[3, 4, 5]
  let target = 9
  let res = subsetSumI(nums, target)
  echo "Input array nums = ", nums, ", target = ", target
  echo "All subsets with sum equal to ", target, " res = ", res
