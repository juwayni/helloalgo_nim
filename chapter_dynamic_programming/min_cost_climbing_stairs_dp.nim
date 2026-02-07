# File: min_cost_climbing_stairs_dp.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

proc minCostClimbingStairsDp*(cost: seq[int]): int =
  ## Min cost climbing stairs: dynamic programming
  let n = cost.len - 1
  if n == 1 or n == 2:
    return cost[n]
  # Initialize dp table
  var dp = newSeq[int](n + 1)
  # Base cases
  dp[1] = cost[1]
  dp[2] = cost[2]
  # State transitions
  for i in 3 .. n:
    dp[i] = min(dp[i - 1], dp[i - 2]) + cost[i]
  return dp[n]

proc minCostClimbingStairsDpComp*(cost: seq[int]): int =
  ## Min cost climbing stairs: dynamic programming with space optimization
  let n = cost.len - 1
  if n == 1 or n == 2:
    return cost[n]
  var a = cost[1]
  var b = cost[2]
  for i in 3 .. n:
    let temp = b
    b = min(a, b) + cost[i]
    a = temp
  return b

## Driver Code
if isMainModule:
  let cost = @[0, 1, 10, 1, 1, 1, 10, 1, 1, 10, 1]
  echo "Input cost list = ", cost

  var res = minCostClimbingStairsDp(cost)
  echo "Min cost = ", res

  res = minCostClimbingStairsDpComp(cost)
  echo "Min cost = ", res
