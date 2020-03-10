class Solution
    # param a : array of integers
    #return an integer
    def bulbs(a)
      count = 0
      results_comparative = a.clone
      results_comparative.each_with_index do |bulb, idx|
        case bulb
        when 0
          results_comparative[idx..-1].each_with_index do |value, idx2|
            p "hi"
            if value === 0
              results_comparative[idx2] = 1
            elsif value === 1
              results_comparative[idx2] = 0
            else
              "not a 0 or 1, inner loop"
            end
          end
          p "a: #{results_comparative}"
          count += 1
        else
          "not a 0 or 1"
        end
      end
      p results_comparative
      count
    end
end

require 'test/unit'

class SolutionTest < Test::Unit::TestCase 

  def test_solution_has_bulbs_method
    test = Solution.new

    assert_respond_to(test, :bulbs)
  end

  def test_bulbs_turns_all_elements_to_1
    test = Solution.new

    assert_equal(4, test.bulbs([0,1,0,1]))
    assert_equal(3, test.bulbs([0,1,0]))
  end
end