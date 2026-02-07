# File: preorder_traversal_iii_template.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

import std/options
import ../modules/tree_node
import ../modules/print_util

proc isSolution(state: seq[TreeNode]): bool =
  ## Check if current state is a solution
  state.len > 0 and state[^1].val == 7

proc recordSolution(state: seq[TreeNode], res: var seq[seq[TreeNode]]) =
  ## Record solution
  res.add(state)

proc isValid(state: seq[TreeNode], choice: TreeNode): bool =
  ## Check if choice is valid in current state
  choice != nil and choice.val != 3

proc makeChoice(state: var seq[TreeNode], choice: TreeNode) =
  ## Update state
  state.add(choice)

proc undoChoice(state: var seq[TreeNode], choice: TreeNode) =
  ## Restore state
  discard state.pop()

proc backtrack(state: var seq[TreeNode], choices: seq[TreeNode], res: var seq[seq[TreeNode]]) =
  ## Backtracking algorithm: Example 3
  # Check if solution
  if isSolution(state):
    recordSolution(state, res)
  # Traverse all choices
  for choice in choices:
    # Pruning: check if choice is valid
    if isValid(state, choice):
      # Try: make a choice, update state
      makeChoice(state, choice)
      # Proceed to next round of choices
      backtrack(state, @[choice.left, choice.right], res)
      # Backtrack: undo choice, restore previous state
      undoChoice(state, choice)

## Driver Code
if isMainModule:
  let root = listToTree(@[some(1), some(7), some(3), some(4), some(5), some(6), some(7)])
  echo "\nInitialized binary tree"
  printTree(root)

  # Backtracking
  var res: seq[seq[TreeNode]] = @[]
  var state: seq[TreeNode] = @[]
  backtrack(state, @[root], res)

  echo "\nOutput all paths from root to nodes with value 7, excluding nodes with value 3"
  for p in res:
    var vals: seq[int] = @[]
    for node in p:
      vals.add(node.val)
    echo vals
