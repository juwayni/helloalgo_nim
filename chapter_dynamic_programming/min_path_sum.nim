# File: min_path_sum.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

proc minPathSumDfs(grid: seq[seq[int]], i: int, j: int): int =
  ## Min path sum: brute force
  # If top-left cell, terminate search
  if i == 0 and j == 0:
    return grid[0][0]
  # If index out of bounds, return infinity
  if i < 0 or j < 0:
    return int.high div 2 # Use large number as infinity
  # Calculate min path sum from top-left to (i-1, j) and (i, j-1)
  let up = minPathSumDfs(grid, i - 1, j)
  let left = minPathSumDfs(grid, i, j - 1)
  # Return min path sum to (i, j)
  return min(left, up) + grid[i][j]

proc minPathSumDfsMem(grid: seq[seq[int]], mem: var seq[seq[int]], i: int, j: int): int =
  ## Min path sum: memoized search
  if i == 0 and j == 0:
    return grid[0][0]
  if i < 0 or j < 0:
    return int.high div 2
  if mem[i][j] != -1:
    return mem[i][j]
  let up = minPathSumDfsMem(grid, mem, i - 1, j)
  let left = minPathSumDfsMem(grid, mem, i, j - 1)
  mem[i][j] = min(left, up) + grid[i][j]
  return mem[i][j]

proc minPathSumDp*(grid: seq[seq[int]]): int =
  ## Min path sum: dynamic programming
  let n = grid.len
  let m = grid[0].len
  # Initialize dp table
  var dp = newSeq[seq[int]](n)
  for i in 0 ..< n: dp[i] = newSeq[int](m)

  dp[0][0] = grid[0][0]
  # State transition: first row
  for j in 1 ..< m:
    dp[0][j] = dp[0][j - 1] + grid[0][j]
  # State transition: first column
  for i in 1 ..< n:
    dp[i][0] = dp[i - 1][0] + grid[i][0]
  # State transition: rest of cells
  for i in 1 ..< n:
    for j in 1 ..< m:
      dp[i][j] = min(dp[i][j - 1], dp[i - 1][j]) + grid[i][j]
  return dp[n - 1][m - 1]

proc minPathSumDpComp*(grid: seq[seq[int]]): int =
  ## Min path sum: space-optimized dynamic programming
  let n = grid.len
  let m = grid[0].len
  # Initialize dp array
  var dp = newSeq[int](m)
  # First row
  dp[0] = grid[0][0]
  for j in 1 ..< m:
    dp[j] = dp[j - 1] + grid[0][j]
  # Rest of rows
  for i in 1 ..< n:
    # First column
    dp[0] = dp[0] + grid[i][0]
    # Rest of columns
    for j in 1 ..< m:
      dp[j] = min(dp[j - 1], dp[j]) + grid[i][j]
  return dp[m - 1]

## Driver Code
if isMainModule:
  let grid = @[@[1, 3, 1, 5], @[2, 2, 4, 2], @[5, 3, 2, 1], @[4, 3, 5, 2]]
  let n = grid.len
  let m = grid[0].len

  # Brute force
  var res = minPathSumDfs(grid, n - 1, m - 1)
  echo "Min path sum (brute force) = ", res

  # Memoized search
  var mem = newSeq[seq[int]](n)
  for i in 0 ..< n:
    mem[i] = newSeq[int](m)
    for j in 0 ..< m: mem[i][j] = -1
  res = minPathSumDfsMem(grid, mem, n - 1, m - 1)
  echo "Min path sum (memoized) = ", res

  # Dynamic programming
  res = minPathSumDp(grid)
  echo "Min path sum (DP) = ", res

  # Space-optimized DP
  res = minPathSumDpComp(grid)
  echo "Min path sum (space-optimized DP) = ", res
