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
  
  def self.string_challenge(current_char)
    require 'net/http'
    require 'json'

    url = 'https://coderbyte.com/api/challenges/json/age-counting'
    uri = URI(url)
    response = Net::HTTP.get(uri)

    data = JSON.parse(response)['data']

    count = 0
    data.split(',').each do |item|
      if item.include?('age=') && item.split('=')[1].to_i >= 50
        count += 1
      end
    end

    puts count
  end
  
  def self.array_challenge(strArr)
    matrix = strArr.map { |s| s[1..-2].split(',').map(&:to_i) }
    tasks = matrix.transpose
    pairs = []
  
    tasks.each_with_index do |task, i|
      min_cost = Float::INFINITY
      min_machine = nil
  
      task.each_with_index do |cost, j|
        if cost < min_cost
          unless pairs.include?(j)
            min_cost = cost
            min_machine = j
          end
        end
      end
  
      pairs[i] = min_machine
    end
  
    pairs.map.with_index { |machine, i| "(#{i + 1}-#{machine + 1})" }.join
  end
  
  def self.array_challenge_2(strArr)
    s1, s2 = strArr
    m = s1.length
    n = s2.length
    
    memo = Array.new(m+1) { Array.new(n+1, 0) }
    
    (1..m).each do |i|
      (1..n).each do |j|
        if s1[i-1] == s2[j-1]
          memo[i][j] = memo[i-1][j-1] + 1
        else
          memo[i][j] = [memo[i][j-1], memo[i-1][j]].max
        end
      end
    end
    return memo[m][n]
  end
  
  def self.string_challenge_1(str)
    decrypted_str = ""
    i = 0
  
    while i < str.length - 1
      current_char = str[i]
      next_char = str[i + 1]
  
      if current_char == next_char
        decrypted_str += str[i + 2]
        i += 3
        next
      end
  
      if next_char.ord > current_char.ord
        direction = 1
        start_char = current_char
        end_char = next_char
      else
        direction = -1
        start_char = next_char
        end_char = current_char
      end
  
      decrypted_str += start_char
      current = start_char.ord
  
      while current != end_char.ord
        current += direction
        decrypted_str += current.chr
      end
  
      i += 2
    end
  
    decrypted_str += str[-1] unless str[-1] == "S"
    return decrypted_str
  end
  
  def sequence_break(result, start, ending, forward, backward)
    if forward
      if !result.empty? && result[result.length - 1] == (start - 1).chr
        result << (ending + 1).chr
      else
        result << (start - 1).chr << (ending + 1).chr
      end
      forward = false
    elsif backward
      if !result.empty? && result[result.length - 1] == (start + 1).chr
        result << (ending - 1).chr
      else
        result << (start + 1).chr << (ending - 1).chr
      end
      backward = false
    end
  end
  
  def self.alphabet_run_encryption(str)
    i = 0
    result = ""

    while i < str.length - 1 do
      if str[i] == str[i + 1]
        result += (str[i + 1].ord - 1).chr + "R" + str[i + 2]
        i += 2
      elsif str[i] == str[i + 1].ord - 1 && i < str.length - 2 && str[i + 2] != 'S'
        result += str[i]
        i += 1
      elsif str[i] == str[i + 1].ord + 1 && i < str.length - 2 && str[i + 2] != 'S'
        result += str[i]
        i += 1
      elsif str[i] == str[i + 1].ord - 1 && i == str.length - 2
        result += str[i]
        i += 1
      elsif str[i] == str[i + 1].ord + 1 && i == str.length - 2
        result += str[i]
        i += 1
      elsif str[i] == str[i + 1].ord - 1 && i < str.length - 2 && str[i + 2] == 'S'
        result += str[i] + str[i + 1]
        i += 3
      elsif str[i] == str[i + 1].ord + 1 && i < str.length - 2 && str[i + 2] == 'S'
        result += str[i] + str[i + 1]
        i += 3
      elsif str[i] != str[i + 1] && str[i + 1] != str[i + 2]
        alphabet = ""
        if str[i] < str[i + 1]
          alphabet = (str[i]..str[i + 1]).to_a.join('')
        else
          alphabet = (str[i + 1]..str[i]).to_a.reverse.join('')
        end

        offset = str[i + 2] == 'S' ? 3 : 2
        direction = str[i + 1] < str[i] ? -1 : 1
        idx = (alphabet.index(str[i]) + direction) % 26
        result += alphabet[idx] + str[i + offset] if !str[i+offset].nil?

        i += offset
      end
    end

    if i == str.length - 1
      result += str[i]
    end

    return result
  end
    
end
