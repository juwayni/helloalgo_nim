# File: climbing_stairs_backtrack.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

proc backtrack(choices: seq[int], state: int, n: int, res: var int) =
  ## Backtracking
  # When reaching the n-th stair, increment solution count
  if state == n:
    res += 1
  # Traverse all choices
  for choice in choices:
    # Pruning: do not allow overshooting the n-th stair
    if state + choice > n:
      continue
    # Try: make a choice, update state
    backtrack(choices, state + choice, n, res)
    # Backtrack

proc climbingStairsBacktrack*(n: int): int =
  ## Climbing stairs: backtracking
  let choices = @[1, 2] # Choices: climb 1 or 2 stairs
  var res = 0 # Solution count
  backtrack(choices, 0, n, res)
  return res

## Driver Code
if isMainModule:
  let n = 9
  let res = climbingStairsBacktrack(n)
  echo "Climbing ", n, " stairs has ", res, " solutions"
