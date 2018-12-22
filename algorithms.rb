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

# other balanced parens
def is_valid(s)
    return false if s.length % 2 != 0
    # return true if s.length == 0
    hash = {'('=>')','{'=>'}','['=>']'}
    spl = s.split('')
    full = false
    spl.each_with_object([]) do |el, stack|
        if hash[el]
            stack << el
        elsif hash.values.include?(el)
            return false unless hash[stack.pop] == el
        else 
            return false
        end 
        full = true if stack.length > 0
        full = false if stack.length == 0
    end 
    if full == true 
        return false 
    else 
        return true 
    end 
    
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

# returns all triplets 
# def three_sum_all(num)
#     found = false
#     nums.sort!
#     result = []
#   i = 0 
#   while i < nums.length - 1

#     j = i + 1 
#     k = nums.length - 1 
#     while i < k 
#       if nums[i] + nums[j] + nums[k] == 0
#         result << [nums[i], nums[j], nums[k]]
#         j += 1 
#         k -= 1 
#         found = true 
#       elsif nums[i] + nums[j] + nums[k] < 0 
#         j += 1 
#       elsif nums[i] + nums[j] + nums[k] > 0 
#         k -= 1
#       end 
#     end 
    
#   end 
#   if found == false 
#     return [] 
#   end 
#   return result 
# end 

# this time complexity is pathetic. fix it.
def num_unique_emails(emails)
    result = []
    emails.each do |el|         
        result << [el.split('').delete_if{|e| e == '.'}[0],'@',el.split('@')[-1]].join('')
    end 
    result.uniq.length
end 
