# File: time_complexity.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

proc constant*(n: int): int =
  ## Constant time O(1)
  var count = 0
  let size = 100000
  for _ in 0 ..< size:
    count += 1
  return count

proc linear*(n: int): int =
  ## Linear time O(n)
  var count = 0
  for _ in 0 ..< n:
    count += 1
  return count

proc arrayTraversal*(nums: seq[int]): int =
  ## Linear time O(n) (traversing array)
  var count = 0
  for num in nums:
    count += 1
  return count

proc quadratic*(n: int): int =
  ## Quadratic time O(n^2)
  var count = 0
  for i in 0 ..< n:
    for j in 0 ..< n:
      count += 1
  return count

proc bubbleSort*(nums: var seq[int]): int =
  ## Quadratic time O(n^2) (bubble sort)
  var count = 0
  for i in countdown(nums.len - 1, 1):
    for j in 0 ..< i:
      if nums[j] > nums[j + 1]:
        let tmp = nums[j]
        nums[j] = nums[j + 1]
        nums[j + 1] = tmp
        count += 3 # Swap contains 3 elementary operations
  return count

proc exponential*(n: int): int =
  ## Exponential time O(2^n) (iterative)
  var count = 0
  var base = 1
  for _ in 0 ..< n:
    for _ in 0 ..< base:
      count += 1
    base *= 2
  return count

proc expRecur*(n: int): int =
  ## Exponential time O(2^n) (recursive)
  if n == 1:
    return 1
  return expRecur(n - 1) + expRecur(n - 1) + 1

proc logarithmic*(n: float): int =
  ## Logarithmic time O(log n) (iterative)
  var count = 0
  var currN = n
  while currN > 1:
    currN = currN / 2
    count += 1
  return count

proc logRecur*(n: float): int =
  ## Logarithmic time O(log n) (recursive)
  if n <= 1:
    return 0
  return logRecur(n / 2) + 1

proc linearLogRecur*(n: int): int =
  ## Linear-logarithmic time O(n log n)
  if n <= 1:
    return 1
  var count = linearLogRecur(n div 2) + linearLogRecur(n div 2)
  for _ in 0 ..< n:
    count += 1
  return count

proc factorialRecur*(n: int): int =
  ## Factorial time O(n!) (recursive)
  if n == 0:
    return 1
  var count = 0
  for _ in 0 ..< n:
    count += factorialRecur(n - 1)
  return count

## Driver Code
if isMainModule:
  let n = 8
  echo "Input size n = ", n

  var count = constant(n)
  echo "Constant time O(1) ops = ", count

  count = linear(n)
  echo "Linear time O(n) ops = ", count
  count = arrayTraversal(newSeq[int](n))
  echo "Linear time O(n) (traversal) ops = ", count

  count = quadratic(n)
  echo "Quadratic time O(n^2) ops = ", count
  var nums: seq[int] = @[]
  for i in countdown(n, 1): nums.add(i)
  count = bubbleSort(nums)
  echo "Quadratic time O(n^2) (bubble sort) ops = ", count

  count = exponential(n)
  echo "Exponential time O(2^n) (iterative) ops = ", count
  count = expRecur(n)
  echo "Exponential time O(2^n) (recursive) ops = ", count

  count = logarithmic(n.float)
  echo "Logarithmic time O(log n) (iterative) ops = ", count
  count = logRecur(n.float)
  echo "Logarithmic time O(log n) (recursive) ops = ", count

  count = linearLogRecur(n)
  echo "Linear-logarithmic time O(n log n) ops = ", count

  count = factorialRecur(n)
  echo "Factorial time O(n!) ops = ", count
