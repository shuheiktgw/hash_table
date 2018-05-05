
module Chaining
  class HashTable

    Node = Struct.new('Node', :key, :value)

    attr_reader :size
    attr_accessor :table

    def initialize(size)
      @size = size
      @table = []
    end

    def put(key, value)
      k = compute_hash(key)
      v = table[k]
      n = Node.new(key, value)

      if v.nil?
        table[k] = [n]
      elsif index = table[k].index { |node| node.key == key }
        table[k][index] = n
      else
        table[k] << n
      end
    end

    def get(key)
      r = Array(table[compute_hash(key)]).find { |node| node.key == key }
      r.nil? ? r : r.value
    end

    private

    def compute_hash(key)
      key.hash.abs % size
    end
  end
end
