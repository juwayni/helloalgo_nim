# File: coin_change_greedy.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

proc coinChangeGreedy*(coins: seq[int], amt: int): int =
  ## Coin change: greedy
  # Assume coins are sorted
  var i = coins.len - 1
  var count = 0
  var currentAmt = amt
  # Iteratively make greedy choices until no amount left
  while currentAmt > 0:
    # Find the largest coin less than or equal to current amount
    while i > 0 and coins[i] > currentAmt:
      i -= 1
    # Choose coins[i]
    currentAmt -= coins[i]
    count += 1
  # Return count if amount is exactly zero, else -1
  return if currentAmt == 0: count else: -1

## Driver Code
if isMainModule:
  # Greedy: guaranteed optimal solution
  var coins = @[1, 5, 10, 20, 50, 100]
  var amt = 186
  var res = coinChangeGreedy(coins, amt)
  echo "\ncoins = ", coins, ", amt = ", amt
  echo "Min number of coins needed = ", res

  # Greedy: not guaranteed optimal solution
  coins = @[1, 20, 50]
  amt = 60
  res = coinChangeGreedy(coins, amt)
  echo "\ncoins = ", coins, ", amt = ", amt
  echo "Min number of coins needed = ", res
  echo "Actual min number is 3 (20 + 20 + 20)"

  # Greedy: not guaranteed optimal solution
  coins = @[1, 49, 50]
  amt = 98
  res = coinChangeGreedy(coins, amt)
  echo "\ncoins = ", coins, ", amt = ", amt
  echo "Min number of coins needed = ", res
  echo "Actual min number is 2 (49 + 49)"
