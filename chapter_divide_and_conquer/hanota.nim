# File: hanota.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

proc move(src: var seq[int], tar: var seq[int]) =
  ## Move one disk
  # Take out a disk from the top of src
  let pan = src.pop()
  # Place the disk on the top of tar
  tar.add(pan)

proc dfs(i: int, src: var seq[int], buf: var seq[int], tar: var seq[int]) =
  ## Solve Hanoi Tower problem f(i)
  # If src has only one disk left, move it directly to tar
  if i == 1:
    move(src, tar)
    return
  # Sub-problem f(i-1): move the top i-1 disks from src to buf via tar
  dfs(i - 1, src, tar, buf)
  # Sub-problem f(1): move the remaining disk from src to tar
  move(src, tar)
  # Sub-problem f(i-1): move the top i-1 disks from buf to tar via src
  dfs(i - 1, buf, src, tar)

proc solveHanota*(A: var seq[int], B: var seq[int], C: var seq[int]) =
  ## Solve Hanoi Tower problem
  let n = A.len
  # Move n disks from A to C via B
  dfs(n, A, B, C)

## Driver Code
if isMainModule:
  # The end of the list is the top of the pillar
  var A = @[5, 4, 3, 2, 1]
  var B: seq[int] = @[]
  var C: seq[int] = @[]
  echo "Initial state:"
  echo "A = ", A
  echo "B = ", B
  echo "C = ", C

  solveHanota(A, B, C)

  echo "After moving disks:"
  echo "A = ", A
  echo "B = ", B
  echo "C = ", C
