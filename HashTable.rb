###############
# HashTable class
###############

class HashTable

  attr_accessor :storage, :buckets, :size, :resizing

  def initialize
    @storage = []
    @buckets = 8
    @size = 0
    @resizing = false
  end

  def hash(str)
    hash = 5381

    str.split("").each do |i|
      char = i
      hash = ((hash << 5) + hash) + char.ord
    end
    return hash % self.buckets
  end

  def insert(key, value)
    bucket_index = self.hash(key)
    if self.storage[bucket_index] == nil 
      self.storage[bucket_index] = []
      self.storage[bucket_index].push([key, value])
      self.size += 1
      self.resize
    else
      bucket = self.storage[bucket_index]

      bucket.length.times do |counter|
        if bucket[counter][0] == key
          bucket[counter][1] = value
        end
      end

      bucket.push([key, value])
      self.size += 1
      self.resize
    end
  end

  def delete(key)
    bucket_index = self.hash(key)

    if self.storage[bucket_index] == nil
      return "Key: '#{key}' not found."
    else
      bucket = self.storage[bucket_index]
      bucket.length.times do |counter|
        if bucket[counter][0] == key
          temp = bucket[counter][1]
          bucket.delete_at(counter)
          self.resize
          self.size -= 1
          return "key-value: [#{key}][#{temp}] was deleted."
        end
      end
      return "This key was not found: '#{key}'"
    end
  end

  def retrieve(key)
    bucket_index = self.hash(key)

    if self.storage[bucket_index] == nil
      return false
    else
      bucket = self.storage[bucket_index]
      bucket.length.times do |counter|
        if bucket[counter][0] == key
          return true
        end
      end
    end
  end

  def resize
    allElements = []
    if self.size > (0.75 * self.buckets) && (self.resizing == false)
      self.resizing = true
      self.storage.each do |bucket|
        if bucket != nil
          bucket.each do |tuple|
            allElements.push(tuple)
          end
        end
      end
    
      self.storage = []
      self.size = 0
      self.buckets = (self.buckets * 2)

      allElements.each do |tuple|
        self.insert(tuple[0], tuple[1])
      end
      self.resizing = false
      return 'HashTable number of buckets has been doubled.'
    # We don't want our buckets to go below 8 buckets minimum
    elsif (self.size < (0.25 * self.buckets)) && self.buckets >= 9.0 && (self.resizing == false)
      self.resizing = true
      self.storage.each do |bucket|
        if bucket != nil
          bucket.each do |tuple|
            allElements.push(tuple)
          end
        end
      end

      self.storage = []
      self.size = 0
      self.buckets = (self.buckets * 0.5)

      allElements.each do |tuple|
        self.insert(tuple[0], tuple[1])
      end

      self.resizing = false
      return 'HashTable number of buckets have been halved.'
    end
  end

end

############
# Unit Tests
############

require 'test/unit'

class HashTableClassTest < Test::Unit::TestCase

  def test_hash_table_properties_exist
    test = HashTable.new

    assert_respond_to(test, :storage)
    assert_respond_to(test, :buckets)
    assert_respond_to(test, :size)
  end

  def test_hash_table_methods_exist
    test = HashTable.new

    assert_respond_to(test, :hash)
    assert_respond_to(test, :insert)
    assert_respond_to(test, :delete)
    assert_respond_to(test, :retrieve)
    assert_respond_to(test, :resize)
  end

  def test_hash_table_hash_produces_repeatable_result_for_indexing
    test = HashTable.new
    test_hello = test.hash("Hello Hash")
    test_goodbye = test.hash("Goodbye Hash")

    assert_not_equal(test_hello, test_goodbye)
    assert_equal(5, test_hello)
    assert_equal(2, test_goodbye)
  end

  def test_hash_table_insert_method_inserts_a_key_value_pair
    test = HashTable.new

    assert_equal(0, test.storage.length)
    assert_equal(0 , test.size)

    test.insert("Hello Hash", 5)

    assert_equal(1, test.size)
    assert_equal("Hello Hash", test.storage[5][0][0])
    assert_equal(5, test.storage[5][0][1])
  end

  def test_hash_table_insert_method_inserts_a_second_key_value_pair
    test = HashTable.new

    assert_equal(0, test.storage.length)
    assert_equal(0, test.size)

    test.insert("Hello Hash", 5)

    assert_equal(1, test.size)    
    assert_equal("Hello Hash", test.storage[5][0][0])
    assert_equal(5, test.storage[5][0][1])

    test.insert("Goodbye Hash", 11)

    assert_equal("Goodbye Hash", test.storage[2][0][0])
    assert_equal(11, test.storage[2][0][1])
  end

  def test_hash_table_insert_method_inserts_should_handle_collisions
    test = HashTable.new

    assert_equal(0, test.storage.length)
    assert_equal(0, test.size)

    test.insert("Hello Hash", 5)

    assert_equal(1, test.size)    
    assert_equal("Hello Hash", test.storage[5][0][0])
    assert_equal(5, test.storage[5][0][1])

    test.insert("Hellossss", 12)

    assert_equal(2, test.size)    
    assert_equal("Hellossss", test.storage[5][1][0])
    assert_equal(12, test.storage[5][1][1])
  end

  def test_hash_table_delete_method_should_be_able_to_delete_a_key_value_pair
    test = HashTable.new

    assert_equal(0, test.storage.length)
    assert_equal(0, test.size)

    test.insert("Hello Hash", 5)

    assert_equal(1, test.size)    
    assert_equal("Hello Hash", test.storage[5][0][0])
    assert_equal(5, test.storage[5][0][1])

    test.delete("Hello Hash")

    assert_equal(0, test.size)
    assert_equal(nil, test.storage[5][0])
  end

  def test_hash_table_delete_method_should_not_be_able_to_delete_a_key_value_pair_that_does_not_exist
    test = HashTable.new

    assert_equal(0, test.storage.length)
    assert_equal(0, test.size)

    test.insert("Hello Hash", 5)

    assert_equal(1, test.size)    

    test.delete("doesn't exist!")

    assert_equal(1, test.size)
  end

  def test_hash_table_retrieve_method_should_return_true_for_key_value_pairs_that_exist
    test = HashTable.new
    test.insert("Hello Hash", 5)

    assert_equal(true, test.retrieve("Hello Hash"))
  end

  def test_hash_table_retrieve_method_should_return_false_for_key_value_pairs_that_do_not_exist
    test = HashTable.new
    test.insert("Hello Hash", 5)

    assert_equal(false, test.retrieve("Hello"))
  end

  def test_hash_table_resize_should_double_the_number_of_buckets_when_the_size_exceeds_75_percent_of_buckets_capacity
    test = HashTable.new
    test.insert("Hello Hash", 5)
    test.insert('hello', 5)
    test.insert('good', 7)
    test.insert('haha', 10)
    test.insert('blah', 2)
    test.insert('foo', 3)
    test.insert('bar', 8)

    assert_equal(16, test.buckets)
  end

  def test_hash_table_resize_should_halve_the_number_of_buckets_when_the_size_drops_below_25_percent_of_buckets_capacity
    test = HashTable.new
    test.insert("Hello Hash", 5)
    test.insert('hello', 5)
    test.insert('good', 7)
    test.insert('haha', 10)
    test.insert('blah', 2)
    test.insert('foo', 3)
    test.insert('bar', 9)

    assert_equal(16, test.buckets)
    test.delete('hello');
    test.delete('good');
    test.delete('foo');
    test.delete('haha');
    test.delete('blah');

    assert_equal(8, test.buckets)
  end
end
