# @param {String} s1
# @param {String} s2
# @param {String} s3
# @return {Boolean}
def is_interleave(s1, s2, s3)
    s1 = s1.concat(s2)
    s1 = s1.split('').sort!.join('')
    s3 = s3.split('').sort!.join('')
    p s1
    p s3
    return true if s1 === s3
    return false
end

# s1 = "aabcc"
# s2 = "dbbca"

# s3_true = "aadbbcbcac" # => true
# s3_false = "aadbbbaccc" # => false

s1 = "ab"
s2 = "bc"

s3_true = "bbac" # => true
s3_false = "aadbbbaccc" # => false

p is_interleave(s1,s2,s3_true) === true
p is_interleave(s1,s2,s3_false) === false