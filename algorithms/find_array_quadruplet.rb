def find_array_quadruplet(arr, s)
  if arr.length < 4
    return []
  end
  n = arr.length
  arr.sort!
  arr[0..-4].each_with_index do | a, i | 
    arr[0..-3].each_with_index do | b, j |
      r = s - (arr[i] + arr[j])
      low = j+1
      high = n-1
      
      while low < high
        if (arr[low] + arr[high] < r)
          low += 1
        elsif (arr[low] + arr[high] > r)
          high -= 1
        else
          return [arr[i], arr[j], arr[low], arr[high]]
        end
      end
    end
  end
  []
end

p find_array_quadruplet([1,2,3,4,5,9,19,12,12,19], 40)