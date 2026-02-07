# File: climbing_stairs_constraint_dp.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

proc climbingStairsConstraintDp*(n: int): int =
  ## Climbing stairs with constraints: dynamic programming
  if n == 1 or n == 2:
    return 1
  # Initialize dp table, dp[i][j] represents number of ways to reach i-th stair with last step being j stairs
  var dp = newSeq[seq[int]](n + 1)
  for i in 0 .. n:
    dp[i] = newSeq[int](3)

  # Base cases
  dp[1][1] = 1
  dp[1][2] = 0
  dp[2][1] = 0
  dp[2][2] = 1

  # State transitions
  for i in 3 .. n:
    dp[i][1] = dp[i - 1][2]
    dp[i][2] = dp[i - 2][1] + dp[i - 2][2]

  return dp[n][1] + dp[n][2]

## Driver Code
if isMainModule:
  let n = 9
  let res = climbingStairsConstraintDp(n)
  echo "Climbing ", n, " stairs with constraints has ", res, " solutions"
