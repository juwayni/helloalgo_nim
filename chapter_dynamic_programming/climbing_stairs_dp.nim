# File: climbing_stairs_dp.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

proc climbingStairsDp*(n: int): int =
  ## Climbing stairs: dynamic programming
  if n == 1 or n == 2:
    return n
  # Initialize dp table
  var dp = newSeq[int](n + 1)
  # Base cases
  dp[1] = 1
  dp[2] = 2
  # State transitions
  for i in 3 .. n:
    dp[i] = dp[i - 1] + dp[i - 2]
  return dp[n]

proc climbingStairsDpComp*(n: int): int =
  ## Climbing stairs: dynamic programming with space optimization
  if n == 1 or n == 2:
    return n
  var a = 1
  var b = 2
  for _ in 3 .. n:
    let temp = b
    b = a + b
    a = temp
  return b

## Driver Code
if isMainModule:
  let n = 9
  var res = climbingStairsDp(n)
  echo "Climbing ", n, " stairs has ", res, " solutions"

  res = climbingStairsDpComp(n)
  echo "Climbing ", n, " stairs has ", res, " solutions"
