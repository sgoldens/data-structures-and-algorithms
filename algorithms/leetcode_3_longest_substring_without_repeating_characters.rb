=begin
(source: https://leetcode.com/problems/longest-substring-without-repeating-characters/description/)

3. Longest Substring Without Repeating Characters

Given a string, find the length of the longest substring without repeating characters.

Examples:

Given "abcabcbb", the answer is "abc", which the length is 3.

Given "bbbbb", the answer is "b", with the length of 1.

Given "pwwkew", the answer is "wke", with the length of 3. Note that the answer must be a substring, "pwke" is a subsequence and not a substring.

=end

require "set"
# @param {String} s
# @return {Integer}
def length_of_longest_substring(s)
    maxlength = 0
    sub = 0
    lettersUsed = Set.new([])
    start = 0
    split_s = s.split('')
    split_s.each_with_index do |char, index|
      if !lettersUsed.include?(char)
        lettersUsed << char
        if index == s.length - 1
          maxlength = max(maxlength, index + 1 - start)
        end
      else
        maxlength = index - start
        lettersUsed.delete(s[start])
        start += 1
        while (start <= index) and lettersUsed.include?(s[index])
            lettersUsed.delete(s[start])
            start += 1
        end
        lettersUsed << s[index]
      end
    end
    maxlength
end

p length_of_longest_substring("pwwkew")
p length_of_longest_substring("abcabcbb")
