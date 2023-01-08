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

end
