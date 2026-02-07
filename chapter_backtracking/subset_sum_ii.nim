# File: subset_sum_ii.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import std/algorithm

proc backtrack(state: var seq[int], target: int, choices: seq[int], start: int, res: var seq[seq[int]]) =
  ## Backtracking algorithm: subset sum II
  # If subset sum equals target, record the solution
  if target == 0:
    res.add(state)
    return
  # Traverse all choices
  # Pruning 2: start from 'start' to avoid generating duplicate subsets
  for i in start ..< choices.len:
    # Pruning 1: if subset sum exceeds target, stop the loop
    if target - choices[i] < 0:
      break
    # Pruning 4: if this element is same as previous one at the same level, skip to avoid duplicates
    if i > start and choices[i] == choices[i - 1]:
      continue
    # Try: make a choice, update target
    state.add(choices[i])
    # Proceed to next round of choices
    backtrack(state, target - choices[i], choices, i + 1, res)
    # Backtrack: undo choice, restore previous state
    discard state.pop()

proc subsetSumII*(nums: seq[int], target: int): seq[seq[int]] =
  ## Solve subset sum II
  var state: seq[int] = @[]
  var sortedNums = nums
  sortedNums.sort()
  var res: seq[seq[int]] = @[]
  backtrack(state, target, sortedNums, 0, res)
  return res

## Driver Code
if isMainModule:
  let nums = @[4, 4, 5]
  let target = 9
  let res = subsetSumII(nums, target)
  echo "Input array nums = ", nums, ", target = ", target
  echo "All subsets with sum equal to ", target, " res = ", res
