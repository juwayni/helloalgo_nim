# File: subset_sum_i_naive.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

proc backtrack(state: var seq[int], target: int, total: int, choices: seq[int], res: var seq[seq[int]]) =
  ## Backtracking algorithm: subset sum I
  # If subset sum equals target, record the solution
  if total == target:
    res.add(state)
    return
  # Traverse all choices
  for i in 0 ..< choices.len:
    # Pruning: if subset sum exceeds target, skip this choice
    if total + choices[i] > target:
      continue
    # Try: make a choice, update total
    state.add(choices[i])
    # Proceed to next round of choices
    backtrack(state, target, total + choices[i], choices, res)
    # Backtrack: undo choice, restore previous state
    discard state.pop()

proc subsetSumINaive*(nums: seq[int], target: int): seq[seq[int]] =
  ## Solve subset sum I (contains duplicate subsets)
  var state: seq[int] = @[]
  var res: seq[seq[int]] = @[]
  backtrack(state, target, 0, nums, res)
  return res

## Driver Code
if isMainModule:
  let nums = @[3, 4, 5]
  let target = 9
  let res = subsetSumINaive(nums, target)
  echo "Input array nums = ", nums, ", target = ", target
  echo "All subsets with sum equal to ", target, " res = ", res
  echo "Note: this method outputs results including duplicate sets"
