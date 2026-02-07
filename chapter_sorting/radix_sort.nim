# File: radix_sort.nim
# Created Time : 2026-02-07
# Author : Ghazali (ghazalialshafi@gmail.com)

proc digit(num: int, exp: int): int =
  ## Get the k-th digit of num, where exp = 10^(k-1)
  (num div exp) mod 10

proc countingSortDigit(nums: var seq[int], exp: int) =
  ## Counting sort (sort based on the k-th digit)
  # Decimal digits range is 0-9, so we need a counter array of length 10
  var counter = newSeq[int](10)
  let n = nums.len
  # Count occurrences of each digit 0-9
  for i in 0 ..< n:
    let d = digit(nums[i], exp) # Get the k-th digit
    counter[d] += 1
  # Calculate prefix sums to convert counts to indices
  for i in 1 ..< 10:
    counter[i] += counter[i - 1]
  # Fill results into res by traversing nums in reverse
  var res = newSeq[int](n)
  for i in countdown(n - 1, 0):
    let d = digit(nums[i], exp)
    let j = counter[d] - 1
    res[j] = nums[i]
    counter[d] -= 1
  # Update original array
  for i in 0 ..< n:
    nums[i] = res[i]

proc radixSort*(nums: var seq[int]) =
  ## Radix sort
  if nums.len == 0: return
  # Find the maximum element to determine the number of digits
  var m = nums[0]
  for num in nums:
    if num > m: m = num
  # Iterate from least significant digit to most significant digit
  var exp = 1
  while exp <= m:
    # Perform counting sort based on the k-th digit
    countingSortDigit(nums, exp)
    exp *= 10

## Driver Code
if isMainModule:
  var nums = @[
    10546151,
    35663510,
    42865989,
    34862445,
    81883077,
    88906420,
    72429244,
    30524779,
    82060337,
    63832996,
  ]
  radixSort(nums)
  echo "After radix sort, nums = ", nums
