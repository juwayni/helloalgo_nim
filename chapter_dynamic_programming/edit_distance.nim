# File: edit_distance.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

proc editDistanceDfs(s: string, t: string, i: int, j: int): int =
  ## Edit distance: brute force
  # If both strings are empty, return 0
  if i == 0 and j == 0:
    return 0
  # If s is empty, return length of t
  if i == 0:
    return j
  # If t is empty, return length of s
  if j == 0:
    return i
  # If characters are equal, skip them
  if s[i - 1] == t[j - 1]:
    return editDistanceDfs(s, t, i - 1, j - 1)
  # Minimum edit steps = min(insert, delete, replace) + 1
  let insertOp = editDistanceDfs(s, t, i, j - 1)
  let deleteOp = editDistanceDfs(s, t, i - 1, j)
  let replaceOp = editDistanceDfs(s, t, i - 1, j - 1)
  return min(min(insertOp, deleteOp), replaceOp) + 1

proc editDistanceDfsMem(s: string, t: string, mem: var seq[seq[int]], i: int, j: int): int =
  ## Edit distance: memoized search
  if i == 0 and j == 0:
    return 0
  if i == 0:
    return j
  if j == 0:
    return i
  if mem[i][j] != -1:
    return mem[i][j]
  if s[i - 1] == t[j - 1]:
    return editDistanceDfsMem(s, t, mem, i - 1, j - 1)
  let insertOp = editDistanceDfsMem(s, t, mem, i, j - 1)
  let deleteOp = editDistanceDfsMem(s, t, mem, i - 1, j)
  let replaceOp = editDistanceDfsMem(s, t, mem, i - 1, j - 1)
  mem[i][j] = min(min(insertOp, deleteOp), replaceOp) + 1
  return mem[i][j]

proc editDistanceDp*(s: string, t: string): int =
  ## Edit distance: dynamic programming
  let n = s.len
  let m = t.len
  var dp = newSeq[seq[int]](n + 1)
  for i in 0 .. n: dp[i] = newSeq[int](m + 1)

  # Base cases: first row and column
  for i in 1 .. n:
    dp[i][0] = i
  for j in 1 .. m:
    dp[0][j] = j

  # State transition
  for i in 1 .. n:
    for j in 1 .. m:
      if s[i - 1] == t[j - 1]:
        dp[i][j] = dp[i - 1][j - 1]
      else:
        dp[i][j] = min(min(dp[i][j - 1], dp[i - 1][j]), dp[i - 1][j - 1]) + 1
  return dp[n][m]

proc editDistanceDpComp*(s: string, t: string): int =
  ## Edit distance: space-optimized dynamic programming
  let n = s.len
  let m = t.len
  var dp = newSeq[int](m + 1)
  for j in 0 .. m:
    dp[j] = j

  for i in 1 .. n:
    var leftup = dp[0] # Store dp[i-1][j-1]
    dp[0] += 1
    for j in 1 .. m:
      let temp = dp[j]
      if s[i - 1] == t[j - 1]:
        dp[j] = leftup
      else:
        dp[j] = min(min(dp[j - 1], dp[j]), leftup) + 1
      leftup = temp
  return dp[m]

## Driver Code
if isMainModule:
  let s = "bag"
  let t = "pack"
  let n = s.len
  let m = t.len

  # Brute force
  var res = editDistanceDfs(s, t, n, m)
  echo "Steps from ", s, " to ", t, " (brute force) = ", res

  # Memoized search
  var mem = newSeq[seq[int]](n + 1)
  for i in 0 .. n:
    mem[i] = newSeq[int](m + 1)
    for j in 0 .. m: mem[i][j] = -1
  res = editDistanceDfsMem(s, t, mem, n, m)
  echo "Steps from ", s, " to ", t, " (memoized) = ", res

  # Dynamic programming
  res = editDistanceDp(s, t)
  echo "Steps from ", s, " to ", t, " (DP) = ", res

  # Space-optimized DP
  res = editDistanceDpComp(s, t)
  echo "Steps from ", s, " to ", t, " (space-optimized DP) = ", res
