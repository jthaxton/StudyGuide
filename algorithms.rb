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