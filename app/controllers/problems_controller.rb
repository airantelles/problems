class ListNode
  attr_accessor :l1
  attr_accessor :l2
  def initialize(val = 0, _next = nil)
    @val = val
    @next = _next
  end
end

class ProblemsController < ApplicationController
  # Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.
  # You may assume that each input would have exactly one solution, and you may not use the same element twice.
  # You can return the answer in any order.
  # @param {Integer[]} nums
  # @param {Integer} target
  # @return {Integer[]}
  def self.two_sum(nums, target)
    nums.each_with_index.each do |num, index|
      next if num + nums.max < target
      nums.each_with_index.each do |n, i|
        next if index == i
        return [index, i] if num + n == target
      end
    end
  end

  # You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order, and each of their nodes contains a single digit. Add the two numbers and return the sum as a linked list.
  # You may assume the two numbers do not contain any leading zero, except the number 0 itself.
  def self.add_two_numbers(l1, l2)
    current = result = ListNode.new()
    carry = 0
    while l1 || l2 || carry > 0
      number_1 = l1 && l1.val || 0
      number_2 = l2 && l2.val || 0
      num = number_1 + number_2 + carry
      if num > 9
        carry = 1
        num = num - 10
      else
        carry = 0
      end
      node = ListNode.new(num)
      current&.next = node
      current = node
      l1 = l1.next if l1
      l2 = l2.next if l2
    end
    result.next
  end

  # 29. Divide Two Integers
  # Given two integers dividend and divisor, divide two integers without using multiplication, division, and mod operator.
  # The integer division should truncate toward zero, which means losing its fractional part. For example, 8.345 would be truncated to 8, and -2.7335 would be truncated to -2.
  # Return the quotient after dividing dividend by divisor.
  # Note: Assume we are dealing with an environment that could only store integers within the 32-bit signed integer range: [−231, 231 − 1]. For this problem, if the quotient is strictly greater than 231 - 1, then return 231 - 1, and if the quotient is strictly less than -231, then return -231.
  def self.divide(dividend, divisor)
    exponential = 2**31
    division = (dividend.to_f / divisor.to_f).truncate
    if divisor != 0
      if division > exponential - 1
        exponential - 1
      else
        division
      end
    end
  end

  # 7. Reverse Integer
  # Given a signed 32-bit integer x, return x with its digits reversed. If reversing x causes the value to go outside the signed 32-bit integer range [-231, 231 - 1], then return 0.
  # Assume the environment does not allow you to store 64-bit integers (signed or unsigned).
  def self.reverse(x)
    exponential = 2**31
    if x.positive?
      result = x.to_s.reverse.to_i
    else
      result = -x.to_s.reverse.to_i
    end
    if result.to_i < -exponential || result.to_i > exponential - 1
      return 0
    else
      return result.to_i
    end
  end

  # 20. Valid Parentheses
  # Given a string s containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.
  # An input string is valid if:
  # Open brackets must be closed by the same type of brackets.
  # Open brackets must be closed in the correct order.
  # Every close bracket has a corresponding open bracket of the same type.

  # @param {String} s
  # @return {Boolean}
  def self.is_valid(s)
    characters = { '(' => ')', '{' => '}', '[' => ']' }
    result = []
    s.each_char do |char|
      result << char if characters.key?(char)
      return false if characters.key(char) && characters.key(char) != result.pop
    end
    result.empty?
  end

  # 136. Single Number
  # Given a non-empty array of integers nums, every element appears twice except for one. Find that single one.
  # You must implement a solution with a linear runtime complexity and use only constant extra space.
  def self.single_number(nums)
    (nums.uniq.sum * 2) - nums.sum
  end

end
