#####################
# Node class
#####################

class Node

  attr_accessor :value, :left_child, :right_child

  def initialize(value=nil)
    @value = value
    @left_child = nil
    @right_child = nil
  end

end

#####################
# BinarySearchTree class
#####################

class BinarySearchTree

  attr_accessor :root, :size

  def initialize
    @root = nil
    @size = 0
  end

  def insert(value)
    if @root.nil?
      @root = Node.new(value)
      @size += 1
    else
      findAndInsert = lambda do |current_node|
        if value > current_node.value
          if current_node.right_child.nil?
            current_node.right_child = Node.new(value)
          else
            findAndInsert.call(current_node.right_child)
          end
        elsif value < current_node.value
          if current_node.left_child.nil?
            current_node.left_child = Node.new(value)
          else
            findAndInsert.call(current_node.left_child)
          end
        end
      end
      findAndInsert.call(@root)
      @size += 1
    end
    p
  end

  # Binary search
  # Time Complexity: O(logn)
  # Auxiliary Space Complexity: O(1)
  def search(target)
    check = false
    traverse = lambda do |current_node|
      if current_node == nil
        return
      elsif current_node.value == target
        check = true
        return
      end
      if target > current_node.value 
        traverse.call(current_node.right_child)
      elsif target < current_node.value
        traverse.call(current_node.left_child)
      end
    end
    traverse.call(@root)
    check
  end

  def remove(deleteValue)
    temp = []

    # recursively populate a temp array with the values of the BST, except for the deleteValue
    roundUp = lambda do |current_node|
      if current_node == nil
        return
      end

      if current_node.value != deleteValue
        temp.push(current_node.value)
      end

      roundUp.call(current_node.right_child)
      roundUp.call(current_node.left_child)
    end

    roundUp.call(@root)

    if temp.length === self.size
      p "deleteValue $#{deleteValue} doesn't exist inside our tree."
    end

    # reset the BST by setting its root to nil and size to 0 
    self.root = nil
    self.size = 0

    # repopulate and return the BST with the temp array values
    temp.each { |val| self.insert(val) }
  end

  def method_missing(name, *args, &block)
    @self.send(name, *args, &block)
  end
end

############
# Unit Tests
############

require "test/unit"

class NodeClassTest < Test::Unit::TestCase

  def test_node_can_be_created
    test = Node.new

    assert_not_equal(nil, test)
    assert_equal(nil, test.value)
  end

  def test_node_can_hold_value
    test = Node.new(5)

    assert_equal(5, test.value)
    assert_equal(nil, test.left_child)
    assert_equal(nil, test.right_child)
  end

  def test_node_can_point_to_other_nodes_through_children
    test = Node.new(14)
    test_left = Node.new(20)
    test_right = Node.new(9422)
    test.left_child = test_left
    test.right_child = test_right

    assert_equal(test.left_child.value, test_left.value)
    assert_equal(test.right_child.value, test_right.value)
  end

end

class BinarySearchTreeTest < Test::Unit::TestCase

  def test_binary_search_can_be_created
    test = BinarySearchTree.new

    assert_not_equal(nil, test)
  end

  def test_binary_search_tree_properties_exist
    test = BinarySearchTree.new

    assert_respond_to(test, :root)
    assert_respond_to(test, :size)
  end

  def test_binary_search_tree_methods_exist
    test = BinarySearchTree.new

    assert_respond_to(test, :insert)
    assert_respond_to(test, :search)
    assert_respond_to(test, :remove)
  end

  def test_binary_search_tree_insert_children
    test = BinarySearchTree.new
    test.insert(7)
    test.insert(20)
    test.insert(4)

    assert_equal(7, test.root.value)
    assert_equal(4, test.root.left_child.value)
    assert_equal(20, test.root.right_child.value)
    assert_equal(nil, test.root.right_child.right_child)
    assert_equal(nil, test.root.right_child.left_child)
    assert_equal(nil, test.root.left_child.right_child)
    assert_equal(nil, test.root.left_child.left_child)
    assert_equal(3, test.size)
  end

  def test_binary_search_tree_search_method_node_exists
    test = BinarySearchTree.new
    values = [4,9,141,48,7]
    values.each { |val| test.insert(val) }

    assert_equal(true, test.search(48))
  end

  def test_binary_search_tree_search_method_node_does_not_exist
    test = BinarySearchTree.new
    values = [4,9,141,48,7]
    values.each { |val| test.insert(val) }

    assert_equal(false, test.search(8))
  end


  def test_binary_search_tree_remove_method_deletes_value
    test = BinarySearchTree.new()
    values = [4,9,141,48,7]

    values.each { |val| test.insert(val) }

    assert_equal(5, test.size)
    assert_equal(true, test.search(4))
    assert_equal(true, test.search(141))
    assert_equal(true, test.search(9))

    test.remove(4)
    assert_equal(4, test.size)
    assert_equal(false, test.search(4))
    assert_equal(true, test.search(7))
    assert_equal(true, test.search(141))
  end

end
