# Iterative

def fib_iterative(n)
  a = 0
  b = 1
  n.times do
    temp = a
    a = b
    b = temp + b
  end
  a
end
# p fib_iterative(10) === 55

# Recursive

def fib_recursive(n)
  return n if n <= 1
  return fib_recursive(n-1) + fib_recursive(n-2)
end
# p fib_recursive(10) === 55

# Memoization

@memo = [0,1]

def fib_memoization(n)
  return @memo[n] if @memo[n]
  @memo[n] = fib_memoization(n-1) + fib_memoization(n-2)
end

# p defined?( @memo ) === "instance-variable"
# p fib_memoization(7) === 13
# p fib_memoization(10) === 55
# p fib_memoization(100) === 354224848179261915075
# p fib_memoization(1000) === 43466557686937456435688527675040625802564660517371780402481729089536555417949051890403879840079255169295922593080322634775209689623239873322471161642996440906533187938298969649928516003704476137795166849228875

# Tabulation

def fib_tabulation(n)
  f = [0,1]
  (n-1).times do |i|
    f[i+2] = f[i+1] + f[i]
  end
  f[n]
end
# p fib_tabulation(7) === 13
# p fib_tabulation(10) === 55
# p fib_tabulation(100) === 354224848179261915075
# p fib_tabulation(1000) === 43466557686937456435688527675040625802564660517371780402481729089536555417949051890403879840079255169295922593080322634775209689623239873322471161642996440906533187938298969649928516003704476137795166849228875

require 'benchmark'
n = 25
Benchmark.bm do |x|
  x.report("fib_recursive") { fib_recursive(n) }
  x.report("fib_tabulation") { fib_tabulation(n) }
  x.report("fib_memoization") { fib_memoization(n) }
  x.report("fib_iterative") { fib_iterative(n) }
end