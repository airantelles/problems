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
        sum_numbers = num + n
        if sum_numbers == target
          return [index, i]
        end
      end
    end
  end
end
