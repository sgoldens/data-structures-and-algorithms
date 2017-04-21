# LinkedLists.rb
#
# Author: Sasha Goldenson
#
# License: Free to use.
#
# Inspiration: Ron Tsui's (https://github.com/vokoshyv) guidance has been very helpful in guiding my understanding of some of these fundamentals. I credit
# him with for a good amount of the unit tests which serve as lines to work within. I have emulated his style, but the codingcoding solutions are mine.
#
# Motivation: Continuing my education, solidifying my fundamentals. Spreading the love.
#
#
# Linked Lists are one of the fundamental data structures taught in undergraduate Computer Science.
# Typically, they're initially made up of nodes which have two properties, a value and a pointer. 
#
# The node value is commonly an integer or string, but variations and expansions upon linked lists will incorporate other data types, like 
# additional linked lists whilst implementing a hash table with seperate chaining to handle collisions.
#
# The pointer of the node, it's other half, points to another node. This unidirectional chain creates what's called a Linked List.
#
# An example representation of a Linked List with a size of two, comprised of one head Node and one tail Node:
#
#                              Node (Head)                                                                            Node  (Tail)
#           { @value = 5  | pointer to @next = (a reference to ->->-)}->->   { value = 2 | pointer to @next = nil }
#
# All Linked Lists, unless circular, have a head and tail node, which can even be the same node in the case of a linked list comprised of one node.
#
# Our Linked List will also track its size.
#
# Linked Lists also require methods to modify and search through themselves. We'll use methods: insert(), remove(), append(), and contains().
#
# Let's start coding it by merit of unit tests to develop using Test-Driven Development
#
#
##########
# Unit Tests
##########

require 'test/unit'

class NodeClassTest < Test::Unit::TestCase
  def test_node_can_be_created
    test = Node.new()
    
    assert_not_equal(nil, test)
    assert_equal(nil, test.value)
  end

  def test_node_can_hold_value
    test = Node.new(5)

    assert_equal(5, test.value)
    assert_equal(nil, test.next)
  end

  def test_node_can_point_to_another_node
    first_node = Node.new(14)
    second_node = Node.new(20)
    first_node.next = second_node

    assert_equal(first_node.next.value, second_node.value)
  end
end

class LinkedListClassTest < Test::Unit::TestCase
  def test_linked_list_properties_exist_and_accessible
    test = LinkedList.new()

    assert_respond_to(test, :head)
    assert_respond_to(test, :tail)
    assert_respond_to(test, :size)
  end

  def test_linked_list_methods_exist 
    test = LinkedList.new()

    assert_respond_to(test, :append)
    assert_respond_to(test, :insert)
    assert_respond_to(test, :remove)
    assert_respond_to(test, :contains)
  end

  def test_linked_list_append_method_single_node 
    test = LinkedList.new()
    test.append(3)

    assert_equal(3, test.head.value)
    assert_equal(3, test.tail.value)
  end
  
  def test_linked_list_append_method_two_nodes
    test = LinkedList.new()
    test.append(4)
    test.append(11)

    assert_equal(4, test.head.value)
    assert_equal(11, test.tail.value)
  end
  
  def test_linked_list_insert_method_between_nodes
    test = LinkedList.new()
    test.append(4)
    test.append(11)
    test.insert(42, 1)

    assert_equal(4, test.head.value)
    assert_equal(11, test.tail.value)
    assert_equal(42, test.head.next.value)
  end
  
  def test_linked_list_insert_method_modify_tail
    test = LinkedList.new()
    test.append(2)
    test.append(5)
    test.append(9)
    test.insert(18, 3)

    assert_equal(2, test.head.value)
    assert_equal(18, test.tail.value)
    assert_equal(5, test.head.next.value)
    assert_equal(9, test.head.next.next.value)
  end

  def test_linked_list_insert_method_index_out_of_range
    test = LinkedList.new()
    test.append(2)
    test.append(4)
    test.insert(81, 3)

    assert_equal(2, test.head.value)
    assert_equal(4, test.head.next.value)
    assert_equal(4, test.tail.value)
    assert_equal(nil, test.tail.next)
    assert_equal(2, test.size)
  end

  def test_linked_list_remove_method_delete_middle
    test = LinkedList.new()
    test.append(2)
    test.append(4)
    test.append(7)
    test.remove(1)

    assert_equal(2, test.head.value)
    assert_equal(7, test.head.next.value)
    assert_equal(7, test.tail.value)
    assert_equal(nil, test.tail.next)
    assert_equal(2, test.size)
  end

  def test_linked_list_remove_method_delete_head
    test = LinkedList.new()
    test.append(2)
    test.append(4)
    test.append(7)
    test.remove(0)

    assert_equal(4, test.head.value)
    assert_equal(7, test.head.next.value)
    assert_equal(7, test.tail.value)
    assert_equal(nil, test.tail.next)
    assert_equal(2, test.size)
  end

  def test_linked_list_remove_method_delete_tail
    test = LinkedList.new()
    test.append(2)
    test.append(4)
    test.append(7)
    test.remove(2)

    assert_equal(2, test.head.value)
    assert_equal(4, test.head.next.value)
    assert_equal(4, test.tail.value)
    assert_equal(nil, test.tail.next)
    assert_equal(2, test.tail.size)
  end

  def test_linked_list_remove_method_no_delete_when_out_of_range
    test = LinkedList.new()
    test.append(2)
    test.append(4)
    test.append(7)
    test.remove(3)

    assert_equal(2, test.head.value)
    assert_equal(4, test.head.next.value)
    assert_equal(7, test.tail.value)
    assert_equal(nil, test.tail.next)
    assert_equal(2, test.size)
  end

  def test_linked_list_contains_method_when_true
    test = LinkedList.new()
    test.append(2)
    test.append(4)
    test.append(7)

    assert_equal(2, test.head.value)
    assert_equal(4, test.head.next.value)
    assert_equal(7, test.tail.value)
    assert_equal(nil, test.tail.next)
    assert_equal(true, test.contains(2))
    assert_equal(true, test.contains(4))
    assert_equal(true, test.contains(7))
  end

  def test_linked_list_contains_method_when_false
    test = LinkedList.new()
    test.append(2)
    test.append(4)
    test.append(7)

    assert_equal(2, test.head.value)
    assert_equal(4, test.head.next.value)
    assert_equal(7, test.tail.value)
    assert_equal(nil, test.tail.next)
    assert_equal(false, test.contains(9))
  end
