# File: recursion.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

proc recur*(n: int): int =
  ## Recursion
  # Termination condition
  if n == 1:
    return 1
  # Recur: recursive call
  let res = recur(n - 1)
  # Return: return result
  return n + res

proc forLoopRecur*(n: int): int =
  ## Use iteration to simulate recursion
  # Use an explicit stack to simulate the system call stack
  var stack: seq[int] = @[]
  var res = 0
  # Recur: push to stack
  for i in countdown(n, 1):
    stack.add(i)
  # Return: pop from stack and accumulate
  while stack.len > 0:
    res += stack.pop()
  # res = 1+2+3+...+n
  return res

proc tailRecur*(n: int, res: int): int =
  ## Tail recursion
  # Termination condition
  if n == 0:
    return res
  # Tail recursive call
  return tailRecur(n - 1, res + n)

proc fib*(n: int): int =
  ## Fibonacci sequence: recursion
  # Termination condition f(1) = 0, f(2) = 1
  if n == 1 or n == 2:
    return n - 1
  # Recursive call f(n) = f(n-1) + f(n-2)
  return fib(n - 1) + fib(n - 2)

## Driver Code
if isMainModule:
  let n = 5
  var res = recur(n)
  echo "\nSum from recursion: res = ", res

  res = forLoopRecur(n)
  echo "\nSum from iteration simulating recursion: res = ", res

  res = tailRecur(n, 0)
  echo "\nSum from tail recursion: res = ", res

  res = fib(n)
  echo "\nFibonacci number at index ", n, " is ", res
