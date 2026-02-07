# File: knapsack.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

proc knapsackDfs(wgt: seq[int], val: seq[int], i: int, c: int): int =
  ## 0-1 Knapsack: brute force
  if i == 0 or c == 0:
    return 0
  if wgt[i - 1] > c:
    return knapsackDfs(wgt, val, i - 1, c)
  let no = knapsackDfs(wgt, val, i - 1, c)
  let yes = knapsackDfs(wgt, val, i - 1, c - wgt[i - 1]) + val[i - 1]
  return max(no, yes)

proc knapsackDfsMem(wgt: seq[int], val: seq[int], mem: var seq[seq[int]], i: int, c: int): int =
  ## 0-1 Knapsack: memoized search
  if i == 0 or c == 0:
    return 0
  if mem[i][c] != -1:
    return mem[i][c]
  if wgt[i - 1] > c:
    return knapsackDfsMem(wgt, val, mem, i - 1, c)
  let no = knapsackDfsMem(wgt, val, mem, i - 1, c)
  let yes = knapsackDfsMem(wgt, val, mem, i - 1, c - wgt[i - 1]) + val[i - 1]
  mem[i][c] = max(no, yes)
  return mem[i][c]

proc knapsackDp*(wgt: seq[int], val: seq[int], cap: int): int =
  ## 0-1 Knapsack: dynamic programming
  let n = wgt.len
  var dp = newSeq[seq[int]](n + 1)
  for i in 0 .. n: dp[i] = newSeq[int](cap + 1)

  for i in 1 .. n:
    for c in 1 .. cap:
      if wgt[i - 1] > c:
        dp[i][c] = dp[i - 1][c]
      else:
        dp[i][c] = max(dp[i - 1][c], dp[i - 1][c - wgt[i - 1]] + val[i - 1])
  return dp[n][cap]

proc knapsackDpComp*(wgt: seq[int], val: seq[int], cap: int): int =
  ## 0-1 Knapsack: space-optimized dynamic programming
  let n = wgt.len
  var dp = newSeq[int](cap + 1)
  for i in 1 .. n:
    for c in countdown(cap, 1):
      if wgt[i - 1] <= c:
        dp[c] = max(dp[c], dp[c - wgt[i - 1]] + val[i - 1])
  return dp[cap]

## Driver Code
if isMainModule:
  let wgt = @[10, 20, 30, 40, 50]
  let val = @[50, 120, 150, 210, 240]
  let cap = 50
  let n = wgt.len

  # Brute force
  var res = knapsackDfs(wgt, val, n, cap)
  echo "Max value (brute force) = ", res

  # Memoized search
  var mem = newSeq[seq[int]](n + 1)
  for i in 0 .. n:
    mem[i] = newSeq[int](cap + 1)
    for c in 0 .. cap: mem[i][c] = -1
  res = knapsackDfsMem(wgt, val, mem, n, cap)
  echo "Max value (memoized) = ", res

  # Dynamic programming
  res = knapsackDp(wgt, val, cap)
  echo "Max value (DP) = ", res

  # Space-optimized DP
  res = knapsackDpComp(wgt, val, cap)
  echo "Max value (space-optimized DP) = ", res
