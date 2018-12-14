# Basic singly linked list
class Node
    attr_accessor :next, :value
    def initialize(value, nex = nil)
        @value = value 
        @next = nex 
    end 

    def append(value)
        if @next.nil?
            node = Node.new(value)
            @next = node 
        else 
            raise "Next already assigned."
        end 
    end 
end 

# MinStack implementation, FIFO
class MinStack 
    attr_accessor :mins, :store, :min
    def initialize
        @store = [] 
        @min = nil 
        @mins = []
        @length = 0
    end 

    def add(value)
        @store << value 
        if @min.nil?
            @min = value 
            @mins << value
        end 


        if value < @min 
            @min = value 
            @mins << value 
        end
        @length += 1 
        value
    end 
    #peek at last element
    def peek
        @store[-1]
    end 

    def remove
        num = @store.pop
        if num == @min 
            @mins.pop
            @min = @mins[-1]
        end 
        @length -= 1
        num
    end 

    def is_empty?
        @store.empty?
    end 

    def min 
        @min
    end 

    def length 
        @length
    end 
end 

class Queue
    def initialize
        @store = []
    end 

    def enqueue(value)
        @store << value 
        value
    end 

    def dequeue
        @store.shift
        
    end 
    # peek at first element
    def peek 
        @store[0]
    end 

    def is_empty?
        @store.empty?
    end 

end 

class BinaryMinHeap
  attr_reader :store

  def initialize(&prc)
    @prc ||= Proc.new {|a,b| a <=> b}
    @store = []
  end

  def count
    @store.length
  end

  def peek
    @store[0]
  end

  def extract
    @store[0], @store[-1] = @store[-1], @store[0]
    val = @store.pop
    BinaryMinHeap.heapify_down(@store, 0, @store.length, &@prc)
    val
  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(@store, @store.length - 1, &@prc)
  end

  public  
  
  def self.child_indices(len, parent_index)
    child_indices = [
      (parent_index + 1) * 2 - 1,
      (parent_index + 1) * 2
    ]
    
    child_indices.pop if child_indices.last >= len
    child_indices.pop if child_indices.last >= len
    
    child_indices
  end
  
  def self.parent_index(child_index)
    raise 'root has no parent' if child_index == 0
    (child_index - 1) /2
  end
  
  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new {|a,b| a <=> b}
    
    child_indices = self.child_indices(len, parent_idx)

    case child_indices.length
      when 0
        return array
      when 1
        smallest_child_idx = child_indices[0]
      when 2
        child_0_idx = array[child_indices[0]]
        child_1_idx = array[child_indices[1]]
        if prc.call(child_0_idx, child_1_idx) <0
          smallest_child_idx = child_indices[0]
        else
          smallest_child_idx = child_indices[1]
        end
    end
    
    smallest_child_val = array[smallest_child_idx]
    parent_val = array[parent_idx]
    
    if prc.call(smallest_child_val, parent_val) < 0
      array[smallest_child_idx], array[parent_idx] = array[parent_idx], array[smallest_child_idx]
      self.heapify_down(array, smallest_child_idx, len, &prc)
    end
    
    array
  end
  
  def self.heapify_up(array, child_idx, &prc)
    prc ||= Proc.new {|a, b| a <=> b}
    
    return array if child_idx == 0
    
    parent_idx = self.parent_index(child_idx)
    
    child_val, parent_val = array[child_idx], array[parent_idx]
    
    if prc.call(child_val, parent_val) < 0
      array[child_idx], array[parent_idx] = array[parent_idx], array[child_idx]
      self.heapify_up(array, parent_idx, &prc)
    end
  end
  
end

# Queue using two stacks
class StackQueue
    def initialize
        @stack1 = MinStack.new 
        @stack2 = MinStack.new 
        @curr = nil 
    end 

    def push(value)
        @stack1.add(value)
    end 

    def pop
        until @stack1.length == 1 
            @stack2.add(@stack1.remove)
        end 
        @curr = @stack1.remove

        until @stack2.is_empty?
            @stack1.add(@stack2.remove)
        end 
        @curr
    end 

    def peek
        @stack1[-1] 
    end 


end 

# doubly linked list 
class DoubleLink
    def initialize(value, parent = nil)
        @parent = parent 
        @value = value 
        @child = nil 
    end 

    def push(value)
        child = DoubleLink.new(value, self)
        @child = child 
    end 
 
end 

# with doubly linked list
# class Queue 
#     def initialize
#         @store = store 
#     end 

#     def push(value)
#         @store << DoubleLink.new(value, )
    
# end 

class Node 
    attr_reader :value 
    attr_accessor :children
    def initialize(value)
        @value = value 
        @children = []
    end 
end 

class Graph 
    attr_accessor :adjacency_list

    def initialize
        @adjacency_list = {}
    end 

    def add_node(node)
    end 

    def dfs(node)
        stack = []
        visited = []
        stack.push(node)
        while stack.length > 0 
            popped = stack.pop 
            if !visited.map {|n| n.value}.include?(popped.value)
                visited << popped 
                popped.children.each do |child|
                    if (visited.map {|node| node.value}).include?(child.value)
                        return true 
                    else 
                        stack << child 
                    end 
                end 
            end 
        end 
        return false 
    end 

    def show 
        adjacency_list
    end 
end 

