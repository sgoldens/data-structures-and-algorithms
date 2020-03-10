def isCryptSolution(crypt, solution)
    results = []
    solution_hash = {}
    solution.each do |array|
        solution_hash[array[0]] = array[1]
    end
    crypt.each do |el|
      temp = []
      el.split("").each do |char|
        temp << solution_hash[char]
      end
      results << temp
    end

    unless results[0].count > 1 || results[1].count > 1
        if results[0].join('').to_i + results[1].join('').to_i == 0
            return true         
        end
    end
    
    results.each do |result|
        return false if result.join('').to_i === 0 
    end
    
    unless results[0].join('').to_i == 0 && results[1].join('').to_i == 0
        if results[0][0].to_i == 0 || results[1][0].to_i == 0
            return false
        end
    end
    
    
    if results[0].join('').to_i + results[1].join('').to_i === results[2].join('').to_i
        return true
    end
    false
end



# 9567 + 1085 = 10652
test_crypt = ["SEND", "MORE", "MONEY"]
test_solution = [['O', '0'],
            ['M', '1'],
            ['Y', '2'],
            ['E', '5'],
            ['N', '6'],
            ['D', '7'],
            ['R', '8'],
            ['S', '9']]
# 00 + 00 = 00
two_crypt = ["AA", 
 "AA", 
 "AA"]
two_solution = [["A","0"]]


three_crypt = ["TEN", 
 "TWO", 
 "ONE"]
three_solution = [["O","1"], 
 ["T","0"], 
 ["W","9"], 
 ["E","5"], 
 ["N","4"]]
# 2041 + 5863 = 0
four_crypt = ["WASD", 
 "IJKL", 
 "AOPAS"]
four_solution =  [["W","2"], 
 ["A","0"], 
 ["S","4"], 
 ["D","1"], 
 ["I","5"], 
 ["J","8"], 
 ["K","6"], 
 ["L","3"], 
 ["O","7"], 
 ["P","9"]]

p isCryptSolution(test_crypt, test_solution) === true
p isCryptSolution(two_crypt, two_solution) === false
p isCryptSolution(three_crypt, three_solution) === false
p isCryptSolution(four_crypt, four_solution) === false