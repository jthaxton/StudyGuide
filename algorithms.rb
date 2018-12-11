# balanced parenthesis 
# note: Array#each_with_object assigns dtype of choice to el in block
# if str item in hash, push to stack. if match in stack, pop.
def paren_balanced?(str)
    return false if string.length % 2 != 0 
    hash = { '{' => '}', '[' => ']', '(' => ')' }
    str.chars.each_with_object([]) do |el, stack|
        if hash[el]
            stack << el 
        elsif hash.values.include?(el)
            return false unless hash[stack.pop] == el 
        else 
            return false 
        end 
    end 
    true 
end 

# operations required for strings to match 
def similar_strings(a,b)
    difference = {}
    a.chars.each do |letter|
        if !difference[letter]
            difference[letter] = 0 
 
        end 
        difference[letter] += 1     
    end 
    b.chars.each do |letter|
        if !difference[letter]
            difference[letter] = 0 
           
        end 
        difference[letter] -= 1 
    end 
    # p difference.values
  result = 0
  difference.values.each {|el| result += el.abs}
  result
end 


# returns one triplet. O(n^2)
def three_sum(nums)
  nums.sort!
  i = 0 
  while i < nums.length - 1

    j = i + 1 
    k = nums.length - 1 
    while i < k 
      if nums[i] + nums[j] + nums[k] == 0
        return [nums[i], nums[j], nums[k]]
      elsif nums[i] + nums[j] + nums[k] < 0 
        j += 1 
      elsif nums[i] + nums[j] + nums[k] > 0 
        k -= 1
      end 
    end 
    
  end 
  return false 
end