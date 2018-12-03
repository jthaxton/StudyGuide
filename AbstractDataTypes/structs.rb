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
        num
    end 

    def is_empty?
        @store.empty?
    end 

    def min 
        @min
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