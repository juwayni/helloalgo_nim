# File: coin_change.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

proc coinChangeDp*(coins: seq[int], amt: int): int =
  ## Coin change: dynamic programming
  let n = coins.len
  let maxVal = amt + 1
  # Initialize dp table
  var dp = newSeq[seq[int]](n + 1)
  for i in 0 .. n: dp[i] = newSeq[int](amt + 1)

  # State transition: first row (except dp[0][0])
  for a in 1 .. amt:
    dp[0][a] = maxVal

  # State transition: rest of the table
  for i in 1 .. n:
    for a in 1 .. amt:
      if coins[i - 1] > a:
        dp[i][a] = dp[i - 1][a]
      else:
        dp[i][a] = min(dp[i - 1][a], dp[i][a - coins[i - 1]] + 1)

  return if dp[n][amt] != maxVal: dp[n][amt] else: -1

proc coinChangeDpComp*(coins: seq[int], amt: int): int =
  ## Coin change: space-optimized dynamic programming
  let n = coins.len
  let maxVal = amt + 1
  # Initialize dp table
  var dp = newSeq[int](amt + 1)
  for a in 1 .. amt: dp[a] = maxVal
  dp[0] = 0

  # State transition
  for i in 1 .. n:
    for a in 1 .. amt:
      if coins[i - 1] <= a:
        dp[a] = min(dp[a], dp[a - coins[i - 1]] + 1)

  return if dp[amt] != maxVal: dp[amt] else: -1

## Driver Code
if isMainModule:
  let coins = @[1, 2, 5]
  let amt = 4

  # Dynamic programming
  var res = coinChangeDp(coins, amt)
  echo "Min number of coins = ", res

  # Space-optimized DP
  res = coinChangeDpComp(coins, amt)
  echo "Min number of coins = ", res
