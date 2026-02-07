# File: unbounded_knapsack.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

proc unboundedKnapsackDp*(wgt: seq[int], val: seq[int], cap: int): int =
  ## Unbounded Knapsack: dynamic programming
  let n = wgt.len
  var dp = newSeq[seq[int]](n + 1)
  for i in 0 .. n: dp[i] = newSeq[int](cap + 1)

  for i in 1 .. n:
    for c in 1 .. cap:
      if wgt[i - 1] > c:
        dp[i][c] = dp[i - 1][c]
      else:
        dp[i][c] = max(dp[i - 1][c], dp[i][c - wgt[i - 1]] + val[i - 1])
  return dp[n][cap]

proc unboundedKnapsackDpComp*(wgt: seq[int], val: seq[int], cap: int): int =
  ## Unbounded Knapsack: space-optimized dynamic programming
  let n = wgt.len
  var dp = newSeq[int](cap + 1)
  for i in 1 .. n:
    for c in 1 .. cap:
      if wgt[i - 1] <= c:
        dp[c] = max(dp[c], dp[c - wgt[i - 1]] + val[i - 1])
  return dp[cap]

## Driver Code
if isMainModule:
  let wgt = @[1, 2, 3]
  let val = @[5, 11, 15]
  let cap = 4

  # Dynamic programming
  var res = unboundedKnapsackDp(wgt, val, cap)
  echo "Max value = ", res

  # Space-optimized DP
  res = unboundedKnapsackDpComp(wgt, val, cap)
  echo "Max value = ", res
