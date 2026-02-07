# File: n_queens.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

proc backtrack(
    row: int,
    n: int,
    state: var seq[seq[string]],
    res: var seq[seq[seq[string]]],
    cols: var seq[bool],
    diags1: var seq[bool],
    diags2: var seq[bool]
) =
  ## Backtracking algorithm: n-queens
  # When all rows are placed, record the solution
  if row == n:
    res.add(state)
    return
  # Traverse all columns
  for col in 0 ..< n:
    # Calculate corresponding diagonals
    let diag1 = row - col + n - 1
    let diag2 = row + col
    # Pruning: ensure no queen in current column or diagonals
    if not cols[col] and not diags1[diag1] and not diags2[diag2]:
      # Try: place queen
      state[row][col] = "Q"
      cols[col] = true
      diags1[diag1] = true
      diags2[diag2] = true
      # Place next row
      backtrack(row + 1, n, state, res, cols, diags1, diags2)
      # Backtrack: remove queen
      state[row][col] = "#"
      cols[col] = false
      diags1[diag1] = false
      diags2[diag2] = false

proc nQueens*(n: int): seq[seq[seq[string]]] =
  ## Solve n-queens
  # Initialize board
  var state = newSeq[seq[string]](n)
  for i in 0 ..< n:
    state[i] = newSeq[string](n)
    for j in 0 ..< n:
      state[i][j] = "#"

  var cols = newSeq[bool](n)
  var diags1 = newSeq[bool](2 * n - 1)
  var diags2 = newSeq[bool](2 * n - 1)
  var res: seq[seq[seq[string]]] = @[]
  backtrack(0, n, state, res, cols, diags1, diags2)
  return res

## Driver Code
if isMainModule:
  let n = 4
  let res = nQueens(n)
  echo "Input board size = ", n
  echo "Number of solutions = ", res.len
  for state in res:
    echo "--------------------"
    for row in state:
      echo row
