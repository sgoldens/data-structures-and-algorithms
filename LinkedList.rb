# File: LinkedLists.rb
#
# Author: Sasha Goldenson
#
# License: Free to use
#
# Inspiration: Ron Tsui's (https://github.com/vokoshyv) excellent technical guidance has been very helpful in my understanding of these fundamentals.
#
# Motivation: Continuing my education, solidifying my fundamentals. Spreading the love.
#
# Test-Driven Development: Developed using 16 unit tests with a total of 60 assertions which describe and document this Linked List.
#
# Single-Linked Lists and Nodes:
# They are both fundamental data structures taught in Computer Science. A simple single Linked List is made up of nodes. Nodes are initialized with
# two necessary properties: a @value and a pointer, we'll call @next.
#
# The @value of a Node may be an integer or string, and more complex data structures which expand upon the Linked List will incorporate values of
# other data types, like objects. For example, a Hash Table can be implemented as a Linked List of Linked Lists, which is one way to enable a data
# collision strategy called seperate chaining where if two identical values are stored in the same location, they are both saved as individual objects
# within a Linked List or an array.
#
# The @next property of a Node (its pointer) points to another node by reference. The resulting unidirectional chain of Nodes is what populates
# our single Linked List.
#
# A single Linked List with a size of two, comprised of one head Node and one tail Node, looks something like this:
#
#              #<LinkedList:0x007fdb50999570
#                  @head=#<Node:0x007fdb50999548
#                                    @value=2,
#                                    @next=#<Node:0x007fdb509994f8
#                                                     @value=4,
#                                                     @next=nil>>,
#                  @tail=#<Node:0x007fdb509994f8
#                                 @value=4,
#                                 @next=nil>,
#                  @size=2>
#
# All Linked Lists, unless circular, have a head and tail node, which can also be the same node in the case of a Linked List comprised of one node.
# Our Linked List has a total of three properties: @head, @tail, and @size, to track its beginning, end, and size.
#
# Linked Lists also require methods to modify and search through themselves. We'll use methods: insert(), remove(), append(), and contains().
#
# Onto the code...
#
##########
# Unit Tests
##########

require 'test/unit'

class NodeClassTest < Test::Unit::TestCase
  def test_node_can_be_created
    test = Node.new

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
    test = LinkedList.new

    assert_respond_to(test, :head)
    assert_respond_to(test, :tail)
    assert_respond_to(test, :size)
  end

  def test_linked_list_methods_exist
    test = LinkedList.new

    assert_respond_to(test, :append)
    assert_respond_to(test, :insert)
    assert_respond_to(test, :remove)
    assert_respond_to(test, :contains)
  end

  def test_linked_list_append_method_single_node
    test = LinkedList.new
    test.append(3)

    assert_equal(3, test.head.value)
    assert_equal(3, test.tail.value)
  end

  def test_linked_list_append_method_two_nodes
    test = LinkedList.new
    test.append(4)
    test.append(11)

    assert_equal(4, test.head.value)
    assert_equal(11, test.tail.value)
  end

  def test_linked_list_insert_method_between_nodes
    test = LinkedList.new
    test.append(4)
    test.append(11)
    test.insert(42, 1)

    assert_equal(4, test.head.value)
    assert_equal(11, test.tail.value)
    assert_equal(42, test.head.next.value)
  end

  def test_linked_list_insert_method_modify_tail
    test = LinkedList.new
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
    test = LinkedList.new
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
    test = LinkedList.new
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
    test = LinkedList.new
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
    test = LinkedList.new
    test.append(2)
    test.append(1)
    test.append(4)
    test.remove(1)

    assert_equal(2, test.head.value)
    assert_equal(4, test.head.next.value)
    assert_equal(4, test.tail.value)
    assert_equal(nil, test.tail.next)
    assert_equal(2, test.size)
  end

  def test_linked_list_remove_method_no_delete_when_out_of_range
    test = LinkedList.new
    test.append(2)
    test.append(4)
    test.append(7)
    test.remove(3)

    assert_equal(2, test.head.value)
    assert_equal(4, test.head.next.value)
    assert_equal(7, test.tail.value)
    assert_equal(nil, test.tail.next)
    assert_equal(3, test.size)
  end

  def test_linked_list_contains_method_when_true
    test = LinkedList.new
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
    test = LinkedList.new
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
    @next = nil
  end
end

###############
# LinkedList Class
###############

class LinkedList
  attr_accessor :head, :tail, :size

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  # Time Complexity: O(1)
  # Auxiliary Space Complexity: O(1)
  def append(value)
    if size == 0
      # Initializing value being inserted into empty linked list
      self.head = Node.new(value)
      self.tail = head
    else
      # Set the existing tail.next to the new appendage, and
      # set the tail to that new node.
      tail.next = Node.new(value)
      self.tail = tail.next
    end
    # Add one to the linked list size
    self.size += 1
  end

  # Time Complexity: O(n)
  # Auxiliary Space Complexity: O(1)
  def insert(value, sIndex)
    current = head
    # make a counter starting at 1
    counter = 1
    # check the current Node and that counter
    # is smaller or equal to the search Index
    while !current.nil? && counter <= sIndex
      # check if counter is equal to the search Index
      if counter == sIndex
        # make a copy, tempNode, of the next at the sIndex
        tmpNode = current.next
        # set the current next to the newNode
        current.next = Node.new(value)
        # set the newNode's next to the copied tempNode
        current.next.next = tmpNode
        # if setting the tail value, the next value is empty
        if tmpNode.nil?
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
    "Cannot insert value: #{value}, because searchIndex: #{sIndex} doesn't exist in this Linked List."
  end

  # Time Complexity: O(n)
  # Auxiliary Space Complexity: O(1)
  def remove(location)
    # Case 1: Trying to remove an element at an index which is out of range
    if location >= self.size
      "Cannot remove location: #{location}, because it is out of range and doesn't exist in this Linked List."
    # Case 2: Linked list contains a single element at location zero
    elsif self.size == 1
      self.head = nil
      self.tail = nil
      self.size -= 1
      nil
    # Case 3: Linked list has more than one element, but we're still trying to remove the zeroth element
    elsif location == 0
      self.head = head.next
      self.size -= 1
      nil
    # Case 4: Trying to remove the last element
    elsif location == (self.size - 1)
      work = head
      counter = 1

      until work.nil?
        if counter == (location - 1) && work.next == tail
          self.tail = work
          self.size -= 1
          return
        end
        counter += 1
      end
    # Case 5: Trying to remove an element which is neither the head nor the tail of the linked list
    elsif location != 0 && location != self.size
      work = head
      counter = 1

      while !work.next.nil? && !work.next.next.nil? && counter <= location
        if location == counter
          work.next = work.next.next
          self.size -= 1
          return
        end
        counter += 1
      end
    end
  end

  # Time Complexity: O(n)
  # Auxiliary Space Complexity: O(1)
  def contains(value)
    work = head
    until work.nil?
      return true if work.value == value
      work = work.next
    end
    false
  end
end
