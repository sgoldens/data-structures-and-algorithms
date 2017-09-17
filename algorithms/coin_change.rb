# Coin Change
# Given an int N and an array of coins with int values M, find the number of combinations which sum up to N.

# Example
# N = 10, M = [2,3,5,6], Output: 5

# Time Complexity: O(MN)
# Auxiliary Space Complexity: O(N)

def coin_change(amount, coins)
  combinations = [1] + [0] * (amount)
  coins.each do |coin|
    combinations.each_with_index do |value, index|
      if index >= coin
        combinations[index] += combinations[index - coin]
      end
    end
  end
  combinations.last
end

p coin_change(10, [2,3,5,6]) === 5
p coin_change(12, [1,2,5]) === 13
