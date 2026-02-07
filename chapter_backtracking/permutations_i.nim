# File: permutations_i.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

proc backtrack(state: var seq[int], choices: seq[int], selected: var seq[bool], res: var seq[seq[int]]) =
  ## Backtracking algorithm: permutations I
  # When state length equals number of choices, record the solution
  if state.len == choices.len:
    res.add(state)
    return
  # Traverse all choices
  for i in 0 ..< choices.len:
    let choice = choices[i]
    # Pruning: do not allow duplicate choice of same element
    if not selected[i]:
      # Try: make a choice, update state
      selected[i] = true
      state.add(choice)
      # Proceed to next round of choices
      backtrack(state, choices, selected, res)
      # Backtrack: undo choice, restore previous state
      selected[i] = false
      discard state.pop()

proc permutationsI*(nums: seq[int]): seq[seq[int]] =
  ## Permutations I
  var res: seq[seq[int]] = @[]
  var state: seq[int] = @[]
  var selected = newSeq[bool](nums.len)
  backtrack(state, nums, selected, res)
  return res

## Driver Code
if isMainModule:
  let nums = @[1, 2, 3]
  let res = permutationsI(nums)
  echo "Input array nums = ", nums
  echo "All permutations res = ", res
