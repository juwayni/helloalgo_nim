# File: climbing_stairs_dfs.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

proc dfs(i: int): int =
  ## Search
  # Known base cases dp[1] and dp[2]
  if i == 1 or i == 2:
    return i
  # dp[i] = dp[i-1] + dp[i-2]
  return dfs(i - 1) + dfs(i - 2)

proc climbingStairsDfs*(n: int): int =
  ## Climbing stairs: search
  return dfs(n)

## Driver Code
if isMainModule:
  let n = 9
  let res = climbingStairsDfs(n)
  echo "Climbing ", n, " stairs has ", res, " solutions"
