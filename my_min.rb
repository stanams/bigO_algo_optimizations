def my_min(ary)
  result = []
  smallest = nil
  ary.each_with_index do |el, i|
    smallest = el if smallest.nil?
    ary.each_with_index do |other_el, j|
      next if i == j
      smallest = other_el if other_el < smallest
    end
  end
  smallest
end

# This is O(n^2) complexity. O(n(n - 1))

def my_min2(ary)
  smallest = ary.first
  ary.each_with_index do |el, i|
    next if i == 0
    smallest = el if el < smallest
  end
  smallest
end

# This is O(n) complexity. O(n - 1)


def largest_sub_sum(ary)
  sub_arys = []
  sum = []
  ary.each_with_index do |el, i|
    (i...ary.length).each do |j|

      sub_arys << ary[i..j]
    end
  end

  sub_arys.each do |el|
    sum << el.inject(&:+) unless el.empty?
  end
  sum.max
end

# This O(n^2) complexity (n^2 + 2n + 2)

def largest_sub_sum2(ary)
  largest_sum = nil
  current_sum = 0
  ary.each do |el|
    if current_sum + el >= 0
    current_sum += el
    else
      current_sum = el
    end
    largest_sum = current_sum if largest_sum.nil? || current_sum > largest_sum
  end
  largest_sum
end

#O(n) complexity.

def first_anagrams(str1, str2)
  str1_anagrams = str1.split("").permutation.to_a.map(&:join)
  str1_anagrams.include?(str2)
end

# O(n!) complexity



def second_anagram(str1, str2)
  dups = []
  str1.split("").each_with_index do |el, i|
    str2.split("").each_with_index do |el2, j|
      dups << el if el == el2
    end
  end
  str1 = str1.split("")
  str2 = str2.split("")
  dups.each do |el|
    str1.delete(el)
    str2.delete(el)
  end

  str1.empty? && str2.empty?
end

# O(n^2)

def third_anagram?(str1, str2)
  str1.split("").sort.join("") == str2.split("").sort.join("")
end

# Complexity O(n log(n))

def fourth_anagram?(str1, str2)
  hash1 = Hash.new(0)
  hash2 = Hash.new(0)

  str1.each_char do |el|
    hash1[el] += 1
  end

  str2.each_char do |el|
    hash2[el] += 1
  end

  hash1 == hash2
end

# O(n) complexity



def bad_two_sum?(arr, target)
  pairs = arr.permutation(2).to_a
  pairs.each do |pair|
    return true if pair[0] + pair[1] == target
  end
  false
end

# O(n!) complexity


def okay_two_sum?(arr, target)

  arr.each_with_index do |pair1, i|
    arr.each_with_index do |pair2, j|
      next if i == j
      return true if pair1 + pair2 == target
    end
  end
  false
end

def okay_two_sum2(arr, target)

  arr.each do |el|
    complement = target - el
    return true if arr.bsearch {|x| x == complement}
  end
  false
end

def pair_sum?(arr, target)
  my_hash = {}
  arr.each do |el|
    my_hash[el] = true
    complement = target - el
    return true unless my_hash[complement].nil?
  end
  false
end


def max_window_range(arr, w)
  current_max_range = nil
  arr.each_with_index do |el, i|
    if current_max_range.nil? || current_max_range < arr.slice(i, w).max - arr.slice(i, w).min
      current_max_range = arr.slice(i, w).max - arr.slice(i, w).min
    end
  end
  current_max_range
end


class MyQueue
  def initialize
    @store = []
  end

  def enqueue(el)
    @store.push(el)
  end

  def dequeue(el)
    @store.shift
  end

  def peek
    @store.first
  end

  def size
    @store.size
  end

  def empty?
    @store.empty?
  end
end


class MyStack



  def initialize
   @store = []
   @max = nil
 end

 def max
   @max
 end

 def pop
   @store.pop
 end

 def push(el)
   @max = el if @max.nil? || @max < el
   @store << el

 end

 def peek
   @store.last
 end

 def size
   @store.size
 end

 def empty?
   @store.empty?
 end

end

class StackQueue
  def initialize
    @in_stack = MyStack.new
    @out_stack = MyStack.new
  end

  def empty?
    @in_stack.empty? && @out_stack.empty?
  end

  def size
    @in_stack.size + @out_stack.size
  end

  def enqueue(val)
    # O(1)
    @in_stack.push(val)
  end

  def dequeue
    queueify if @out_stack.empty?
    @out_stack.pop
  end

  private
  def queueify
    @out_stack.push(@in_stack.pop) until @in_stack.empty?
  end
end
