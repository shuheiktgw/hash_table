
module LinearProbing
  class HashTable

    Node = Struct.new('Node', :key, :value)

    attr_reader :size
    attr_accessor :table, :current_size

    def initialize(size)
      @size = size
      @current_size = 0
      @table = []
    end

    def put(key, value)
      raise 'HashTable is full' if current_size == size

      k = compute_hash(key)
      until table[k].nil? || table[k].key == key
        k = (k + 1) % size
      end

      self.current_size += 1
      table[k] = Node.new(key, value)
    end

    def get(key)
      k = compute_hash(key)
      count = 0
      loop do
        return nil if count == size
        return nil if table[k].nil?
        return table[k].value if table[k].key == key
        k = (k + 1) % size
        count += 1
      end
    end

    private

    def compute_hash(key)
      key.hash.abs % size
    end
  end
end
