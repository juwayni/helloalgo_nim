# File: climbing_stairs_dfs_mem.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

proc dfs(i: int, mem: var seq[int]): int =
  ## Memoized search
  # Known base cases dp[1] and dp[2]
  if i == 1 or i == 2:
    return i
  # If record dp[i] exists, return it directly
  if mem[i] != -1:
    return mem[i]
  # dp[i] = dp[i-1] + dp[i-2]
  let count = dfs(i - 1, mem) + dfs(i - 2, mem)
  # Record dp[i]
  mem[i] = count
  return count

proc climbingStairsDfsMem*(n: int): int =
  ## Climbing stairs: memoized search
  # mem[i] records the number of ways to reach the i-th stair, -1 means no record
  var mem = newSeq[int](n + 1)
  for i in 0 .. n: mem[i] = -1
  return dfs(n, mem)

## Driver Code
if isMainModule:
  let n = 9
  let res = climbingStairsDfsMem(n)
  echo "Climbing ", n, " stairs has ", res, " solutions"
