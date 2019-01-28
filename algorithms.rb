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



class String
    # string regex simple interpolation monkey patch
    def regex(sub)
      return true if self =~ /#{sub}/ 
    end 

    # paren_balanced with regex
    # note this only works with ()
    # Array#gsub(pattern, replacement)
    def paren_balanced?
        valid = true
        self.gsub(/[^\(\)]/, '').split('').inject(0) do |counter, parenthesis|
          counter += (parenthesis == '(' ? 1 : -1)
          valid = false if counter < 0
          counter
        end.zero? && valid
    end 
end 

# if no other characters
def balanced?(str)
    front = {'('=>')', '{' => '}', '[' => ']'}
    back = {')'=>'(', '}'=>'{',']'=>'['}
    stack = []
    i = 0 
    return false if str.length.odd?
    while i < str.length 
      if front[str[i]]
        stack << str[i]
      elsif back[str[i]] && stack.include?(back[str[i]])
      stack.pop
      else 
        return false 
      end 
      i += 1 
    end 
      return true 
  end 

  def permutations(arr)
    perm = []
    perm << arr if arr.length < 1
    
    arr.each_with_index do |el,idx|
      previous = permutations(arr[0...idx] + arr[idx + 1..-1]) 
      previous.each do |p|
        perm <<  [el] + p
        end
    end
    perm
  end 

  def flatten(arr)
    res = []
    return arr if arr.empty?
    arr.each do |el|
      if el.class == Array
        res += flatten(el)
      else
        res << el
      end 
    end 
    return res
  end 

  def quicksort(arr)
    return arr if arr.length < 2
    pivot = arr.first
    left = arr[1..-1].select {|el| el if el < pivot}
    right = arr[1..-1].select {|el| el if el > pivot }
    return quicksort(left) + [pivot] + quicksort(right)
  end 
  
#   balanced?('()[][[{}]]')
# ruby get request 
# require 'net/http'
# x = Net::HTTP.get('www.google.com', '/')