# LRUCache.rb
# referenced sites: 
# - https://www.sitepoint.com/ruby-interview-questions-lru-cache-and-binary-trees/
# - http://www.brianstorti.com/implementing-a-priority-queue-in-ruby/

class Node
  attr_accessor :value, :next_node, :prev_node 

  def initialize(value, prev_node, next_node)
    @value = value
    @prev_node = prev_node
    @next_node = next_node
  end
end

class LRU
  attr_accessor :table, :head, :tail, :num_items, :max_items

  def initialize(max_items)
    @max_items = max_items
    @table = {}
    @head = nil
    @tail = nil
    @num_items = 0
  end

  def set(key, value)
    @num_items += 1
    if @num_items > @max_items
      @head = @head.next_node
    end

    new_node = Node.new value, @tail, nil
    @head = new_node if @tail == nil
    @tail.next_node = new_node if @tail != nil
    @tail = new_node
    @table[key] = new_node 
  end

  # When we get an item from the list, we move it to 
  # the back, the tail, to show it as most recently used
  def get(key)
    res = @table[key]
    return res if res.next_node == nil

    if res.prev_node != nil
      res.prev_node.next_node = res.next_node
    else
      @head = res.next_node
      @head.prev_node = nil
    end

    @tail.next_node = res
    res.next_node = nil
    res.prev_node = @tail
    @tail = res
  end

  def delete(key)

    # Case 1: doesn't exist
    if @num_items === 0
      return "#{key} doesn't exist in this LRUCache"
    end

    # Case 2: is the only node in the list
    if @num_items === 1
      table[key].delete
      @num_items -= 1
    end

    # Case 3: is the head of a list with more than one item
    
    if @num_items > 1 && @head.value === @table[key].value
      @table[key].delete
      @head === head.next_node
      @num_items -= 1
    end

    # Case 4: is the tail of a list with more than one item

    if @num_items > 1 && @tail.value === @table[key].value
      @table[key].delete
      @tail === @tail.prev_node
      @num_items -= 1
    end

    # Case 5: is a node in the list which is neither head nor tail

    if @num_items > 1 && @head.value != @table[key].value && @tail.value != @table[key].value
      target_prev_node = @table[key].prev_node
      target_next_node = @table[key].next_node
      @table[key].delete
      @table[]
    end

  end

end

lru = LRU.new(5)
lru.set('a', 1)
lru.set('b', 2)
lru.set('c', 3)
lru.set('d', 4)
lru.set('e', 5)
lru.get('c')
p (lru.tail.value === 3) === true
p lru.table
p lru.head