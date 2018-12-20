require 'json'

class Store
  attr_accessor :store, :hashes
  def initialize 
    @store = {}
    @hashes = {}
  end

# my implementation of ruby's json recurse_proc
    def recurse_add(el, result)
        case result
        when Array
            result.each { |x| recurse_add el, x}
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
                recurse_add el, x; recurse_add el, y 
            end 
        else
        result
        end
    end

    def recurse_get(el, input, res)
        case input
        when Array
        input.each do |item|
          @hashes.each do |k,v|
            if !@hashes[k][item].nil?
                @hashes[k][item].each do |id|

                    if @store[id] && input.all?{|element| @store[id][k].class == Array ? @store[id][k].count(element) >= input.count(element) : nil}
                        res << id
                    end
                    end
                end
            end
        end

        input.each { |x| recurse_get el, x, res}
        when Hash
            input.each do |x, y|
                key_exists = input.key?(x) && input[x] == y
                if key_exists && @hashes[x] && @hashes[x][input[x]]
                    if @hashes[x][input[x]].class != Hash && x != "type" 
                        res << @hashes[x][input[x]]
                    end
                end 
                recurse_get el, x, res; recurse_get el, y, res
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
    parsed_input = JSON.parse(input[4..input.length - 1])
    if @store == {}
      return [] 
    end
    if parsed_input == {}
      return @store.keys.map {|k| @store[k]}
    end 
    count = parsed_input.keys.length
    r = []
    parsed_input.each do |k, v|
      rec = recurse_get(0, {k => v}, [])
      r += rec
    end
    if r[0].class == Array
      return [] if r.length != count
      var = r.inject(:&)
    else
      var = r.uniq.sort
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
    parsed_input = JSON.parse(input[7..input.length - 1])
    if @store == {}
      return [] 
    end

    res_arr = []
    parsed_input.each do |k, v|
        res_arr += recurse_get(0, {k => v}, [])
    end
    if res_arr[0].class == Array
        intersection_arr = res_arr.inject(:&)
    else
        intersection_arr = res_arr
    end
    if intersection_arr.nil? || intersection_arr.empty?
        return []
    end
    intersection_arr.each {|el| @store.delete(el)}
  end

  def add(input)
    parsed_input = JSON.parse(input[4..input.length - 1])
    @store.merge!({@store.keys.length + 1 => parsed_input})
    recurse_add(@store.keys.length, parsed_input)
  end 
end

s = Store.new