end

###########
# Node Class
###########

class Node

  attr_accessor :value, :next

  def initialize(value = nil)
    @value = value
    @next   = nil
  end

end

###############
# LinkedList Class
###############

class LinkedList

  attr_accessor :head, :tail, :size

  def initialize
    @head  = nil
    @tail = nil
    @size = 0
  end

  # Time Complexity: O(1)
  # Auxiliary Space Complexity: O(1)
  def append(value)
    if self.size == 0
      # Initializing value being inserted into empty linked list
      self.head = Node.new(value)
      self.tail = self.head 
    else
      # Set the existing tail.next to the new appendage, and
      # set the tail to that new node. 
      self.tail.next = Node.new(value)
      self.tail = self.tail.next
    end
    # Add one to the linked list size
    self.size += 1
  end

  # Time Complexity: O(n)
  # Auxiliary Space Complexity: O(1)
  def insert(value, sIndex)
    current = self.head
    # make a counter starting at 1 
    counter = 1
    # check the current Node and that counter 
    # is smaller or equal to the search Index
    while current != nil && counter <= sIndex
      # check if counter is equal to the search Index
      if counter == sIndex
        # make a copy, tempNode, of the next at the sIndex
        tmpNode = current.next
        # set the current next to the newNode
        current.next = Node.new(value)
        # set the newNode's next to the copied tempNode
        current.next.next = tmpNode
        # if setting the tail value, the next value is empty
        if tmpNode == nil
          # so, set the tail to the newNode
          self.tail = current.next
        end
        # increment self.size
        self.size += 1
      end
      # traverse the current node to the next node for the next loop
      current = current.next
      # increment the counter
      counter += 1
    end
    return "Cannot insert value: #{value}, because searchIndex: #{sIndex} doesn't exist in this Linked List."
  end

  # Time Complexity: O(n)
  # Auxiliary Space Complexity: O(1) 
  def remove(location)
    # Case 1: Linked list contains a single element at location zero
    if self.size == 1 && location == 0
      self.head = nil
      self.tail = nil
      self.size -= 1
      return
    # Case 2: Linked list has more than one element, but we're still trying to remove the zeroth element
    elsif self.size > 1 && location == 0
      self.head = self.head.next
      self.size -= 1
      return
    # Case 3: Trying to remove the last element
    elsif location == (self.size -1)
      work = self.head
      counter = 0

      while work != nil
        if counter == location -1  && work.next != nil && work.next == self.tail
          work = work.next
          self.tail = work
          self.size -= 1
          return
        else
          counter += 1
        end
      end
  # Case 4: Trying to remove an element which is neither the head nor the tail of the linked list    
    # elsif location != 0 && location !=  (self.size -1) && work.next != nil
    #   work.next = work.next.next
    #   self.size -= 1
    #       return
    #     end
    #   end
    # end
    else
      return "Error: Index #{location} falls out of the range of the linked list."
    end
  end

  # Time Complexity: O(n)
  # Auxiliary Space Complexity: O(1) 
  def contains(value)
    work = self.head
    while work != nil
      if work.value == value
        return true
      end
      work = work.next
    end
    return false    
  end


end