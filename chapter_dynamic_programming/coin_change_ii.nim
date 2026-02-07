# File: coin_change_ii.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

proc coinChangeIIDp*(coins: seq[int], amt: int): int =
  ## Coin change II: dynamic programming
  let n = coins.len
  # Initialize dp table
  var dp = newSeq[seq[int]](n + 1)
  for i in 0 .. n: dp[i] = newSeq[int](amt + 1)

  # Initialize first column
  for i in 0 .. n:
    dp[i][0] = 1

  # State transition
  for i in 1 .. n:
    for a in 1 .. amt:
      if coins[i - 1] > a:
        dp[i][a] = dp[i - 1][a]
      else:
        dp[i][a] = dp[i - 1][a] + dp[i][a - coins[i - 1]]

  return dp[n][amt]

proc coinChangeIIDpComp*(coins: seq[int], amt: int): int =
  ## Coin change II: space-optimized dynamic programming
  let n = coins.len
  var dp = newSeq[int](amt + 1)
  dp[0] = 1

  for i in 1 .. n:
    for a in 1 .. amt:
      if coins[i - 1] <= a:
        dp[a] = dp[a] + dp[a - coins[i - 1]]

  return dp[amt]

## Driver Code
if isMainModule:
  let coins = @[1, 2, 5]
  let amt = 5

  # Dynamic programming
  var res = coinChangeIIDp(coins, amt)
  echo "Number of combinations = ", res

  # Space-optimized DP
  res = coinChangeIIDpComp(coins, amt)
  echo "Number of combinations = ", res
