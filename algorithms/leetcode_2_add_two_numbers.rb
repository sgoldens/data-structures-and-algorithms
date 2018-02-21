=begin
(source: https://leetcode.com/problems/add-two-numbers/description/)

2. Add Two Numbers

You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order and each of their nodes contain a single digit. Add the two numbers and return it as a linked list.

You may assume the two numbers do not contain any leading zero, except the number 0 itself.

Example

Input: (2 -> 4 -> 3) + (5 -> 6 -> 4)
Output: 7 -> 0 -> 8
Explanation: 342 + 465 = 807.
=end

# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val)
#         @val = val
#         @next = nil
#     end
# end

# @param {ListNode} l1
# @param {ListNode} l2
# @return {ListNode}
def add_two_numbers(l1, l2)
    result = []
    a1 = []
    a2 = []
    while !l1.nil?
        a1.unshift(l1.val)
        l1 = l1.next
    end
    while !l2.nil?
        a2.unshift(l2.val)
        l2 = l2.next
    end
    intSum = a1.join('').to_i + a2.join('').to_i
    intSum.to_s.split('').reverse.each do |char|
        result << char.to_i
    end
    result
end