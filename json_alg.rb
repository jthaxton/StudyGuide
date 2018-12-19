require 'json'


class Store
  attr_accessor :store, :hashes
  def initialize 
    @store = {}
    @hashes = {}
  end

# my implementation of ruby's json recurse_proc
  def recurse_proc(el, result)
    case result
    when Array
      result.each { |x| recurse_proc el, x}
    when Hash
      result.each do |x, y|
        
        key_exists = result.key?(x) && result[x] == y
        if key_exists && !@hashes[x]
          if result[x].class == Array
            @hashes[x] = {}
            result[x].uniq.each do |item|
              if @hashes[x][item].nil?
                @hashes[x][item] = [el]
              else
                @hashes[x][item] << el
              end
            end
          else

            @hashes[x] = {result[x] => [el]}
          end
        elsif key_exists && @hashes[x] && @hashes[x][result[x]].class == Array
          @hashes[x][result[x]] << (el)
        elsif key_exists && @hashes[x] && !@hashes[x][result[x]]
          if result[x].class == Array
            result[x].uniq.each do |item|
              if @hashes[x][item].nil?
                @hashes[x][item] = [el]
              else
                @hashes[x][item] << el
              end
            end
          else

            @hashes[x][result[x]] = [el]
          end
        end 
        recurse_proc el, x; recurse_proc el, y 
      end 
    else
      result
    end

end

  def recurse(el, input, res)
    case input
    when Array
      input.each do |item|
        if !@hashes['list'][item].nil?
          @hashes['list'][item].each do |id|
            if @store[id] && input.all?{|element| @store[id]['list'].count(element) >= input.count(element) }
              res << id
            end
          end
        end
      end
    when Hash
      input.each do |x, y|
        key_exists = input.key?(x) && input[x] == y
        if key_exists && @hashes[x] && @hashes[x][input[x]]
          if @hashes[x][input[x]].class != Hash && x != "type" 
            res << @hashes[x][input[x]]
          end
        end 
        recurse el, x, res; recurse el, y, res
      end 
    else
      res
    end
    res
end

  def query(input)
    
    case input[0]
    when 'a'
      add(input)
    when 'g'
      get(input)
    when 'd'
      delete(input)
    else 
      raise "invalid"
    end 
  end

  def get(input)
    result = {}
    res = []
    ke = JSON.parse(input[4..input.length - 1])

    if @store == {}
      return [] 
    end

    if ke == {}
      return @store.keys.map {|k| @store[k]}
    end 
    count = ke.keys.length
    r = []
    ke.each do |k, v|
      rec = recurse(0, {k => v}, [])
      r += rec
    end
    if r[0].class == Array
      return [] if r.length != count
      var = r.inject(:&)
    else
      var = r.uniq
    end
    if var.nil?
        return []
    end
    result = var.map {|el| @store[el] }
    result.compact
  end 


  def delete(input)
    res = []
    result = {}
    ke = JSON.parse(input[7..input.length - 1])
    
    if @store == {}
      return [] 
    end

    count = 0
      k = ke.keys[count]
    r = []
    ke.each do |k, v|
      r += recurse(0, {k => v}, [])
    end
    if r[0].class == Array
      var = r.inject(:&)
    else
      var = r
    end
    if var.nil? || var.empty?
        return []
    end

    var.each {|el| @store.delete(el)}
  end

  def add(input)
    x = input[4..input.length - 1]
    @store.merge!({@store.keys.length + 1 => JSON.parse(x)})
      recurse_proc(@store.keys.length, JSON.parse(x))
  end 
end

s = Store.new